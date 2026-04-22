import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_stream_docs/core/router/route_names.dart';
import 'package:secure_stream_docs/core/router/route_paths.dart';
import 'package:secure_stream_docs/features/video_player/presentation/ui/screens/video_screen.dart';
import 'package:secure_stream_docs/features/documents/presentation/ui/screens/document_screen.dart';
import '../ui/screens/home_screen.dart';

part 'home_routes.g.dart';

/// The main Video Player screen (Tab 1)
class VideoRoute extends GoRouteData with $VideoRoute {
  const VideoRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const VideoScreen();
}

/// The main Documents list screen (Tab 2)
class DocumentRoute extends GoRouteData with $DocumentRoute {
  const DocumentRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DocumentScreen();
}

@TypedStatefulShellRoute<HomeShellRouteData>(
  branches: [
    /// Tab 1: Video Player
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<VideoRoute>(
          path: RoutePaths.videoPlayer,
          name: RouteNames.videoPlayer,
        ),
      ],
    ),

    /// Tab 2: Documents
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<DocumentRoute>(
          path: RoutePaths.documents,
          name: RouteNames.documents,
        ),
      ],
    ),
  ],
)
class HomeShellRouteData extends StatefulShellRouteData {
  const HomeShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return HomeScreen(navigationShell: navigationShell);
  }
}
