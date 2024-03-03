import 'package:flutter/material.dart';
import '../../../constants/sizes_constants.dart';

/// The view to display one of the profile details.
class ProfileAndMoreItem extends StatelessWidget {
  /// Creates a new [ProfileAndMoreItem] instance.
  const ProfileAndMoreItem({
    required this.icon,
    required this.title,
    this.onTap,
    super.key,
  });

  /// The title of the item.
  final String title;

  /// The leading icon in front of the title.
  final IconData icon;

  /// The callback when the item is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(Sizes.s16),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 24,
              ),
              const SizedBox(width: Sizes.s16),
              Expanded(child: Text(title)),
              const Icon(Icons.arrow_forward_ios, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
