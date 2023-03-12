import 'package:bellman/data/content/bellman_content_interface.dart';
import 'package:bellman/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

/// Used for displaying content in the Bellman widget in Markdown format
/// 
/// Provide your formatted Markdown data to [markdown] parameter. If your data contains a link,
/// handle the tap by passing a function in [onTapLink]. [selectable] flag handles whether the
/// text can be highlighted through a cursor, defaults to `false`.
class BellmanMarkdown implements IBellmanContent {
  final String markdown;
  final MarkdownTapLinkCallback? onTapLink;
  final bool selectable;

  BellmanMarkdown({
    required this.markdown,
    this.onTapLink,
    this.selectable = false,
  });

  @override
  Widget display(BuildContext context) {
    return Markdown(
      data: markdown,
      padding: const EdgeInsets.only(
        left: paddingValue,
        right: paddingValue,
        bottom: paddingValue,
      ),
      onTapLink: onTapLink,
      selectable: selectable,
      extensionSet: md.ExtensionSet(
        md.ExtensionSet.gitHubFlavored.blockSyntaxes,
        [
          md.EmojiSyntax(),
          ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
        ],
      ),
    );
  }
}
