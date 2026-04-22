import 'package:secure_stream_docs/core/utils/types/typedef.dart';
import 'package:secure_stream_docs/features/documents/domain/entities/document.dart';
import 'package:secure_stream_docs/features/documents/domain/entities/highlight.dart';

abstract class DocumentRepository {
  // ─────────────────────────────────────────────────────────────────────────
  // Get all documents from local + remote storage.
  // ─────────────────────────────────────────────────────────────────────────
  EitherFailure<List<Document>> getDocuments();

  // ─────────────────────────────────────────────────────────────────────────
  // Download a document with progress.
  // ─────────────────────────────────────────────────────────────────────────
  EitherStream<Document> downloadDocument(String id);

  // ─────────────────────────────────────────────────────────────────────────
  // Get a local document by ID.
  // ─────────────────────────────────────────────────────────────────────────
  EitherFailure<Document> getDocument(String id);

  // ─────────────────────────────────────────────────────────────────────────
  // Delete a document.
  // ─────────────────────────────────────────────────────────────────────────
  EitherUnit deleteDocument(String id);

  // ─────────────────────────────────────────────────────────────────────────
  // Save a highlight.
  // ─────────────────────────────────────────────────────────────────────────
  EitherUnit saveHighlight(String docId, Highlight highlight);

  // ─────────────────────────────────────────────────────────────────────────
  // Get all highlights for a document.
  // ─────────────────────────────────────────────────────────────────────────
  EitherFailure<List<Highlight>> getHighlights(String docId);
}
