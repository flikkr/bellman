import 'package:bellman/data/content/changelog.dart';
import 'package:bellman/data/content/bellman_content_interface.dart';
import 'package:bellman/theme/constants.dart';
import 'package:flutter/material.dart';

/// Used for displaying changes to your app in a bulleted list.
///
/// Provide a list of changes by passing data in [changelog]. If you want to build a custom UI
/// for each item in the changelog, use [itemBuilder] to build items by index.
class BellmanChangelog implements IBellmanContent {
  final List<Changelog> changelog;
  final Widget Function(BuildContext context, int index)? itemBuilder;

  BellmanChangelog({
    required this.changelog,
    this.itemBuilder,
  });

  @override
  Widget display(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(
        left: paddingValue,
        right: paddingValue,
        bottom: paddingValue,
      ),
      children: changelog.asMap().entries.map(
        (entry) {
          if (itemBuilder != null) {
            return itemBuilder!(context, entry.key);
          } else {
            return _displaySingleChangelog(
              context: context,
              changelog: entry.value,
            );
          }
        },
      ).toList(),
    );
  }

  Widget _displaySingleChangelog({
    required BuildContext context,
    required Changelog changelog,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          changelog.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        yGap,
        ...changelog.changes
            .map(
              (change) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('- '),
                    Expanded(child: SelectableText(change)),
                  ],
                ),
              ),
            )
            .toList(),
        yGap,
      ],
    );
  }
}
