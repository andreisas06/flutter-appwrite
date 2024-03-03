import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import 'themes.dart';

/// Implementation of the applications dark-mode [ThemeData].
class AppDarkTheme extends AppBaseTheme {
  /// Creates a new [AppDarkTheme] instance.
  const AppDarkTheme() : super();

  /// Make a dark ColorScheme from the seeds.
  @override
  ColorScheme get colorScheme {
    final ColorScheme seedColor = SeedColorScheme.fromSeeds(
      brightness: Brightness.dark,
      primaryKey: baseColorPrimary,
      primary: baseColorPrimary,
      tones: FlexTones.candyPop(Brightness.dark),
    );
    return seedColor.copyWith(
      onBackground: seedColor.surface,
    );
  }
}
