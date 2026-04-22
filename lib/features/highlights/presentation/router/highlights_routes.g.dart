// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'highlights_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$highlightDocumentRoute];

RouteBase get $highlightDocumentRoute => GoRouteData.$route(
  path: '/docs/:documentId/highlights',
  name: 'highlights',
  factory: $HighlightDocumentRoute._fromState,
);

mixin $HighlightDocumentRoute on GoRouteData {
  static HighlightDocumentRoute _fromState(GoRouterState state) =>
      HighlightDocumentRoute(state.pathParameters['documentId']!);

  HighlightDocumentRoute get _self => this as HighlightDocumentRoute;

  @override
  String get location => GoRouteData.$location(
    '/docs/${Uri.encodeComponent(_self.documentId)}/highlights',
  );

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
