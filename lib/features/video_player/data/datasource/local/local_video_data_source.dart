import 'package:secure_stream_docs/features/video_player/data/models/video_model.dart';

abstract class LocalVideoDataSource {
  // ─────────────────────────────────────────────────────────────────────────
  /// Get video or create if not exists
  // ─────────────────────────────────────────────────────────────────────────
  Future<VideoModel> getOrCreateVideo(String url);

  // ─────────────────────────────────────────────────────────────────────────
  /// Update playback position
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> updatePlaybackPosition(String url, int positionMs);

  // ─────────────────────────────────────────────────────────────────────────
  /// Get last playback position
  // ─────────────────────────────────────────────────────────────────────────
  Future<int> getLastPosition(String url);

  // ─────────────────────────────────────────────────────────────────────────
  /// Clear playback position
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> clearPlaybackPosition(String url);

  // ─────────────────────────────────────────────────────────────────────────
  /// Save custom URL
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> saveCustomUrl(String url);

  // ─────────────────────────────────────────────────────────────────────────
  /// Delete custom URL
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> deleteCustomUrl(String url);
}
