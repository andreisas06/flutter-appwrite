import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core.dart';

/// A repository to manage the theme of the app.
@Injectable(as: ThemeRepository)
class SharedPreferencesThemeRepository implements ThemeRepository {
  /// Creates a new instance of [SharedPreferencesThemeRepository].
  SharedPreferencesThemeRepository({required this.sharedPreferences});

  /// The [SharedPreferences] to manage shared preferences.
  final SharedPreferences sharedPreferences;

  static const String _key = 'app_theme';

  @override
  Future<void> setTheme(String themeCode) async {
    await sharedPreferences.setString(_key, themeCode);
  }

  @override
  String? getTheme() {
    return sharedPreferences.getString(_key);
  }
}
