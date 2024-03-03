import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core.dart';
import 'injectable.config.dart';

/// Global instance of GetIt.
final GetIt getIt = GetIt.instance;

/// Configures the dependency injection from a generated function.
@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureGetIt() async {
  await getIt.init(environment: AppConfig.flavor);
  await GetIt.instance.allReady();
}

/// Register shared preferences.
@module
abstract class SharedPreferencesModule {
  /// The shared preferences to manage shared preferences.
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
