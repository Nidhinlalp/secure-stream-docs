# ARCHITECTURE.md — Secure Stream Docs

> A Flutter application for secure, encrypted PDF document management and HLS video streaming.  
> Architecture based on **Clean Architecture** with **BLoC / Cubit** state management.

---

## 1. Overview

**Secure Stream Docs** is a Flutter mobile application with two primary capabilities:

1. **HLS Video Player** — Streams adaptive-bitrate HLS video using `better_player_plus`. Tracks and restores playback position across sessions using local persistence.

2. **Secure PDF System** — Downloads PDF documents from a remote server, encrypts them locally using AES-256, and decrypts them on demand into a temporary file only for the duration of a viewing session. Users can highlight text within documents and review saved highlights.

The app targets Android and iOS, is structured around feature-based modules, and uses Isar as its local database.

---

## 2. Architecture Pattern

The project follows **Clean Architecture** with strict layer separation within each feature:

```
Presentation  →  Domain  →  Data
```

### Layer Responsibilities

| Layer | Responsibility |
|---|---|
| **Presentation** | UI widgets, screens, BLoC/Cubit state management, routing |
| **Domain** | Business entities, repository contracts (abstract), use cases |
| **Data** | Repository implementations, data sources (remote/local), Isar models |

### Key Rules Enforced
- The **Domain layer has zero Flutter dependencies** — only Dart types and `dartz`.
- The **Data layer** depends on Domain (implements its contracts) but never on Presentation.
- The **Presentation layer** only calls Use Cases via the BLoC/Cubit — never touches repositories or data sources directly.
- Functional error handling uses `Either<Failure, T>` from **dartz** throughout the domain and data layers.

---

## 3. Feature-Based Modular Structure

```
lib/
├── core/                        # Shared infrastructure (no feature logic)
│   ├── di/                      # Dependency injection (GetIt-based)
│   │   ├── main/                # DI bootstrap — core singletons (Isar, Dio, etc.)
│   │   ├── document/            # Document feature injector
│   │   └── video_player/        # Video player feature injector
│   ├── error/                   # Failure types, exceptions, error mapper
│   ├── local/                   # IsarInitializer, LocalStorageClient
│   ├── network/                 # NetworkClient (Dio), interceptors
│   ├── router/                  # AppRouter, RoutePaths, RouteNames
│   ├── security/                # FileEncryptionService (AES-256)
│   ├── ui/                      # AppTheme, AppColors, AppTextStyle, AppSizses
│   └── usecases/                # Base UseCase<Result, Params> contract
│
└── features/
    ├── home/                    # Navigation shell (bottom tab bar only)
    ├── documents/               # PDF list, download, viewer, highlights
    └── video_player/            # HLS streaming, playback position, custom URLs
```

### Feature Modules

#### `features/home`
Acts purely as the navigation shell. Contains `HomeScreen`, which wraps a `StatefulNavigationShell` (GoRouter) to provide the persistent bottom tab bar. No business logic or data layer.

#### `features/documents`
The most complex feature. Three distinct sub-domains co-located here:

| Sub-domain | Responsibility |
|---|---|
| **Document list** | Fetch remote metadata, track local download state |
| **PDF viewer** | Decrypt encrypted local file, render with `pdfrx` |
| **Highlights** | Save and retrieve text highlights per document |

#### `features/video_player`
Manages HLS video playback. Persists video metadata and last playback position in Isar. Supports optional custom HLS URL input stored locally.

---

## 4. State Management Strategy

All state management uses **flutter_bloc**. The choice between `Bloc` (event-driven) and `Cubit` (method-driven) is based on the complexity of the interaction.

### `DocumentsBloc` (`Bloc`)
Used because it handles multiple concurrent event types with streaming responses.

| Event | Behaviour |
|---|---|
| `LoadDocuments` | Fetches remote metadata, merges with local Isar state |
| `DownloadDocumentEvent` | Streams download progress via `emit.forEach` → encrypts → saves |
| `DeleteDocumentEvent` | Deletes encrypted file + Isar record, then reloads list |

**States:** `DocumentsLoading`, `DocumentsLoaded(List<Document>)`, `DocumentsError`

---

### `ViewerCubit` (`Cubit`)
Simple two-outcome operation — open or fail. No event queue needed.

| Method | Behaviour |
|---|---|
| `openDocument(id)` | Reads encrypted `.enc` file, decrypts to temp dir, emits `ViewerLoaded` with the temp path |

**States:** `ViewerInitial`, `ViewerLoading`, `ViewerLoaded(path, document)`, `ViewerError`

---

### `HighlightCubit` (`Cubit`)
Manages highlight CRUD for a single open document.

| Method | Behaviour |
|---|---|
| `load(docId)` | Reads all highlights for the document from Isar |
| `add(docId, highlight)` | Saves highlight to Isar, then calls `load()` to refresh |

