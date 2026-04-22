// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$downloadRoute];

RouteBase get $downloadRoute => GoRouteData.$route(
  path: '/downloads',
  name: 'downloads',
  factory: $DownloadRoute._fromState,
);

mixin $DownloadRoute on GoRouteData {
  static DownloadRoute _fromState(GoRouterState state) => const DownloadRoute();

  @override
  String get location => GoRouteData.$location('/downloads');

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
