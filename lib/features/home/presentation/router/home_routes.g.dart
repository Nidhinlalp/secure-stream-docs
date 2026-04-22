// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$homeShellRouteData];

RouteBase get $homeShellRouteData => StatefulShellRouteData.$route(
  factory: $HomeShellRouteDataExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/player',
          name: 'video_player',
          factory: $VideoRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/docs',
          name: 'documents',
          factory: $DocumentRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $HomeShellRouteDataExtension on HomeShellRouteData {
  static HomeShellRouteData _fromState(GoRouterState state) =>
      const HomeShellRouteData();
}

mixin $VideoRoute on GoRouteData {
  static VideoRoute _fromState(GoRouterState state) => const VideoRoute();

  @override
  String get location => GoRouteData.$location('/player');

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

mixin $DocumentRoute on GoRouteData {
  static DocumentRoute _fromState(GoRouterState state) => const DocumentRoute();

  @override
  String get location => GoRouteData.$location('/docs');

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
