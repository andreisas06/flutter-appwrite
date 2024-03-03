import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../../../constants/sizes_constants.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import 'example_details_page.dart';
import 'new_example_page.dart';

/// The [HomeView] is the home page of the app.
class HomeView extends StatelessWidget {
  /// Creates a new instance of the [HomeView] widget.
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final List<Card> list = List<Card>.generate(4, (int index) {
      return Card(
        child: ListTile(
          leading: CircleAvatar(
            radius: 20,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Image.asset(Assets.baseflowLogo.path),
            ),
          ),
          title: const Text('Example Card'),
          subtitle: const Text('View the details of this example'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.goNamed(ExampleDetailsPage.name),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homePageTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(Sizes.s16),
        children: list,
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('home_fab'),
        // This tag is necessary if more than one fab is alive in the state
        // of the app.
        heroTag: 'home_fab',
        onPressed: () => context.goNamed(NewExamplePage.name),
        child: const Icon(Icons.add),
      ),
    );
  }
}
