import 'package:app_navigation_pattern/navigation/app_route_config.dart';
import 'package:app_navigation_pattern/pages/home_page.dart';
import 'package:app_navigation_pattern/pages/launch_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/undefined_page.dart';
import 'app_path.dart';

class NavigatorObjectKey extends GlobalObjectKey<NavigatorState> {
  const NavigatorObjectKey(super.value);
}



class AppRouterDelegate extends RouterDelegate<AppRouteConfig>
    with PopNavigatorRouterDelegateMixin, ChangeNotifier {
  final NavigationProvider _navigationProvider;
  final WidgetRef ref;

  AppRouterDelegate({required this.ref})
      : _navigationProvider = navigationProvider {
    ref.listen(_navigationProvider, (previous, next) {
      notifyListeners();
    });
  }

  @override
  NavigatorObjectKey get navigatorKey {
    return const NavigatorObjectKey('NavigatorGlobalObjectKey');
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: (route, result) {
        if (route.didPop(result)) {
          return true;
        }
        return false;
      },
      pages: [
        for (AppPath appPath in ref.read(_navigationProvider).routeConfig)
          MaterialPage(
              child: switch (appPath.runtimeType) {
            LaunchPath => const LaunchPage(),
            HomePath => const HomePage(),
            UndefinedPath => const UndefinedPage(),
            _ => throw UnexpectedAppPathException(undefinedAppPath: appPath)
          })
      ],
    );
  }

  @override
  Future<void> setInitialRoutePath(AppRouteConfig configuration) async {
    // ignore
  }

  @override
  Future<void> setNewRoutePath(AppRouteConfig configuration) async {
    ref.read(_navigationProvider.notifier).setNewState(newState: configuration);
  }

  @override
  AppRouteConfig get currentConfiguration {
    return ref.read(_navigationProvider);
  }

  @override
  Future<bool> popRoute() async {
    if (ref.read(_navigationProvider).routeConfig.length > 1) {
      ref.read(_navigationProvider.notifier).popRoute();
    }
    return true;
  }
}
