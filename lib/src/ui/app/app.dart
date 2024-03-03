import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core.dart';
import '../features/authentication/cubit/authentication_cubit.dart';
import '../features/more/cubit/language_cubit.dart';
import '../features/more/cubit/profile_cubit.dart';
import '../features/more/cubit/theme_cubit.dart';
import '../localizations/generated/app_localizations.dart';
import '../navigation/global_router.dart';
import '../themes/app_dark_theme.dart';
import '../themes/app_light_theme.dart';
import '../themes/theme_extensions.dart';

/// This widget is the entry-point of the Widget-tree.
class App extends StatelessWidget {
  /// Creates a new [App].
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<StateStreamableSource<Object?>>>[
        BlocProvider<AuthenticationCubit>(
          create: (BuildContext context) => AuthenticationCubit(
            GetIt.instance.get(),
          )..verifyExistingToken(),
        ),
        BlocProvider<ProfileCubit>(
          create: (BuildContext context) =>
              ProfileCubit(GetIt.instance.get())..getProfile(),
        ),
        BlocProvider<LanguageCubit>(
          create: (BuildContext languageContext) => LanguageCubit(
            languageService: GetIt.instance.get(),
            defaultLanguageCode:
                View.of(context).platformDispatcher.locale.languageCode,
          )..fetchLanguage(),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(GetIt.instance.get())..loadTheme(),
        ),
      ],
      child: Builder(
        builder: (BuildContext context) {
          return BlocListener<AuthenticationCubit, AuthenticationState>(
            listenWhen:
                (AuthenticationState previous, AuthenticationState current) =>
                    previous.authStatus != current.authStatus,
            listener: (BuildContext context, AuthenticationState state) {
              GlobalRouter.router.refresh();
            },
            child: BlocBuilder<LanguageCubit, String>(
              builder: (BuildContext context, String languageCode) {
                return BlocBuilder<ThemeCubit, AppThemeMode>(
                  builder: (BuildContext context, AppThemeMode themeState) {
                    return MaterialApp.router(
                      restorationScopeId: AppConfig.appId,
                      debugShowCheckedModeBanner: false,
                      localizationsDelegates:
                          AppLocalizations.localizationsDelegates,
                      supportedLocales: AppLocalizations.supportedLocales,
                      routerConfig: GlobalRouter.router,
                      locale: context.read<LanguageCubit>().currentLocale,
                      theme: const AppLightTheme().theme,
                      darkTheme: const AppDarkTheme().theme,
                      themeMode: themeState.toThemeMode(),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
