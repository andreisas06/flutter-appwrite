import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../../shared/custom_about_list_tile.dart';
import '../../terms_and_conditions/terms_and_conditions_page.dart';
import '../cubit/profile_cubit.dart';
import '../views/profile/profile_page.dart';
import '../views/settings/settings_page.dart';
import 'profile_and_more_item.dart';

/// The details of the user profile.
class ProfileDetails extends StatelessWidget {
  /// Creates a new [ProfileDetails] instance.
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (BuildContext context, ProfileState state) {
        return switch (state) {
          ProfileLoadedState _ => Column(
              children: <Widget>[
                ProfileAndMoreItem(
                  icon: Icons.person,
                  title: 'Profile details',
                  onTap: () => context.goNamed(ProfilePage.name),
                ),
                ProfileAndMoreItem(
                  icon: Icons.email,
                  title: state.profile.email,
                ),
                ProfileAndMoreItem(
                  icon: Icons.settings,
                  title: l10n.settings,
                  onTap: () => context.goNamed(SettingsPage.name),
                ),
                ProfileAndMoreItem(
                  icon: Icons.shield,
                  title: 'Terms and conditions',
                  onTap: () => context.goNamed(TermsAndConditionsPage.name),
                ),
                CustomAboutListTile(
                  child: Text(context.l10n.about),
                ),
              ],
            ),
          ProfileErrorState _ => Center(
              child: Text(_getErrorText(state.code, context.l10n)),
            ),
          _ => const Center(child: CircularProgressIndicator()),
        };
      },
    );
  }

  String _getErrorText(ProfileExceptionCode code, AppLocalizations l10n) {
    return switch (code) {
      _ => l10n.profileNotFound,
    };
  }
}
