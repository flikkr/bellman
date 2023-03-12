import 'package:bellman/data/content/bellman_content_interface.dart';
import 'package:bellman/theme/constants.dart';
import 'package:flutter/material.dart';

/// A builder for displaying customized UI in the Bellman widget
/// 
/// Provide a custom [builder] to tell Bellman how to display your content. [contentPadding] will
/// pad the content and defaults to the normal [paddingValue] defined in Bellman constants.
class BellmanCustomBuilder implements IBellmanContent {
  final EdgeInsets contentPadding;
  final Widget Function(BuildContext context) builder;

  BellmanCustomBuilder({
    required this.builder,
    EdgeInsets? padding,
  }) : contentPadding = padding ??
            const EdgeInsets.only(
              left: paddingValue,
              right: paddingValue,
              bottom: paddingValue,
            );

  @override
  Widget display(BuildContext context) {
    return Padding(
      padding: contentPadding,
      child: builder(context),
    );
  }
}
