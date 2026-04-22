import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:secure_stream_docs/core/error/error_mapper.dart';
import 'package:secure_stream_docs/core/error/failures.dart';
import 'package:secure_stream_docs/core/security/file_encryption_service.dart';
import 'package:secure_stream_docs/core/utils/types/typedef.dart';
import 'package:secure_stream_docs/features/documents/data/datasource/local/document_local_data_source.dart';
import 'package:secure_stream_docs/features/documents/data/datasource/remote/document_remote_data_source.dart';
import 'package:secure_stream_docs/features/documents/data/models/document_model.dart';
import 'package:secure_stream_docs/features/documents/data/models/highlight_model.dart';
import 'package:secure_stream_docs/features/documents/domain/entities/document.dart';
import 'package:secure_stream_docs/features/documents/domain/entities/highlight.dart';
import 'package:secure_stream_docs/features/documents/domain/repositories/document_repository.dart';
import 'package:uuid/uuid.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentRemoteDataSource _remote;
  final DocumentLocalDataSource _local;
  final FileEncryptionService _encryptionService;

  DocumentRepositoryImpl({
    required DocumentRemoteDataSource remote,
    required DocumentLocalDataSource local,
    required FileEncryptionService encryptionService,
  }) : _remote = remote,
       _local = local,
       _encryptionService = encryptionService;

  // ─────────────────────────────────────────────────────────────────────────
  // Get all documents (merge remote metadata with local download state)
  // ─────────────────────────────────────────────────────────────────────────
  @override
  EitherFailure<List<Document>> getDocuments() async {
    try {
      final remoteDocuments = await _remote.fetchDocuments();
      final localDocuments = await _local.getDocuments();

      final localDocMap = <String, DocumentModel>{};
      for (final localDoc in localDocuments) {
        localDocMap[localDoc.docId] = localDoc;
      }

      final mergedDocuments = remoteDocuments.map((remoteDoc) {
        final localDoc = localDocMap[remoteDoc.docId];
        if (localDoc != null) {
          return Document(
            id: remoteDoc.docId,
            name: remoteDoc.name,
            url: remoteDoc.url,
            isDownloaded: localDoc.isDownloaded,
            isDownloading: false,
            localPath: localDoc.localPath,
            progress: localDoc.progress,
          );
        } else {
          return remoteDoc.toEntity();
        }
      }).toList();

      return Right(mergedDocuments);
    } catch (e) {
      return Left(ErrorMapper.map(e));
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Download  →  encrypt  →  save encrypted path to Isar
  //
  // Flow:
  //  1. Download raw PDF to a TEMP path
  //  2. Encrypt temp file → write ciphertext to final .enc path
  //  3. Delete temp file (raw PDF never persists)
  //  4. Mark isDownloaded = true with the encrypted path in Isar
  // ─────────────────────────────────────────────────────────────────────────
  @override
  EitherStream<Document> downloadDocument(String id) async* {
    File? tempFile;
    try {
      final remoteDocuments = await _remote.fetchDocuments();
      final docModel = remoteDocuments.firstWhere(
        (doc) => doc.docId == id,
        orElse: () => throw Exception('Document not found: $id'),
      );

      final appDir = await getApplicationDocumentsDirectory();
      final uuid = const Uuid().v4();
      final tempPath = '${appDir.path}/${uuid}_temp.pdf';
      final encryptedPath = '${appDir.path}/$uuid.enc';

      // ── Step 1: Download to temp ─────────────────────────────────────────
      await for (final progress in _remote.downloadFile(
        url: docModel.url,
        savePath: tempPath,
      )) {
        yield Right(
          docModel.toEntity().copyWith(progress: progress, isDownloading: true),
        );
      }

      // ── Step 2: Encrypt temp → .enc ──────────────────────────────────────
      tempFile = File(tempPath);
      await _encryptionService.encryptFile(tempFile, encryptedPath);

      // ── Step 3: Delete temp (raw PDF removed from disk) ──────────────────
      if (await tempFile.exists()) await tempFile.delete();
      tempFile = null;

      // ── Step 4: Persist encrypted path to Isar ───────────────────────────
      docModel.isDownloaded = true;
      docModel.localPath = encryptedPath;
      docModel.progress = 1.0;

      final existingLocal = await _local.getDocument(id);
      if (existingLocal != null) {
        docModel.id = existingLocal.id; // retain Isar internal id
      }
      await _local.saveDocument(docModel);

      yield Right(docModel.toEntity());
    } catch (e) {
      // Clean up temp file on any failure so we leave no raw PDFs on disk.
      if (tempFile != null && await tempFile.exists()) {
        await tempFile.delete();
      }
      yield Left(DownloadFailure(message: e.toString()));
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Open document — decrypt encrypted file to a temp location for the viewer.
  //
  // The returned entity's [localPath] points to the DECRYPTED temp file.
  // The UI/viewer must never read the .enc file directly.
  // ─────────────────────────────────────────────────────────────────────────
  @override
  EitherFailure<Document> getDocument(String id) async {
    try {
      final doc = await _local.getDocument(id);
      if (doc == null) {
        return Left(CacheFailure('Not found'));
      }

      final encryptedPath = doc.localPath;
      if (encryptedPath == null || encryptedPath.isEmpty) {
        return Left(CacheFailure('Encrypted file path is missing'));
      }

      final encryptedFile = File(encryptedPath);
      if (!await encryptedFile.exists()) {
        return Left(CacheFailure('Encrypted file not found on disk'));
      }

      // Decrypt to system temp directory — the OS cleans this up automatically.
      final tempDir = await getTemporaryDirectory();
      final decryptedPath = '${tempDir.path}/${doc.docId}_view.pdf';

      await _encryptionService.decryptFile(encryptedFile, decryptedPath);

      return Right(doc.toEntity().copyWith(localPath: decryptedPath));
    } catch (e) {
      return Left(CacheFailure('Failed to open document: ${e.toString()}'));
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Delete — remove encrypted file + Isar record
  // ─────────────────────────────────────────────────────────────────────────
  @override
  EitherUnit deleteDocument(String id) async {
    try {
      final doc = await _local.getDocument(id);
      if (doc?.localPath != null && doc!.localPath!.isNotEmpty) {
        final encFile = File(doc.localPath!);
        if (await encFile.exists()) await encFile.delete();
      }
      await _local.deleteDocument(id);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Delete failed: ${e.toString()}'));
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Highlight → persist to Isar (no encryption involved)
  // ─────────────────────────────────────────────────────────────────────────
  @override
  EitherUnit saveHighlight(String docId, Highlight highlight) async {
    try {
      final model = HighlightModel.fromEntity(highlight);
      await _local.saveHighlight(model);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to save highlight: ${e.toString()}'));
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Get all highlights for a document
  // ─────────────────────────────────────────────────────────────────────────
  @override
  EitherFailure<List<Highlight>> getHighlights(String docId) async {
    try {
      final list = await _local.getHighlights(docId);
      return Right(list.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure('Failed to get highlights: ${e.toString()}'));
    }
  }
}
