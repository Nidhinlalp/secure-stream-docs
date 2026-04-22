import 'package:secure_stream_docs/features/documents/data/models/document_model.dart';
import 'package:secure_stream_docs/features/documents/data/models/highlight_model.dart';

abstract class DocumentLocalDataSource {
  // ─────────────────────────────────────────────────────────────────────────
  // Get all documents from local storage.
  // ─────────────────────────────────────────────────────────────────────────
  Future<List<DocumentModel>> getDocuments();

  // ─────────────────────────────────────────────────────────────────────────
  // Save a document to local storage.
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> saveDocument(DocumentModel model);

  // ─────────────────────────────────────────────────────────────────────────
  // Get a document from local storage by ID.
  // ─────────────────────────────────────────────────────────────────────────
  Future<DocumentModel?> getDocument(String docId);

  // ─────────────────────────────────────────────────────────────────────────
  // Delete a document from local storage.
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> deleteDocument(String docId);

  // ─────────────────────────────────────────────────────────────────────────
  // Save a highlight to local storage.
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> saveHighlight(HighlightModel model);

  // ─────────────────────────────────────────────────────────────────────────
  // Get all highlights for a document from local storage.
  // ─────────────────────────────────────────────────────────────────────────
  Future<List<HighlightModel>> getHighlights(String docId);

  // ─────────────────────────────────────────────────────────────────────────
  // Delete all highlights for a document from local storage.
  // Called as part of the cascade-delete when a document is removed.
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> deleteHighlights(String docId);
}
