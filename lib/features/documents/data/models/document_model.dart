import 'package:isar_community/isar.dart';
import 'package:secure_stream_docs/features/documents/domain/entities/document.dart';

part 'document_model.g.dart';

@collection
class DocumentModel {
  Id id = Isar.autoIncrement;

  late String docId;
  late String name;
  late String url;

  bool isDownloaded = false;
  String? localPath;
  double progress = 0;

  // ── Mapper ─────────────────────

  Document toEntity() {
    return Document(
      id: docId,
      name: name,
      url: url,
      isDownloaded: isDownloaded,
      isDownloading: false,
      localPath: localPath,
      progress: progress,
    );
  }

  static DocumentModel fromEntity(Document doc) {
    return DocumentModel()
      ..docId = doc.id
      ..name = doc.name
      ..url = doc.url
      ..isDownloaded = doc.isDownloaded
      ..localPath = doc.localPath
      ..progress = doc.progress;
  }
}
