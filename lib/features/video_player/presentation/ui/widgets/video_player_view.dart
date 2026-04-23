import 'dart:async';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:secure_stream_docs/core/ui/themes/app_colors.dart';
import 'package:secure_stream_docs/core/ui/themes/app_sizes.dart';
import 'package:secure_stream_docs/core/ui/themes/app_text_theme.dart';
import 'package:secure_stream_docs/core/utils/helpers/video_error_mapper.dart';
import 'package:secure_stream_docs/features/video_player/domain/entities/video.dart';
import 'package:secure_stream_docs/features/video_player/presentation/logic/bloc/video_player_bloc.dart';
import 'video_buffering_overlay.dart';

class VideoPlayerView extends StatefulWidget {
  final Video video;
  final int initialPositionMs;

  const VideoPlayerView({
    super.key,
    required this.video,
    this.initialPositionMs = 0,
  });

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView>
    with WidgetsBindingObserver {
  BetterPlayerController? _controller;
  bool _isBuffering = false;
  bool _isPlaying = false;
  Timer? _debounceTimer;
  late final VideoPlayerBloc _videoPlayerBloc;

  @override
  void initState() {
    super.initState();
    _onInit();
    WidgetsBinding.instance.addObserver(this);
    _initPlayer();
  }

  void _onInit() {
    _videoPlayerBloc = context.read<VideoPlayerBloc>();
  }

  @override
  void dispose() {
    _forceSavePosition();
    _debounceTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _disposePlayer();
    super.dispose();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // didUpdateWidget — handles URL change while the widget stays mounted.
  //
  // When the BLoC emits a new VideoPlayerReady with a different URL
  // (e.g. user loads a custom stream),
  // rebuilds this widget with a new `video` prop but does NOT call
  // dispose → initState. Without this override the old controller
  // would keep playing the previous stream.
  //
  // Flow: save current position → dispose old controller → reset local
  //       flags → init a fresh controller for the new URL.
  // ─────────────────────────────────────────────────────────────────────────
  @override
  void didUpdateWidget(covariant VideoPlayerView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.video.url != widget.video.url) {
      _forceSavePosition();
      _disposePlayer();
      _resetState();
      _initPlayer();
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // didChangeAppLifecycleState — persists playback position when the app
  // goes to background (paused) or loses focus (inactive).
  //
  // Without this, the user would lose their resume position if the OS
  // kills the app while it's backgrounded, because the debounce timer
  // and dispose() may never fire in that scenario.
  // ─────────────────────────────────────────────────────────────────────────
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _forceSavePosition();
    }
  }

  void _resetState() {
    _isBuffering = false;
    _isPlaying = false;
    _debounceTimer?.cancel();
  }

  void _initPlayer() {
    final dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.video.url,
      videoFormat: BetterPlayerVideoFormat.hls,
      cacheConfiguration: const BetterPlayerCacheConfiguration(
        useCache: true,
        preCacheSize: 10 * 1024 * 1024,
        maxCacheSize: 100 * 1024 * 1024,
        maxCacheFileSize: 50 * 1024 * 1024,
      ),
      bufferingConfiguration: const BetterPlayerBufferingConfiguration(
        minBufferMs: 15000,
        maxBufferMs: 50000,
        bufferForPlaybackMs: 2500,
        bufferForPlaybackAfterRebufferMs: 5000,
      ),
    );

    _controller = BetterPlayerController(
      BetterPlayerConfiguration(
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
        autoPlay: widget.initialPositionMs <= 0,
        startAt: widget.initialPositionMs > 0
            ? Duration(milliseconds: widget.initialPositionMs)
            : null,

        autoDetectFullscreenDeviceOrientation: true,
        deviceOrientationsOnFullScreen: const [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ],
        deviceOrientationsAfterFullScreen: const [DeviceOrientation.portraitUp],
        systemOverlaysAfterFullScreen: SystemUiOverlay.values,

        controlsConfiguration: BetterPlayerControlsConfiguration(
          playerTheme: BetterPlayerTheme.material,
          loadingWidget: const SizedBox.shrink(),
          enablePlayPause: true,
          enableMute: true,
          enableFullscreen: true,
          enableProgressBar: true,
          enableProgressBarDrag: true,
          enableProgressText: true,
          enableSkips: true,
          enableQualities: true,
          progressBarPlayedColor: AppColors.primary,
          progressBarHandleColor: AppColors.primary,
          progressBarBufferedColor: Colors.white54,
          progressBarBackgroundColor: Colors.white24,
          controlBarColor: Colors.black54,
          iconsColor: Colors.white,
          playIcon: Icons.play_arrow_rounded,
          pauseIcon: Icons.pause_rounded,
          muteIcon: Icons.volume_up_rounded,
          unMuteIcon: Icons.volume_off_rounded,
          fullscreenEnableIcon: Icons.fullscreen_rounded,
          fullscreenDisableIcon: Icons.fullscreen_exit_rounded,
          skipBackIcon: Icons.replay_10_rounded,
          skipForwardIcon: Icons.forward_10_rounded,
          forwardSkipTimeInMilliseconds: 10000,
          backwardSkipTimeInMilliseconds: 10000,
          showControlsOnInitialize: true,
          controlsHideTime: const Duration(seconds: 3),
        ),
        errorBuilder: (context, errorMessage) =>
            _buildPlayerErrorWidget(context, errorMessage),
        handleLifecycle: true,
        autoDispose: false,
      ),
      betterPlayerDataSource: dataSource,
    );

    _controller!.addEventsListener(_onPlayerEvent);
  }

