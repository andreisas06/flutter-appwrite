import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../../../extensions/build_context_extensions.dart';
import '../cubit/profile_cubit.dart';
import '../other/profile_header_painter.dart';

/// The header of the profile page.
class ProfileHeader extends StatelessWidget {
  /// Creates a new [ProfileHeader] instance.
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomPaint(
          painter: ProfilePainter(context.colorScheme.primary),
          child: const SizedBox(
            height: 160,
            width: double.infinity,
          ),
        ),
        Positioned(
          left: context.width * 0.5 - 64,
          top: 16,
          child: CircleAvatar(
            radius: 64,
            backgroundColor: context.colorScheme.surface,
            child: BlocSelector<ProfileCubit, ProfileState, Uint8List?>(
              selector: (ProfileState state) {
                if (state is ProfileLoadedState) {
                  return state.profile.profileImage;
                }
                return null;
              },
              builder: (BuildContext context, Uint8List? profileImg) {
                return CircleAvatar(
                  radius: 60,
                  child: ClipOval(
                    child: SizedBox.expand(
                      child: profileImg == null
                          ? Image.asset(
                              Assets.baseflowLogo.path,
                            )
                          : Image.memory(
                              profileImg,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
