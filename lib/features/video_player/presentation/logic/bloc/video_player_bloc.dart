import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:secure_stream_docs/features/video_player/domain/entities/video.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/get_or_create_video.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/get_last_playback_position.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/update_playback_position.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/clear_playback_position.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/save_custom_url.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/get_custom_urls.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/delete_custom_url.dart';
import 'package:secure_stream_docs/core/usecases/usecase.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/params.dart';

part 'video_player_event.dart';
part 'video_player_state.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  final GetOrCreateVideoUseCase getOrCreateVideo;
  final GetLastPlaybackPositionUseCase getLastPlaybackPosition;
  final UpdatePlaybackPositionUseCase updatePlaybackPosition;
  final ClearPlaybackPositionUseCase clearPlaybackPosition;
  final SaveCustomUrlUseCase saveCustomUrl;
  final GetCustomUrlsUseCase getCustomUrls;
  final DeleteCustomUrlUseCase deleteCustomUrl;

  VideoPlayerBloc({
    required this.getOrCreateVideo,
    required this.getLastPlaybackPosition,
    required this.updatePlaybackPosition,
    required this.clearPlaybackPosition,
    required this.saveCustomUrl,
    required this.getCustomUrls,
    required this.deleteCustomUrl,
  }) : super(VideoPlayerInitial()) {
    on<LoadVideo>(_onLoadVideo);
    on<SavePlaybackPosition>(_onSavePlayback);
    on<ClearPlaybackPosition>(_onClearPlayback);
    on<AddCustomUrl>(_onAddCustomUrl);
    on<LoadCustomUrls>(_onLoadCustomUrls);
    on<DeleteCustomUrl>(_onDeleteCustomUrl);
  }

  // ─────────────────────────────────────────────
  // Load Video + Resume Position
  // ─────────────────────────────────────────────
  Future<void> _onLoadVideo(
    LoadVideo event,
    Emitter<VideoPlayerState> emit,
  ) async {
    emit(VideoPlayerLoading());

    try {
      final videoResult = await getOrCreateVideo(UrlParams(event.url));

      await videoResult.fold(
        (failure) async {
          emit(VideoPlayerError(failure.message));
        },
        (video) async {
          final positionResult = await getLastPlaybackPosition(
            UrlParams(event.url),
          );
          positionResult.fold(
            (failure) {
              emit(VideoPlayerError(failure.message));
            },
            (position) {
              emit(VideoPlayerReady(video, positionMs: position));
            },
          );
        },
      );
    } catch (e) {
      emit(VideoPlayerError(e.toString()));
    }
  }

  // ─────────────────────────────────────────────
  // Save Playback Position
  // ─────────────────────────────────────────────
  Future<void> _onSavePlayback(
    SavePlaybackPosition event,
    Emitter<VideoPlayerState> emit,
  ) async {
    try {
      await updatePlaybackPosition(
        PlaybackParams(url: event.url, positionMs: event.positionMs),
      );
    } catch (e) {
      // Silent fail for background save operations
      // Optionally log error
    }
  }

  // ─────────────────────────────────────────────
  // Clear Playback
  // ─────────────────────────────────────────────
  Future<void> _onClearPlayback(
    ClearPlaybackPosition event,
    Emitter<VideoPlayerState> emit,
  ) async {
    try {
      await clearPlaybackPosition(UrlParams(event.url));

      // reload video from start
      add(LoadVideo(event.url));
    } catch (e) {
      emit(VideoPlayerError(e.toString()));
    }
  }

  // ─────────────────────────────────────────────
  // Add Custom URL
  // ─────────────────────────────────────────────
  Future<void> _onAddCustomUrl(
    AddCustomUrl event,
    Emitter<VideoPlayerState> emit,
  ) async {
    try {
      final result = await saveCustomUrl(UrlParams(event.url));

      result.fold(
        (failure) {
          emit(VideoPlayerError(failure.message));
        },
        (_) {
          // Success - optionally reload URLs
          add(LoadCustomUrls());
        },
      );
    } catch (e) {
      emit(VideoPlayerError(e.toString()));
    }
  }

  // ─────────────────────────────────────────────
  // Load Custom URLs
  // ─────────────────────────────────────────────
  Future<void> _onLoadCustomUrls(
    LoadCustomUrls event,
    Emitter<VideoPlayerState> emit,
  ) async {
    emit(VideoPlayerLoading());

    try {
      final result = await getCustomUrls(const NoParams());

      result.fold(
        (failure) {
          emit(VideoPlayerError(failure.message));
        },
        (urls) {
          emit(CustomUrlsLoaded(urls));
        },
      );
    } catch (e) {
      emit(VideoPlayerError(e.toString()));
    }
  }

  // ─────────────────────────────────────────────
  // Delete Custom URL
  // ─────────────────────────────────────────────
  Future<void> _onDeleteCustomUrl(
    DeleteCustomUrl event,
    Emitter<VideoPlayerState> emit,
  ) async {
    try {
      final result = await deleteCustomUrl(UrlParams(event.url));

      result.fold(
        (failure) {
          emit(VideoPlayerError(failure.message));
        },
        (_) {
          // Reload the list
          add(LoadCustomUrls());
        },
      );
    } catch (e) {
      emit(VideoPlayerError(e.toString()));
    }
  }
}
