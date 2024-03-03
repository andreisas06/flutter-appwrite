import 'package:flutter/material.dart';

import '../../constants/sizes_constants.dart';
import '../../extensions/build_context_extensions.dart';

/// A section as part of a larger list of sections that contains a title,
/// a divider and the section content.
class Section extends StatelessWidget {
  /// Creates a new [Section] instance.
  const Section({
    required this.title,
    required this.children,
    super.key,
  });

  /// The title of the section.
  final String title;

  /// The children of the section.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: Sizes.s16),
          child: Text(title, style: theme.textTheme.titleMedium),
        ),
        const SizedBox(height: Sizes.s16),
        ...children,
        const Divider(),
        const SizedBox(height: Sizes.s16),
      ],
    );
  }
}
