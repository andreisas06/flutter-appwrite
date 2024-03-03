import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core.dart';
import '../features/authentication/cubit/authentication_cubit.dart';
import '../features/authentication/views/forgot_password_page.dart';
import '../features/authentication/views/login_page.dart';
import '../features/counter/view/counter_page.dart';
import '../features/home/views/example_details_page.dart';
import '../features/home/views/home_page.dart';
import '../features/home/views/new_example_page.dart';
import '../features/more/views/language/language_page.dart';
import '../features/more/views/more_page.dart';
import '../features/more/views/profile/profile_page.dart';
import '../features/more/views/settings/settings_page.dart';
import '../features/terms_and_conditions/terms_and_conditions_page.dart';
import 'app_scaffold_shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _homeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> _counterNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'counter');
final GlobalKey<NavigatorState> _moreNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'more');

/// The [GlobalRouter] maintains the main route configuration for the app.
///
/// Routes that are `fullScreenDialogs` should also set `_rootNavigatorKey` as
/// the `parentNavigatorKey` to ensure that the dialog is displayed correctly.
class GlobalRouter {
  /// The router with the routes of pages that should be displayed
  /// within the [AppScaffoldShell]
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    redirect: (BuildContext context, GoRouterState state) async {
      final AuthenticationStatus authStatus =
          context.read<AuthenticationCubit>().state.authStatus;
      // If the user is not logged in, get kicked back to login page
      if (authStatus == AuthenticationStatus.unauthenticated) {
        return LoginPage.path;
      }

      // If the user is successfully logged in but still on login, go to home.
      if (state.fullPath == LoginPage.path) {
        return HomePage.path;
      }

      // In any other case the redirect can be safely ignored and handled as is.
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        name: LoginPage.name,
        path: LoginPage.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<void>(child: LoginPage()),
        routes: <RouteBase>[
          GoRoute(
            name: ForgotPasswordPage.name,
            path: ForgotPasswordPage.path,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const MaterialPage<void>(
              fullscreenDialog: true,
              child: ForgotPasswordPage(),
            ),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return AppScaffoldShell(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                name: HomePage.name,
                path: HomePage.path,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    const MaterialPage<void>(
                  child: HomePage(),
                ),
                routes: <RouteBase>[
                  GoRoute(
                    name: ExampleDetailsPage.name,
                    path: ExampleDetailsPage.path,
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (BuildContext context, GoRouterState state) =>
                        const MaterialPage<void>(
                      child: ExampleDetailsPage(),
                    ),
                  ),
                  GoRoute(
                    name: NewExamplePage.name,
                    path: NewExamplePage.path,
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (BuildContext context, GoRouterState state) =>
                        const MaterialPage<void>(
                      fullscreenDialog: true,
                      child: NewExamplePage(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _counterNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                name: CounterPage.name,
                path: CounterPage.path,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    const MaterialPage<void>(child: CounterPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _moreNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                name: MorePage.name,
                path: MorePage.path,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    const MaterialPage<void>(
                  key: ValueKey<String>(MorePage.name),
                  child: MorePage(),
                ),
                routes: <RouteBase>[
                  GoRoute(
                    path: ProfilePage.path,
                    name: ProfilePage.name,
                    pageBuilder: (BuildContext context, GoRouterState state) =>
                        const MaterialPage<void>(child: ProfilePage()),
                  ),
                  GoRoute(
                    name: SettingsPage.name,
                    path: SettingsPage.path,
                    pageBuilder: (BuildContext context, GoRouterState state) =>
                        const MaterialPage<void>(child: SettingsPage()),
                  ),
                  GoRoute(
                    name: TermsAndConditionsPage.name,
                    path: TermsAndConditionsPage.path,
                    pageBuilder: (BuildContext context, GoRouterState state) =>
                        const MaterialPage<void>(
                      child: TermsAndConditionsPage(),
                    ),
                  ),
                  GoRoute(
                    name: LanguagePage.name,
                    path: LanguagePage.path,
                    pageBuilder: (BuildContext context, GoRouterState state) =>
                        const MaterialPage<void>(child: LanguagePage()),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
