import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_stream_docs/core/router/route_names.dart';
import 'package:secure_stream_docs/core/router/route_paths.dart';
import 'package:secure_stream_docs/features/highlights/presentation/ui/screens/highlights_document_screen.dart';

part 'highlights_routes.g.dart';

/// Highlights screen for a specific document.
/// Full-page navigation.
@TypedGoRoute<HighlightDocumentRoute>(
  path: RoutePaths.highlights,
  name: RouteNames.highlights,
)
class HighlightDocumentRoute extends GoRouteData with $HighlightDocumentRoute {
  final String documentId;

  const HighlightDocumentRoute(this.documentId);

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      HighlightDocumentScreen(documentId: documentId);
}
