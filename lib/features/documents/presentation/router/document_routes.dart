import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_stream_docs/core/router/route_names.dart';
import 'package:secure_stream_docs/core/router/route_paths.dart';
import 'package:secure_stream_docs/features/documents/presentation/ui/screens/pdf_viewer_screen.dart';

part 'document_routes.g.dart';

/// Highlights screen for a specific document.
/// Full-page navigation.
@TypedGoRoute<PdfViewerRoute>(
  path: RoutePaths.documentDetails,
  name: RouteNames.documentDetails,
)
class PdfViewerRoute extends GoRouteData with $PdfViewerRoute {
  final String documentId;

  const PdfViewerRoute(this.documentId);

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      PdfViewerScreen(pdfId: documentId);
}
