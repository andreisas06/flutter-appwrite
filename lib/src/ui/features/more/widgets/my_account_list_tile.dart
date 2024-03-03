import 'package:flutter/material.dart';

/// The list tile used in the MyAccountView.
class MyAccountListTile extends ListTile {
  /// Creates a new instance of [MyAccountListTile].
  MyAccountListTile({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    Icon trailingIcon = const Icon(Icons.chevron_right),
    Icon? leadingIcon,
    super.key,
  }) : super(
          title: Text(
            title,
            style: titleStyle,
          ),
          subtitle: Text(
            subtitle,
            style: subtitleStyle,
          ),
          trailing: trailingIcon,
          leading: leadingIcon,
          onTap: onTap,
        );
}
