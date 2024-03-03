import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../extensions/build_context_extensions.dart';
import '../../../../localizations/generated/app_localizations.dart';
import '../../../../localizations/l10n.dart';
import '../../../shared/section.dart';
import '../../cubit/language_cubit.dart';
import '../../cubit/profile_cubit.dart';
import '../../widgets/my_account_list_tile.dart';
import '../../widgets/profile_avatar.dart';
import '../language/language_page.dart';

/// The content of the `MyAccountView` page.
class ProfileContent extends StatelessWidget {
  /// Creates a new instance of `MyAccountContent`.
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = context.theme;
    return SafeArea(
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (BuildContext context, ProfileState state) {
          final bool hasProfile = state is ProfileLoadedState;
          return Column(
            children: <Widget>[
              Section(
                title: l10n.basicInfo,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      l10n.profilePicture,
                      style: theme.textTheme.labelMedium,
                    ),
                    subtitle: Text(
                      l10n.profilePictureText,
                      style: theme.textTheme.bodySmall,
                    ),
                    trailing: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: ProfileAvatar(),
                    ),
                  ),
                  MyAccountListTile(
                    title: l10n.name,
                    subtitle: hasProfile ? state.profile.name : l10n.unknown,
                    onTap: () {},
                  ),
                  MyAccountListTile(
                    title: l10n.dateOfBirth,
                    subtitle: '6th of June, 1999',
                    onTap: () {},
                  ),
                ],
              ),
              Section(
                title: l10n.contactInformation,
                children: <Widget>[
                  MyAccountListTile(
                    title: l10n.email,
                    subtitle: hasProfile ? state.profile.email : l10n.unknown,
                    onTap: () {},
                  ),
                  MyAccountListTile(
                    title: l10n.phoneNumber,
                    subtitle:
                        hasProfile ? state.profile.phoneNumber : l10n.unknown,
                    onTap: () {},
                  ),
                ],
              ),
              Section(
                title: l10n.accessibility,
                children: <Widget>[
                  BlocBuilder<LanguageCubit, String>(
                    builder: (BuildContext context, String languageCode) {
                      return MyAccountListTile(
                        title: l10n.language,
                        subtitle: languageCode.toUpperCase(),
                        leadingIcon: const Icon(Icons.language),
                        onTap: () => context.goNamed(LanguagePage.name),
                      );
                    },
                  ),
                ],
              ),
              Section(
                title: l10n.address,
                children: <Widget>[
                  MyAccountListTile(
                    title: l10n.homeAddress,
                    subtitle: hasProfile ? state.profile.address : l10n.unknown,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
