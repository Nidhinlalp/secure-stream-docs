import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:secure_stream_docs/features/documents/domain/entities/document.dart';
import 'package:secure_stream_docs/features/documents/domain/usecases/delete_document.dart';
import 'package:secure_stream_docs/features/documents/domain/usecases/download_document.dart';
import 'package:secure_stream_docs/features/documents/domain/usecases/get_documents.dart';
import 'package:secure_stream_docs/features/documents/domain/usecases/params.dart';

part 'documents_event.dart';
part 'documents_state.dart';

class DocumentsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  final GetDocuments _getDocuments;
  final DownloadDocument _downloadDocument;
  final DeleteDocument _deleteDocument;

  DocumentsBloc({
    required GetDocuments getDocuments,
    required DownloadDocument downloadDocument,
    required DeleteDocument deleteDocument,
  }) : _getDocuments = getDocuments,
       _downloadDocument = downloadDocument,
       _deleteDocument = deleteDocument,
       super(DocumentsLoading()) {
    on<LoadDocuments>(_onLoad);
    on<DownloadDocumentEvent>(_onDownload);
    on<DeleteDocumentEvent>(_onDelete);
  }

  // ─────────────────────────────────────────────────────
  // Load all documents from local + remote storage
  // ─────────────────────────────────────────────────────
  Future<void> _onLoad(
    LoadDocuments event,
    Emitter<DocumentsState> emit,
  ) async {
    emit(DocumentsLoading());

    final result = await _getDocuments();

    result.fold(
      (f) => emit(DocumentsError(f.message)),
      (docs) => emit(DocumentsLoaded(docs)),
    );
  }

  // ─────────────────────────────────────────────────────
  // Download teh pdf from remote
  // ─────────────────────────────────────────────────────
  Future<void> _onDownload(
    DownloadDocumentEvent event,
    Emitter<DocumentsState> emit,
  ) async {
    final currentDocs = state is DocumentsLoaded
        ? (state as DocumentsLoaded).documents
        : <Document>[];

    final stream = _downloadDocument(IdParams(event.id));

    await emit.forEach(
      stream,
      onData: (data) =>
          data.fold((f) => DocumentsError(f.message), (updatedDoc) {
            final updatedList = currentDocs.map((doc) {
              if (doc.id == updatedDoc.id) {
                return doc.copyWith(
                  isDownloading: updatedDoc.isDownloading,
                  progress: updatedDoc.progress,
                  isDownloaded: updatedDoc.isDownloaded,
                );
              }
              return doc;
            }).toList();

            return DocumentsLoaded(updatedList);
          }),
    );
  }

  // ─────────────────────────────────────────────────────
  // Delete a document from local storage
  // ─────────────────────────────────────────────────────
  Future<void> _onDelete(
    DeleteDocumentEvent event,
    Emitter<DocumentsState> emit,
  ) async {
    final result = await _deleteDocument(IdParams(event.id));

    result.fold(
      (f) => emit(DocumentsError(f.message)),
      (_) => add(LoadDocuments()),
    );
  }
}