**States:** `HighlightInitial`, `HighlightLoading`, `HighlightLoaded(List<Highlight>)`, `HighlightError`

---

### `VideoPlayerBloc` (`Bloc`)
Manages the full video session lifecycle.

| Event | Behaviour |
|---|---|
| `LoadVideo(url)` | Get-or-create video record in Isar, restore last position, emit `VideoPlayerReady` |
| `SavePlaybackPosition` | Persist current position silently (no state change emitted) |
| `ClearPlaybackPosition` | Reset position to 0, re-dispatch `LoadVideo` |
| `AddCustomUrl` | Save user-supplied HLS URL, reload custom URL list |
| `LoadCustomUrls` | Fetch all saved custom URLs from Isar |
| `DeleteCustomUrl` | Remove URL from Isar, reload list |

**States:** `VideoPlayerInitial`, `VideoPlayerLoading`, `VideoPlayerReady(video, positionMs)`, `CustomUrlsLoaded(urls)`, `VideoPlayerError`

---

## 5. Data Flow

### PDF Download Flow

```
DocumentsScreen
  → DownloadDocumentEvent dispatched to DocumentsBloc
    → DownloadDocument UseCase
      → DocumentRepositoryImpl.downloadDocument(id)
        1. RemoteDataSource.fetchDocuments()   — get metadata
        2. RemoteDataSource.downloadFile()     — stream progress (yield Right(doc with progress))
        3. FileEncryptionService.encryptFile() — AES-CBC in background isolate
        4. Delete raw temp .pdf from disk
        5. LocalDataSource.saveDocument()      — persist encrypted path to Isar
        6. yield Right(completedDoc)
  ← DocumentsBloc emits DocumentsLoaded (updated list with isDownloaded: true)
```

### PDF Open (Decrypt) Flow

```
DocumentsScreen (tap row)
  → GoRouter.push(PdfViewerRoute(documentId))
    → document_routes.dart provides fresh ViewerCubit + HighlightCubit via MultiBlocProvider
      → PdfViewerScreen calls ViewerCubit.openDocument(id)
        → GetDocument UseCase
          → DocumentRepositoryImpl.getDocument(id)
            1. LocalDataSource.getDocument(id)  — fetch Isar record
            2. FileEncryptionService.decryptFile() — AES-CBC in background isolate
            3. Write to system temp directory (/tmp)
            4. Return Document with localPath = temp .pdf path
      ← ViewerCubit emits ViewerLoaded(path: tempPath)
        → PdfViewerScreen renders PDF via pdfrx using tempPath
```

> The decrypted `.pdf` is written to the OS temporary directory, which the OS reclaims automatically. The original `.enc` file is never exposed to `pdfrx`.

### Highlight Save Flow

```
PdfViewerScreen (user selects text)
  → HighlightCubit.add(docId, highlight)
    → SaveHighlight UseCase
      → DocumentRepositoryImpl.saveHighlight()
        → LocalDataSource.saveHighlight() — writes HighlightModel to Isar
    → HighlightCubit.load(docId) — refreshes list
  ← HighlightCubit emits HighlightLoaded(updatedList)
    → Highlight overlay re-renders on PDF page
```

### Video Playback Resume Flow

```
VideoScreen
  → LoadVideo(url) dispatched to VideoPlayerBloc
    → GetOrCreateVideoUseCase(url)  — upsert VideoModel in Isar
    → GetLastPlaybackPositionUseCase(url) — read lastPositionMs from VideoModel
  ← VideoPlayerBloc emits VideoPlayerReady(video, positionMs)
    → VideoPlayerView initialises better_player_plus at positionMs
    → On tick: SavePlaybackPosition event dispatched (silent background save)
```

---

## 6. Local Storage (Isar)

Isar (`isar_community`) is the single local database. It is opened once at startup in `IsarInitializer` with all schemas registered. The instance is injected as a singleton via `GetIt`.

### Collections

| Collection | Purpose | Key Fields |
|---|---|---|
| `DocumentModel` | PDF metadata and download state | `docId`, `url`, `name`, `isDownloaded`, `localPath` (encrypted path), `progress` |
| `HighlightModel` | Per-document text highlights | `highlightId`, `docId`, `page`, `text`, `left/top/right/bottom`, `colorValue`, `createdAt` |
| `VideoModel` | Video playback state | `url`, `lastPositionMs`, `isUserProvided`, `updatedAt` |

### Why Isar
- **No JSON serialization overhead** — native Dart object persistence.
- **Typed queries** — filters and sorts are compile-time safe via code generation.
- **Cross-platform** — works on Android and iOS without platform bridges.
- **Fast** — suitable for high-frequency writes (e.g., playback position updates).

---

## 7. File Security (Encryption)

All document encryption is handled by `core/security/FileEncryptionService`.

### Algorithm
- **AES-256 CBC** via the `encrypt` package.
- Key: 32-byte UTF-8 string.
- IV: 16-byte UTF-8 string (fixed per PoC — note: a random IV per file should be used in production).

