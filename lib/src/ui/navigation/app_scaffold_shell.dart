import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';

import '../../assets/generated/assets.gen.dart';
import '../constants/sizes_constants.dart';
import '../extensions/build_context_extensions.dart';
import '../features/counter/view/counter_page.dart';
import '../features/home/views/home_page.dart';
import '../features/more/views/more_page.dart';

/// The [AppScaffoldShell] is the main scaffold for the application.
///
/// It displays the page of the active route within it self and displays a
/// `bottomNavigationBar` to navigate between the pages.
class AppScaffoldShell extends StatelessWidget {
  /// Create a new instance of [AppScaffoldShell]
  const AppScaffoldShell({
    required this.navigationShell,
    super.key,
  });

  /// The navigation shell to use with the bottom navigation bar.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      transitionDuration: const Duration(milliseconds: 200),
      useDrawer: false,
      leadingExtendedNavRail: Column(
        children: <Widget>[
          Image.asset(
            Assets.baseflowLogo.path,
            fit: BoxFit.contain,
            height: Sizes.s64,
          ),
          Divider(
            color: context.colorScheme.surfaceVariant,
            thickness: 1,
          ),
        ],
      ),
      trailingNavRail: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Divider(
              color: context.colorScheme.surfaceVariant,
              thickness: 1,
            ),
          ],
        ),
      ),
      body: (BuildContext context) => navigationShell,
      selectedIndex: navigationShell.currentIndex,
      onSelectedIndexChange: (int index) {
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
      },
      destinations: navigationShell.route.branches.map(
        (StatefulShellBranch e) {
          return switch (e.defaultRoute?.name) {
            CounterPage.name => CounterPage.destination(context),
            HomePage.name => HomePage.destination(context),
            MorePage.name => MorePage.destination(context),
            _ => throw UnimplementedError(
                'The route ${e.defaultRoute?.name} is not implemented.',
              ),
          };
        },
      ).toList(),
    );
  }
}
