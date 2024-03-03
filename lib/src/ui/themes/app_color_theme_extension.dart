import 'package:flutter/material.dart';

/// A collection of custom colors used in the app.
///
/// Often apps need more colors than the default [MaterialColor] provides.
/// For example a specific yellow used to display dutch license plates.
///
/// This color extension provides a way to add custom colors to the app.
///
/// They can be used like this:
/// ```dart
///  context.colorExtension
///     <AppColorExtension>()?.licencePlateColor;
/// ```
@immutable
class AppColorExtension extends ThemeExtension<AppColorExtension> {
  /// Create a new instance of [AppColorExtension]
  const AppColorExtension({
    required this.licencePlateColor,
  });

  /// The color of the licence plate
  final Color licencePlateColor;

  @override
  AppColorExtension copyWith({
    Color? licencePlateColor,
  }) {
    return AppColorExtension(
      licencePlateColor: licencePlateColor ?? this.licencePlateColor,
    );
  }

  @override
  AppColorExtension lerp(
    AppColorExtension? other,
    double t,
  ) {
    if (other is! AppColorExtension) {
      return this;
    }
    return AppColorExtension(
      licencePlateColor:
          Color.lerp(licencePlateColor, other.licencePlateColor, t) ??
              licencePlateColor,
    );
  }
}
