import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_stream_docs/core/di/main/injector.dart';
import 'package:secure_stream_docs/core/router/route_names.dart';
import 'package:secure_stream_docs/core/router/route_paths.dart';
import 'package:secure_stream_docs/features/documents/presentation/logic/highlight/highlight_cubit.dart';
import 'package:secure_stream_docs/features/documents/presentation/logic/viewer/viewer_cubit.dart';
import 'package:secure_stream_docs/features/documents/presentation/ui/screens/highlights_review_screen.dart';
import 'package:secure_stream_docs/features/documents/presentation/ui/screens/pdf_viewer_screen.dart';

part 'document_routes.g.dart';

/// Full-page PDF viewer route.
/// Provides fresh [ViewerCubit] and [HighlightCubit] instances per navigation.
@TypedGoRoute<PdfViewerRoute>(
  path: RoutePaths.documentDetails,
  name: RouteNames.documentDetails,
)
class PdfViewerRoute extends GoRouteData with $PdfViewerRoute {
  final String documentId;

  const PdfViewerRoute({required this.documentId});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<ViewerCubit>(
            create: (_) => DI.fetch<ViewerCubit>(),
          ),
          BlocProvider<HighlightCubit>(
            create: (_) => DI.fetch<HighlightCubit>(),
          ),
        ],
        child: PdfViewerScreen(pdfId: documentId),
      );
}

/// Highlights review route — PRD Point 6.
/// Displays all saved highlights for a given document.
@TypedGoRoute<HighlightsReviewRoute>(
  path: RoutePaths.highlights,
  name: RouteNames.highlights,
)
class HighlightsReviewRoute extends GoRouteData with $HighlightsReviewRoute {
  final String documentId;

  const HighlightsReviewRoute({required this.documentId});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      BlocProvider<HighlightCubit>(
        create: (_) => DI.fetch<HighlightCubit>(),
        child: HighlightsReviewScreen(documentId: documentId),
      );
}
