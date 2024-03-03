import 'package:flutter/material.dart';

import '../../../../localizations/l10n.dart';
import '../appearance/theme_section.dart';

/// The view to manage the theme settings.
class SettingsView extends StatelessWidget {
  /// Creates a new instance of [SettingsView].
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ThemeSection(),
            ],
          ),
        ),
      ),
    );
  }
}
