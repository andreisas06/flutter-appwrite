import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core.dart';
import 'injectable.dart';
import 'ui.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      final WidgetsBinding widgetsBinding =
          WidgetsFlutterBinding.ensureInitialized();
      // Retain native splash screen until Dart is ready
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      // await Firebase.initializeApp();
      FlutterError.onError = (FlutterErrorDetails details) {
        // FirebaseCrashlytics.instance.recordFlutterFatalError(details);
        log(details.exceptionAsString(), stackTrace: details.stack);
      };
      // // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      // PlatformDispatcher.instance.onError = (error, stack) {
      //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      //   return true;
      // };

      // Load the environment variables from the .env file
      await _loadAppConfig();

      await configureGetIt();

      runApp(const App());
      FlutterNativeSplash.remove(); // Now remove splash screen
    },
    (Object error, StackTrace stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
    },
  );
}

/// Loads the environment variables from the given .env file.
///
/// Uses `--dart-define=ENV_FILE=.env.dev` to specify the file to load.
/// Defaults to `.env.dev` if not specified.
///
/// The default files are:
/// - `.env.dev` for development
/// - `.env.staging` for staging
/// - `.env.prod` for production
///
/// You can add your own file, by simply copying .env.dev, and give it a name
/// for example `.env.local_dev` and then use
/// `--dart-define=ENV_FILE=.env.local_dev` to run it.
Future<void> _loadAppConfig() async {
  const String envFileName = String.fromEnvironment(
    'ENV_FILE',
    defaultValue: '.env.dev',
  );

  await dotenv.load(fileName: envFileName);
  AppConfig.init(dotenv.env, kdDebugMode: kDebugMode);
}
