import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:secure_stream_docs/features/video_player/domain/entities/video.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/get_or_create_video.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/get_last_playback_position.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/update_playback_position.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/clear_playback_position.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/save_custom_url.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/delete_custom_url.dart';
import 'package:secure_stream_docs/features/video_player/domain/usecases/params.dart';

part 'video_player_event.dart';
part 'video_player_state.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  final GetOrCreateVideoUseCase getOrCreateVideo;
  final GetLastPlaybackPositionUseCase getLastPlaybackPosition;
  final UpdatePlaybackPositionUseCase updatePlaybackPosition;
  final ClearPlaybackPositionUseCase clearPlaybackPosition;
  final SaveCustomUrlUseCase saveCustomUrl;
  final DeleteCustomUrlUseCase deleteCustomUrl;

  VideoPlayerBloc({
    required this.getOrCreateVideo,
    required this.getLastPlaybackPosition,
    required this.updatePlaybackPosition,
    required this.clearPlaybackPosition,
    required this.saveCustomUrl,
    required this.deleteCustomUrl,
  }) : super(VideoPlayerInitial()) {
    on<LoadVideo>(_onLoadVideo);
    on<SavePlaybackPosition>(_onSavePlayback);
    on<ClearPlaybackPosition>(_onClearPlayback);
    on<AddCustomUrl>(_onAddCustomUrl);
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
  // Add Custom URL (fire-and-forget — no state emission)
  //
  // Persists the URL to Isar so it can be recalled later.
  // Does NOT emit any state — the player continues playing
  // uninterrupted. Errors are silently swallowed because
  // URL persistence is a non-critical background operation.
  // ─────────────────────────────────────────────
  Future<void> _onAddCustomUrl(
    AddCustomUrl event,
    Emitter<VideoPlayerState> emit,
  ) async {
    try {
      await saveCustomUrl(UrlParams(event.url));
    } catch (_) {
      // Silent fail for background persistence
    }
  }

  // ─────────────────────────────────────────────
  // Delete Custom URL (fire-and-forget)
  // ─────────────────────────────────────────────
  Future<void> _onDeleteCustomUrl(
    DeleteCustomUrl event,
    Emitter<VideoPlayerState> emit,
  ) async {
    try {
      await deleteCustomUrl(UrlParams(event.url));
    } catch (_) {
      // Silent fail for background deletion
    }
  }
}
