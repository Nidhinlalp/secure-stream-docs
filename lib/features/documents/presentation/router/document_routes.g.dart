// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$pdfViewerRoute];

RouteBase get $pdfViewerRoute => GoRouteData.$route(
  path: '/docs/:documentId',
  name: 'document_details',
  factory: $PdfViewerRoute._fromState,
);

mixin $PdfViewerRoute on GoRouteData {
  static PdfViewerRoute _fromState(GoRouterState state) =>
      PdfViewerRoute(state.pathParameters['documentId']!);

  PdfViewerRoute get _self => this as PdfViewerRoute;

  @override
  String get location =>
      GoRouteData.$location('/docs/${Uri.encodeComponent(_self.documentId)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
