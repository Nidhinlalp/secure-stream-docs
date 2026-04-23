part of 'injector.dart';

/// Registers all dependencies for the Video Player feature.
///
/// Registration order follows clean-architecture layers:
///   Data Source → Repository → Use Cases → BLoC
class VideoPlayerInjector {
  VideoPlayerInjector._();

  static void register() {
    // ─────────────────────────────────────────────────────────
    // Data Source
    // ─────────────────────────────────────────────────────────

    // Local video data source (Isar-backed)
    DI.registerLazyInstance<LocalVideoDataSource>(
      () => LocalVideoDataSourceImpl(storage: DI.fetch<LocalStorageClient>()),
    );

    // ─────────────────────────────────────────────────────────
    // Repository
    // ─────────────────────────────────────────────────────────

    DI.registerLazyInstance<VideoRepository>(
      () => VideoRepositoryImpl(
        localDataSource: DI.fetch<LocalVideoDataSource>(),
      ),
    );

    // ─────────────────────────────────────────────────────────
    // Use Cases
    // ─────────────────────────────────────────────────────────

    DI.registerLazyInstance<GetOrCreateVideoUseCase>(
      () => GetOrCreateVideoUseCase(DI.fetch<VideoRepository>()),
    );
    DI.registerLazyInstance<GetLastPlaybackPositionUseCase>(
      () => GetLastPlaybackPositionUseCase(DI.fetch<VideoRepository>()),
    );
    DI.registerLazyInstance<UpdatePlaybackPositionUseCase>(
      () => UpdatePlaybackPositionUseCase(DI.fetch<VideoRepository>()),
    );
    DI.registerLazyInstance<ClearPlaybackPositionUseCase>(
      () => ClearPlaybackPositionUseCase(DI.fetch<VideoRepository>()),
    );
    DI.registerLazyInstance<SaveCustomUrlUseCase>(
      () => SaveCustomUrlUseCase(DI.fetch<VideoRepository>()),
    );

    DI.registerLazyInstance<DeleteCustomUrlUseCase>(
      () => DeleteCustomUrlUseCase(DI.fetch<VideoRepository>()),
    );

    // ─────────────────────────────────────────────────────────
    // BLoC
    // ─────────────────────────────────────────────────────────

    // Registered as a factory so every screen gets a fresh BLoC instance
    DI.registerFactory<VideoPlayerBloc>(
      () => VideoPlayerBloc(
        getOrCreateVideo: DI.fetch<GetOrCreateVideoUseCase>(),
        getLastPlaybackPosition: DI.fetch<GetLastPlaybackPositionUseCase>(),
        updatePlaybackPosition: DI.fetch<UpdatePlaybackPositionUseCase>(),
        clearPlaybackPosition: DI.fetch<ClearPlaybackPositionUseCase>(),
        saveCustomUrl: DI.fetch<SaveCustomUrlUseCase>(),
        deleteCustomUrl: DI.fetch<DeleteCustomUrlUseCase>(),
      ),
    );
  }
}