### Encryption lifecycle

| Phase | When | Where |
|---|---|---|
| **Encrypt** | Immediately after download completes | Raw `.pdf` → `.enc` in app documents dir |
| **Delete raw** | Immediately after encryption | Temp `.pdf` is deleted before any yield |
| **Decrypt** | On document open, per session | `.enc` → `.pdf` in system temp dir |
| **Temp cleanup** | Automatic | OS reclaims `tmpdir` contents |

### Isolate Offloading
Both `encryptFile()` and `decryptFile()` run the cipher work inside Flutter's `compute()` function, which spawns a separate Dart isolate. This ensures the main UI thread is never blocked during CPU-intensive AES operations.

---

## 8. Routing

Navigation is managed by **GoRouter** with type-safe route data classes generated by `go_router_builder`.

### Structure

```
GoRouter (initialLocation: /player)
│
├── StatefulShellRoute (HomeShellRouteData) — persistent bottom tab bar
│   ├── Branch 1: /player         → VideoScreen           (Tab: Video)
│   └── Branch 2: /docs           → DocumentsScreen        (Tab: Documents)
│
└── Full-screen routes (no bottom nav)
    ├── /docs/:documentId          → PdfViewerScreen        (ViewerCubit + HighlightCubit provided here)
    └── /docs/:documentId/highlights → HighlightsReviewScreen (HighlightCubit provided here)
```

### Route Constants

| Constant class | Purpose |
|---|---|
| `RoutePaths` | URL path strings (e.g. `/docs/:documentId`) |
| `RouteNames` | Named route identifiers for `goNamed()` navigation |

### BLoC Provisioning at Route Level
`ViewerCubit` and `HighlightCubit` are provisioned as `BlocProvider` wrappers inside the route's `build()` method (`document_routes.dart`). This means a fresh Cubit instance is created per navigation — there is no shared global instance for these transient states.

---

## 9. External Dependencies

| Package | Version | Purpose |
|---|---|---|
| `flutter_bloc` / `bloc` | 8.x | State management — Bloc and Cubit patterns |
| `go_router` + `go_router_builder` | 17.x / 4.x | Declarative, type-safe navigation |
| `better_player_plus` | 1.x | HLS video player with adaptive bitrate, buffering, and controls |
| `pdfrx` | 2.x | High-performance PDF rendering with text selection and coordinate access |
| `isar_community` + `isar_community_flutter_libs` | 3.x | Local embedded NoSQL database |
| `isar_community_generator` | 3.x | Code generation for Isar schemas |
| `encrypt` | 5.x | AES-256 CBC encryption / decryption |
| `dartz` | 0.10 | Functional types: `Either<Failure, T>` for error handling |
| `get_it` | 7.x | Service locator for dependency injection |
| `dio` | 5.x | HTTP client with interceptor support |
| `internet_connection_checker_plus` | 2.x | Connectivity detection used in `ConnectivityInterceptor` |
| `path_provider` | 2.x | Access to app documents dir and system temp dir |
| `uuid` | 4.x | Unique filenames for downloaded/encrypted files |
| `equatable` | 2.x | Value equality for Bloc events and states |
| `flutter_screenutil` | 5.x | Responsive sizing (`AppSizses` tokens are in `.sp` units) |

---

## 10. Design Decisions

### Why separate Cubits (`ViewerCubit`, `HighlightCubit`) instead of one Bloc?
Each concern has a distinct, independent lifecycle. The viewer opens and closes independently of highlight edits. Keeping them separate means simpler state machines, no accidental coupling, and fresh Cubit instances per navigation without leaking highlight state between document sessions.

### Why are highlights stored unencrypted in Isar?
Highlights contain only coordinate metadata and short text snippets — no binary content. The sensitive binary data (the PDF itself) is always encrypted. Isar data is app-sandbox-restricted on both Android and iOS, providing sufficient protection for highlight records without the decryption overhead.

### Why are decrypted files written to the OS temp directory?
The `pdfrx` renderer needs a file path, not raw bytes. Writing to `getTemporaryDirectory()` means the OS reclaims the file on device restart or under memory pressure — the plaintext PDF never lives permanently on disk. The encrypted `.enc` original in the app documents directory is the only persistent copy.

### Why is `DocumentsBloc` a `Bloc` while viewer/highlight use `Cubit`?
`DocumentsBloc` handles a streaming download response (`emit.forEach`) and multiple concurrent event types. The explicit event-based model makes the handler mapping clear and safe for long-running async streams. `Cubit` is used where simple method calls with no event queue are sufficient.

### Why is DI structured as feature injectors?
`DI.init()` delegates to `VideoPlayerInjector.register()` and `DocumentInjector.register()`, each defined in their own `core/di/<feature>/` file. This keeps the bootstrap class thin and ensures each feature owns its wiring. Adding a new feature requires only adding one registration call and one injector file.
