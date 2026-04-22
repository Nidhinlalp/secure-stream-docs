import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_stream_docs/core/ui/screens/error_screen.dart';

// Import feature routes with prefixes
import 'package:secure_stream_docs/features/documents/presentation/router/document_routes.dart'
    as documents;
import 'package:secure_stream_docs/features/downloads/presentation/router/download_routes.dart'
    as downloads;
import 'package:secure_stream_docs/features/highlights/presentation/router/highlights_routes.dart'
    as highlights;
import 'package:secure_stream_docs/features/home/presentation/router/home_routes.dart'
    as home;

import 'route_paths.dart';

/// ---------------------------------------------------------------------------
/// App Router Configuration
/// ---------------------------------------------------------------------------

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RoutePaths.videoPlayer,
    debugLogDiagnostics: true,
    routes: [
      // Shell Route (Persistent Bottom Nav) - defined in home_routes.dart
      ...home.$appRoutes,

      // Full-screen Routes (Hidden Bottom Nav)
      ...documents.$appRoutes,
      ...downloads.$appRoutes,
      ...highlights.$appRoutes,
    ],
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
  );
}
