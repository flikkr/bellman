import 'package:bellman/data/content/bellman_content_interface.dart';
import 'package:bellman/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class BellmanMarkdown implements IBellmanContent {
  final String markdown;
  final MarkdownTapLinkCallback? onTapLink;

  BellmanMarkdown({
    required this.markdown,
    this.onTapLink,
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
      selectable: true,
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
