import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../../authentication/cubit/authentication_cubit.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/profile_background.dart';
import '../widgets/profile_details.dart';
import '../widgets/profile_header.dart';

/// The view displaying the user profile.
class MoreView extends StatelessWidget {
  /// Creates a new [MoreView] instance.
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: <Widget>[
        ProfileBackground(),
        _ProfileContent(),
      ],
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: context.colorScheme.primary,
        title: BlocSelector<ProfileCubit, ProfileState, String?>(
          selector: (ProfileState state) {
            return state is ProfileLoadedState ? state.profile.name : null;
          },
          builder: (BuildContext context, String? name) {
            return Text(
              name ?? l10n.profilePageTitle,
              style: context.textTheme.titleLarge?.copyWith(
                color: context.colorScheme.onPrimary,
              ),
            );
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const ProfileHeader(),
          const Expanded(child: ProfileDetails()),
          Padding(
            padding: const EdgeInsets.all(Sizes.s24),
            child: FilledButton(
              onPressed: context.read<AuthenticationCubit>().signOut,
              child: Text(l10n.signOut),
            ),
          ),
        ],
      ),
    );
  }
}
