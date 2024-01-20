import 'package:app_navigation_pattern/navigation/app_route_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarWidget extends ConsumerWidget implements PreferredSizeWidget {
  final NavigationProvider _navigationProvider = navigationProvider;

  AppBarWidget({super.key});

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      centerTitle: true,
      title: Text(ref.read(_navigationProvider).routeConfig.last.toString()),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
            onPressed: () {
              ref.read(_navigationProvider.notifier).movePreviousRoute();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        IconButton(
            onPressed: () {
              ref.read(_navigationProvider.notifier).moveNextRoute();
            },
            icon: const Icon(Icons.arrow_forward_ios))
      ],
    );
  }
}
