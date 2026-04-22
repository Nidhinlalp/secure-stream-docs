import 'package:secure_stream_docs/features/documents/data/models/document_model.dart';

abstract class DocumentRemoteDataSource {
  // ─────────────────────────────────────────────────────────────────────────
  // Download PDF from remote server.
  // ─────────────────────────────────────────────────────────────────────────
  Stream<double> downloadFile({required String url, required String savePath});

  // ─────────────────────────────────────────────────────────────────────────
  // Fetch list of documents from remote server.
  // ─────────────────────────────────────────────────────────────────────────
  Future<List<DocumentModel>> fetchDocuments();
}
