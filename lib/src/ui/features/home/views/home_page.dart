import 'package:flutter/material.dart';

import '../../../localizations/l10n.dart';
import 'home_view.dart';

/// Creates the [HomeView] and contains everything related to navigating to
/// the [HomePage].
class HomePage extends StatelessWidget {
  /// Creates a new instance of the [HomePage] widget.
  const HomePage({super.key});

  /// The path of the [HomePage] route.
  static const String path = '/';

  /// The name of the [HomePage] route.
  static const String name = 'Home';

  /// The destination for the [HomePage] route.
  static NavigationDestination destination(BuildContext context) {
    return NavigationDestination(
      label: context.l10n.homePageTitle,
      selectedIcon: const Icon(Icons.home),
      icon: const Icon(Icons.home_outlined),
    );
  }

  @override
  Widget build(BuildContext context) => const HomeView();
}
