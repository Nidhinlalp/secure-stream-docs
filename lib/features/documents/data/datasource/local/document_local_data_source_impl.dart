import 'package:isar_community/isar.dart';
import 'package:secure_stream_docs/core/local/local_storage_client.dart';
import 'package:secure_stream_docs/features/documents/data/datasource/local/document_local_data_source.dart';
import 'package:secure_stream_docs/features/documents/data/models/document_model.dart';
import 'package:secure_stream_docs/features/documents/data/models/highlight_model.dart';

class DocumentLocalDataSourceImpl implements DocumentLocalDataSource {
  final LocalStorageClient _storage;

  DocumentLocalDataSourceImpl({required LocalStorageClient storage})
    : _storage = storage;

  // ─────────────────────────────────────────────────────────────────────────
  // Get all documents from local storage.
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<List<DocumentModel>> getDocuments() async {
    return await _storage.isar.documentModels.where().findAll();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Save a document to local storage.
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<void> saveDocument(DocumentModel model) async {
    await _storage.isar.writeTxn(() async {
      await _storage.isar.documentModels.put(model);
    });
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Get a document from local storage by ID.
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<DocumentModel?> getDocument(String docId) async {
    return await _storage.isar.documentModels
        .filter()
        .docIdEqualTo(docId)
        .findFirst();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Delete a document from local storage.
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<void> deleteDocument(String docId) async {
    await _storage.isar.writeTxn(() async {
      final doc = await _storage.isar.documentModels
          .filter()
          .docIdEqualTo(docId)
          .findFirst();

      if (doc != null) {
        await _storage.isar.documentModels.delete(doc.id);
      }
    });
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Save a highlight to local storage.
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<void> saveHighlight(HighlightModel model) async {
    await _storage.isar.writeTxn(() async {
      await _storage.isar.highlightModels.put(model);
    });
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Get all highlights for a document from local storage.
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<List<HighlightModel>> getHighlights(String docId) async {
    return await _storage.isar.highlightModels
        .filter()
        .docIdEqualTo(docId)
        .findAll();
  }
}
