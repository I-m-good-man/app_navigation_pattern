import 'package:app_navigation_pattern/navigation/app_path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppRouteConfig {
  final List<AppPath> routeConfig;

  const AppRouteConfig({required this.routeConfig});

  factory AppRouteConfig.initial() {
    final initialRouteConfig = [LaunchPath()];
    return AppRouteConfig(routeConfig: initialRouteConfig);
  }

  AppRouteConfig copyWith({
    List<AppPath>? routeConfig,
  }) {
    return AppRouteConfig(
      routeConfig: routeConfig ?? this.routeConfig,
    );
  }
}

class AppRouteConfigStateNotifier extends StateNotifier<AppRouteConfig> {
  AppRouteConfigStateNotifier({required AppRouteConfig state}) : super(state);

  void popRoute() {
    state = state.copyWith(routeConfig: state.routeConfig..removeLast());
  }

  void pushRoute({required AppPath appPath}) {
    state = state.copyWith(routeConfig: state.routeConfig..add(appPath));
  }

  void setNewState({required AppRouteConfig newState}) {
    state = newState;
  }

  void moveNextRoute() {
    AppPath currentAppPath = state.routeConfig.last;
    AppPath nextAppPath = switch (currentAppPath.runtimeType) {
      LaunchPath => HomePath(),
      HomePath => LaunchPath(),
      UndefinedPath => LaunchPath(),
      _ => throw UnexpectedAppPathException(undefinedAppPath: currentAppPath)
    };
    state = state.copyWith(routeConfig: state.routeConfig..add(nextAppPath));
  }

  void movePreviousRoute() {
    if (state.routeConfig.length > 1) {
      popRoute();
    }
  }
}

typedef NavigationProvider
    = StateNotifierProvider<AppRouteConfigStateNotifier, AppRouteConfig>;

final NavigationProvider navigationProvider =
    StateNotifierProvider<AppRouteConfigStateNotifier, AppRouteConfig>(
        (ref) => AppRouteConfigStateNotifier(state: AppRouteConfig.initial()));
