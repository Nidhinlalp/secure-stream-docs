part of 'injector.dart';

/// Registers all dependencies for the Document feature.
///
/// Registration order follows clean-architecture layers:
///   Data Sources → Repository → Use Cases → BLoC
class DocumentInjector {
  DocumentInjector._();

  static void register() {
    // ─────────────────────────────────────────────────────────
    // Data Sources
    // ─────────────────────────────────────────────────────────

    // Local document data source (Isar-backed)
    DI.registerLazyInstance<DocumentLocalDataSource>(
      () =>
          DocumentLocalDataSourceImpl(storage: DI.fetch<LocalStorageClient>()),
    );

    // Remote document data source (network-backed)
    DI.registerLazyInstance<DocumentRemoteDataSource>(
      () => DocumentRemoteDataSourceImpl(DI.fetch<NetworkClient>()),
    );

    // ─────────────────────────────────────────────────────────
    // Security
    // ─────────────────────────────────────────────────────────

    // AES-256 encryption service — used exclusively by the repository layer
    DI.registerLazyInstance<FileEncryptionService>(
      () => FileEncryptionService(),
    );

    // ─────────────────────────────────────────────────────────
    // Repository
    // ─────────────────────────────────────────────────────────

    DI.registerLazyInstance<DocumentRepository>(
      () => DocumentRepositoryImpl(
        remote: DI.fetch<DocumentRemoteDataSource>(),
        local: DI.fetch<DocumentLocalDataSource>(),
        encryptionService: DI.fetch<FileEncryptionService>(),
      ),
    );

    // ─────────────────────────────────────────────────────────
    // Use Cases
    // ─────────────────────────────────────────────────────────

    DI.registerLazyInstance<GetDocuments>(
      () => GetDocuments(repository: DI.fetch<DocumentRepository>()),
    );
    DI.registerLazyInstance<DownloadDocument>(
      () => DownloadDocument(repository: DI.fetch<DocumentRepository>()),
    );
    DI.registerLazyInstance<GetDocument>(
      () => GetDocument(repository: DI.fetch<DocumentRepository>()),
    );
    DI.registerLazyInstance<DeleteDocument>(
      () => DeleteDocument(repository: DI.fetch<DocumentRepository>()),
    );
    DI.registerLazyInstance<SaveHighlight>(
      () => SaveHighlight(repository: DI.fetch<DocumentRepository>()),
    );
    DI.registerLazyInstance<GetHighlights>(
      () => GetHighlights(repository: DI.fetch<DocumentRepository>()),
    );

    // ─────────────────────────────────────────────────────────
    // BLoC
    // ─────────────────────────────────────────────────────────

    // Registered as a factory so every screen gets a fresh BLoC instance
    DI.registerFactory<DocumentsBloc>(
      () => DocumentsBloc(
        getDocuments: DI.fetch<GetDocuments>(),
        downloadDocument: DI.fetch<DownloadDocument>(),
        deleteDocument: DI.fetch<DeleteDocument>(),
      ),
    );

    DI.registerFactory<HighlightCubit>(
      () => HighlightCubit(
        saveHighlight: DI.fetch<SaveHighlight>(),
        getHighlights: DI.fetch<GetHighlights>(),
      ),
    );

    DI.registerFactory<ViewerCubit>(
      () => ViewerCubit(getDocument: DI.fetch<GetDocument>()),
    );
  }
}
