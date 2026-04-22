import 'package:isar_community/isar.dart';
import 'package:secure_stream_docs/features/video_player/domain/entities/video.dart';

part 'video_model.g.dart';

@collection
class VideoModel {
  Id id = Isar.autoIncrement;

  late String url;
  String? title;
  String? description;
  late int lastPositionMs;
  late bool isUserProvided;
  DateTime? updatedAt;

  // ── Convert Entity → Model ─────────────────────

  static VideoModel fromEntity(Video video) {
    return VideoModel()
      ..url = video.url
      ..title = video.title
      ..description = video.description
      ..lastPositionMs = video.lastPositionMs
      ..isUserProvided = video.isUserProvided
      ..updatedAt = video.updatedAt;
  }

  // ── Convert Model → Entity ─────────────────────

  Video toEntity() {
    return Video(
      url: url,
      title: title,
      description: description,
      lastPositionMs: lastPositionMs,
      isUserProvided: isUserProvided,
      updatedAt: updatedAt,
    );
  }
}