  void _onPlayerEvent(BetterPlayerEvent event) {
    if (!mounted) return;

    switch (event.betterPlayerEventType) {
      case BetterPlayerEventType.bufferingStart:
        _setBuffering(true);
        break;

      case BetterPlayerEventType.bufferingEnd:
        _setBuffering(false);
        break;

      case BetterPlayerEventType.play:
        _setPlaying(true);
        break;

      case BetterPlayerEventType.pause:
      case BetterPlayerEventType.finished:
        _setPlaying(false);
        _forceSavePosition();
        break;

      case BetterPlayerEventType.seekTo:
        _forceSavePosition();
        break;

      case BetterPlayerEventType.progress:
        _onProgress(event);
        break;

      default:
        break;
    }
  }

  void _setBuffering(bool value) {
    if (_isBuffering != value) {
      setState(() => _isBuffering = value);
    }
  }

  void _setPlaying(bool value) {
    if (_isPlaying != value) {
      setState(() => _isPlaying = value);
    }
  }

  void _onProgress(BetterPlayerEvent event) {
    final progress = event.parameters?['progress'];

    if (progress is! Duration) return;

    final positionMs = progress.inMilliseconds;

    if (positionMs <= 0 || !_isPlaying) return;

    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(seconds: 5), () {
      if (!mounted) return;

      _videoPlayerBloc.add(
        SavePlaybackPosition(url: widget.video.url, positionMs: positionMs),
      );
    });
  }

  void _forceSavePosition() {
    final controller = _controller;
    if (controller == null) return;

    final positionMs =
        controller.videoPlayerController?.value.position.inMilliseconds ?? 0;

    if (positionMs <= 0) return;

    _videoPlayerBloc.add(
      SavePlaybackPosition(url: widget.video.url, positionMs: positionMs),
    );
  }

  Widget _buildPlayerErrorWidget(BuildContext context, String? message) {
    return Container(
      color: AppColors.darkSurface,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: AppSizses.xl2.sp,
              color: AppColors.error,
            ),
            AppSizses.height(AppSizses.m),
            Text(
              VideoErrorMapper.getUserFriendlyError(message),
              textAlign: TextAlign.center,
              style: AppTextStyle.bodyMedium(
                context,
              )?.copyWith(color: Colors.white70),
            ),
            AppSizses.height(AppSizses.l),
            OutlinedButton.icon(
              onPressed: () {
                _disposePlayer();
                _resetState();
                _initPlayer();
                if (mounted) setState(() {});
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white54),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _disposePlayer() {
    _controller?.removeEventsListener(_onPlayerEvent);
    _controller?.dispose();
    _controller = null;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (_controller != null)
            BetterPlayer(controller: _controller!)
          else
            Container(
              color: AppColors.darkSurface,
              child: Center(
                child: Icon(
                  Icons.videocam_rounded,
                  size: AppSizses.xxl.sp,
                  color: Colors.white24,
                ),
              ),
            ),
          VideoBufferingOverlay(isBuffering: _isBuffering),
        ],
      ),
    );
  }
}
