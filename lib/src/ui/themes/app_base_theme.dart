import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Definition for the application's [ThemeData] implementations.
abstract class AppBaseTheme {
  /// Creates a new instance of [AppBaseTheme].
  const AppBaseTheme();

  /// The base color of the application.
  Color get baseColorPrimary => const Color.fromRGBO(241, 56, 36, 1);

  /// Returns the color scheme.
  ColorScheme get colorScheme;

  /// The base font theme of the application.
  TextTheme get textTheme => GoogleFonts.poppinsTextTheme();

  /// Returns the theme.
  ThemeData get theme {
    setSystemBarsColor();

    return ThemeData.from(
      colorScheme: colorScheme,
      textTheme: textTheme.apply(
        bodyColor: colorScheme.onSurface,
      ),
      useMaterial3: true,
    ).copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  /// Sets the color of the system bars.
  void setSystemBarsColor() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
  }
}
