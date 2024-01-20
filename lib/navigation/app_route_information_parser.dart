import 'package:app_navigation_pattern/navigation/app_path.dart';
import 'package:app_navigation_pattern/navigation/app_route_config.dart';
import 'package:flutter/material.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRouteConfig> {
  @override
  Future<AppRouteConfig> parseRouteInformation(
      RouteInformation routeInformation) async {
    List<AppPath> routeConfig = [
      for (String pathSegment in routeInformation.uri.pathSegments)
        switch (pathSegment) {
          'launch' => LaunchPath(),
          'home' => HomePath(),
          'undefined' => UndefinedPath(),
          _ => UndefinedPath()
        }
    ];
    return AppRouteConfig(routeConfig: routeConfig);
  }

  @override
  RouteInformation restoreRouteInformation(AppRouteConfig configuration) {
    List<String> pathSegments = [
      for (AppPath appPath in configuration.routeConfig)
        switch (appPath.runtimeType) {
          LaunchPath => 'launch',
          HomePath => 'home',
          UndefinedPath => 'undefined',
          _ => 'undefined'
        }
    ];
    Uri uri = Uri(pathSegments: pathSegments);
    return RouteInformation(uri: uri);
  }
}
