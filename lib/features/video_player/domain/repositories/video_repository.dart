import 'package:secure_stream_docs/core/utils/types/typedef.dart';
import 'package:secure_stream_docs/features/video_player/domain/entities/video.dart'
    show Video;

abstract class VideoRepository {
  // ─────────────────────────────────────────────────────────────────────────
  /// Get or create video entity
  // ─────────────────────────────────────────────────────────────────────────
  EitherFailure<Video> getOrCreateVideo(String url);

  // ─────────────────────────────────────────────────────────────────────────
  /// Update playback position
  // ─────────────────────────────────────────────────────────────────────────
  EitherUnit updatePlaybackPosition(String url, int positionMs);

  // ─────────────────────────────────────────────────────────────────────────
  /// Get last playback position
  // ─────────────────────────────────────────────────────────────────────────
  EitherFailure<int> getLastPosition(String url);

  // ─────────────────────────────────────────────────────────────────────────
  /// Clear playback position
  // ─────────────────────────────────────────────────────────────────────────
  EitherUnit clearPlaybackPosition(String url);

  // ─────────────────────────────────────────────────────────────────────────
  /// Save custom URL
  // ─────────────────────────────────────────────────────────────────────────
  EitherUnit saveCustomUrl(String url);

  // ─────────────────────────────────────────────────────────────────────────
  /// Delete custom URL
  // ─────────────────────────────────────────────────────────────────────────
  EitherUnit deleteCustomUrl(String url);
}
