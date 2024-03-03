/// The application configuration.
///
/// These values can be set using the `.env` file which you can copy form
/// `.env.example`. The values can also be set using `--dart-define`when you
/// want to run the app from the command line. If both are not set a fallback
/// is used.
class AppConfig {
  /// Creates a new instance of [AppConfig].
  AppConfig._(
    this._config,
    this.kDebugMode,
  );

  /// The [AppConfig] instance.
  static late AppConfig _instance;

  /// Initializes the [AppConfig] instance by setting [_instance] using the
  /// private constructor.
  static void init(
    Map<String, String> config, {
    bool kdDebugMode = false,
  }) {
    _instance = AppConfig._(config, kdDebugMode);
  }

  /// The configuration of the application.
  final Map<String, String> _config;

  /// Whether the application is in debug mode.
  final bool kDebugMode;

  /// The current application flavor.
  static String flavor = _defineOrEnv('FLAVOR', finalFallback: 'development');

  /// The application ID.
  static String appId = _defineOrEnv('APP_ID');

  /// The application title.
  static String appTitle = _defineOrEnv('APP_TITLE');

  /// The base URL.
  static String baseUrl = _defineOrEnv('BASE_URL');

  /// The authentication URL.
  static String authUrl = _defineOrEnv('AUTH_URL');

  /// The default username for development or staging.
  static String defaultUsername =
      _instance.kDebugMode ? _defineOrEnv('DEFAULT_USERNAME') : '';

  /// The default password for development or staging.
  static String defaultPassword =
      _instance.kDebugMode ? _defineOrEnv('DEFAULT_PASSWORD') : '';

  /// Gets the configuration from `--dart-define` or `.env`.
  ///
  /// Gets the value from `--dart-define` if it exists, otherwise it gets the
  /// value from the `.env` file. If the value does not exist in either, it
  /// returns the [finalFallback].
  ///
  /// The [key] is the name of the variable to get.
  static String _defineOrEnv(String key, {String? finalFallback}) {
    return _instance._config[key] ?? (finalFallback ?? '');
  }
}
