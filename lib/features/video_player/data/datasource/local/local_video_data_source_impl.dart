import 'package:isar_community/isar.dart';
import 'package:secure_stream_docs/core/local/local_storage_client.dart';
import 'package:secure_stream_docs/features/video_player/data/datasource/local/local_video_data_source.dart';
import 'package:secure_stream_docs/features/video_player/data/models/video_model.dart';

class LocalVideoDataSourceImpl implements LocalVideoDataSource {
  final LocalStorageClient storage;

  LocalVideoDataSourceImpl({required this.storage});

  /// Get or create video
  @override
  Future<VideoModel> getOrCreateVideo(String url) async {
    return await storage.isar.writeTxn(() async {
      final existing = await storage.isar.videoModels
          .filter()
          .urlEqualTo(url)
          .findFirst();

      if (existing != null) return existing;

      final newVideo = VideoModel()
        ..url = url
        ..lastPositionMs = 0
        ..isUserProvided = true
        ..updatedAt = DateTime.now();

      await storage.isar.videoModels.put(newVideo);

      return newVideo;
    });
  }

  /// Update playback
  @override
  Future<void> updatePlaybackPosition(String url, int positionMs) async {
    await storage.isar.writeTxn(() async {
      final video = await storage.isar.videoModels
          .filter()
          .urlEqualTo(url)
          .findFirst();

      if (video == null) return;

      video.lastPositionMs = positionMs;
      video.updatedAt = DateTime.now();

      await storage.isar.videoModels.put(video);
    });
  }

  /// Get last position
  @override
  Future<int> getLastPosition(String url) async {
    final video = await storage.isar.videoModels
        .filter()
        .urlEqualTo(url)
        .findFirst();

    return video?.lastPositionMs ?? 0;
  }

  /// Clear playback
  @override
  Future<void> clearPlaybackPosition(String url) async {
    await storage.isar.writeTxn(() async {
      final video = await storage.isar.videoModels
          .filter()
          .urlEqualTo(url)
          .findFirst();

      if (video == null) return;

      video.lastPositionMs = 0;
      video.updatedAt = DateTime.now();

      await storage.isar.videoModels.put(video);
    });
  }

  /// Save custom URL
  @override
  Future<void> saveCustomUrl(String url) async {
    await getOrCreateVideo(url);
  }

  /// Delete custom URL
  @override
  Future<void> deleteCustomUrl(String url) async {
    await storage.isar.writeTxn(() async {
      final video = await storage.isar.videoModels
          .filter()
          .urlEqualTo(url)
          .findFirst();

      if (video != null) {
        await storage.isar.videoModels.delete(video.id);
      }
    });
  }
}
