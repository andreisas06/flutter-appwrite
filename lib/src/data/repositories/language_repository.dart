import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core.dart';

/// A repository to manage the language of the app.
@Injectable(as: LanguageRepository)
class SharedPreferencesLanguageRepository implements LanguageRepository {
  /// Creates a new instance of [SharedPreferencesLanguageRepository].
  SharedPreferencesLanguageRepository({required this.sharedPreferences});

  /// The [SharedPreferences] to manage shared preferences.
  final SharedPreferences sharedPreferences;

  static const String _key = 'userLanguage';

  @override
  Future<void> setLanguage(String languageCode) async {
    await sharedPreferences.setString(_key, languageCode);
  }

  @override
  String? getLanguage() {
    return sharedPreferences.getString(_key);
  }
}
