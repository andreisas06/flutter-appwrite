import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../cubit/profile_cubit.dart';
import 'image_picker_options.dart';

/// The avatar of the profile page.
class ProfileAvatar extends StatelessWidget {
  /// Creates a new instance of [ProfileAvatar].
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileCubit, ProfileState, Uint8List?>(
      selector: (ProfileState state) {
        if (state is ProfileLoadedState) {
          return state.profile.profileImage;
        }
        return null;
      },
      builder: (BuildContext context, Uint8List? image) => GestureDetector(
        onTap: () => _showImagePickerOptions(context),
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey.shade200,
          child: ClipOval(
            child: SizedBox(
              height: 100,
              width: 100,
              child: image == null
                  ? Image.asset(Assets.baseflowLogo.path)
                  : Image.memory(image, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return const ImagePickerOptions();
      },
    );
  }
}
