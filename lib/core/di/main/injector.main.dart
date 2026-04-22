part of 'injector.dart';

/// [DI] is a service locator that provides a way to register and fetch instances of services and dependencies.
///
/// It is a wrapper around the GetIt package that provides a way to register and fetch instances of services and dependencies.
///
class DI {
  // The global service locator instance
  static final GetIt _locator = GetIt.instance;

  /// Access the service locator for advanced operations (like reset)
  static GetIt get locator => _locator;

  /// Fetch an instance of T
  static T fetch<T extends Object>() => _locator<T>();

  /// Register a synchronous instance of type T
  static void registerInstance<T extends Object>(T instance) {
    if (!_locator.isRegistered<T>()) {
      _locator.registerSingleton<T>(instance);
      if (kDebugMode) {
        print('Instance Type $T: ===> $instance created');
      }
    }
  }

  /// Register an asynchronous singleton that will be initialized lazily
  /// The factory function is NOT called until the instance is first requested
  static void registerSingletonAsync<T extends Object>(
    Future<T> Function() factory,
  ) {
    if (!_locator.isRegistered<T>()) {
      _locator.registerSingletonAsync<T>(factory);
      if (kDebugMode) {
        print('Async Singleton Type $T: ===> registered');
      }
    }
  }

  /// Register a lazy instance (factory on first call) of type T
  static void registerLazyInstance<T extends Object>(
    T Function() instanceFactory,
  ) {
    if (!_locator.isRegistered<T>()) {
      _locator.registerLazySingleton<T>(instanceFactory);
      if (kDebugMode) {
        print('Lazy Instance Type $T: ===> registered');
      }
    }
  }

  /// Unregister a previously registered instance of T
  static void unRegisterInstance<T extends Object>() {
    if (_locator.isRegistered<T>()) {
      _locator.unregister<T>();
      if (kDebugMode) {
        print('Instance $T has been removed.');
      }
    }
  }

  // Update Instance
  static void updateInstance<T extends Object>(T instance) {
    unRegisterInstance<T>();
    registerInstance<T>(instance);
  }

  /// Registers a factory for creating instances of type T.
  /// This method allows you to register a factory function that will be called
  /// each time an new instance of type T is requested.
  static void registerFactory<T extends Object>(T Function() factory) {
    _locator.registerFactory(factory);
  }

  static Future<void> init() async {
    try {
      // ─────────────────────────────────────────────────────────
      // External
      // ─────────────────────────────────────────────────────────

      // Internet connectivity checker
      DI.registerLazyInstance<InternetConnection>(() => InternetConnection());

      // Isar database — awaited here so it is fully ready before any
      // dependent registration (LocalStorageClient) tries to fetch it.
      final isar = await IsarInitializer.initialize();
      DI.registerInstance<Isar>(isar);

      // Dio HTTP client (depends on InternetConnection)
      DI.registerLazyInstance<Dio>(
        () => NetworkClient(
          connectivityChecker: DI.fetch<InternetConnection>(),
        ).dio,
      );

      // ─────────────────────────────────────────────────────────
      // Core
      // ─────────────────────────────────────────────────────────

      // Network info abstraction
      DI.registerLazyInstance<NetworkInfo>(
        () =>
            NetworkInfoImpl(internetConnection: DI.fetch<InternetConnection>()),
      );

      // Network client wrapper
      DI.registerLazyInstance<NetworkClient>(
        () =>
            NetworkClient(connectivityChecker: DI.fetch<InternetConnection>()),
      );

      // Local storage client (Isar is guaranteed ready by this point)
      DI.registerLazyInstance<LocalStorageClient>(
        () => LocalStorageClient(isar: DI.fetch<Isar>()),
      );

      // ─────────────────────────────────────────────────────────
      // Features
      // ─────────────────────────────────────────────────────────

      _initFeatures();

      if (kDebugMode) {
        debugPrint('✅ DI initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        errorLogger('Error initializing DI: $e', tag: 'main');
      }
      rethrow;
    }
  }

  /// Reset the service locator - useful for testing
  static void reset() {
    _locator.reset();
    if (kDebugMode) {
      print('All instances have been cleared from the service locator.');
    }
  }

  /// Delegates feature-level registration to each feature's own injector.
  ///
  /// To add a new feature:
  ///   1. Create `lib/core/di/<feature>/injector.dart` + `injector.<feature>.dart`
  ///   2. Add `import` in `injector.dart` (barrel)
  ///   3. Call `<Feature>Injector.register()` here
  static void _initFeatures() {
    video_di.VideoPlayerInjector.register();
    document_di.DocumentInjector.register();
  }
}
