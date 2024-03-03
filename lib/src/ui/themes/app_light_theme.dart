import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import 'themes.dart';

/// Implementation of the applications light-mode [ThemeData].
class AppLightTheme extends AppBaseTheme {
  /// Creates a new [AppLightTheme] instance.
  const AppLightTheme() : super();

  /// Make a light ColorScheme from the seeds.
  @override
  ColorScheme get colorScheme => SeedColorScheme.fromSeeds(
        primaryKey: baseColorPrimary,
        primary: baseColorPrimary,
        tones: FlexTones.material(Brightness.light),
      );
}
