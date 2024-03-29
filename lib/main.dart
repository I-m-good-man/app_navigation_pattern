import 'package:app_navigation_pattern/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(debugShowCheckedModeBanner: false,
      routeInformationParser: AppNavigation.routeInformationParser,
      routerDelegate: AppNavigation.routerDelegate(ref: ref),
    );
  }
}
