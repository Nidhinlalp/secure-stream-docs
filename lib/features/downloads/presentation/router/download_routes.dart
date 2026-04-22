import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_stream_docs/core/router/route_names.dart';
import 'package:secure_stream_docs/core/router/route_paths.dart';
import '../ui/screens/download_screen.dart';

part 'download_routes.g.dart';

/// App-wide Downloads screen. Full-page navigation.
@TypedGoRoute<DownloadRoute>(
  path: RoutePaths.downloads,
  name: RouteNames.downloads,
)
class DownloadRoute extends GoRouteData with $DownloadRoute {
  const DownloadRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DownloadScreen();
}
