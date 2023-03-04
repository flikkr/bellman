import 'package:bellman/data/content/bellman_changelog_data.dart';
import 'package:bellman/data/content/bellman_content_interface.dart';
import 'package:bellman/theme/constants.dart';
import 'package:flutter/material.dart';

class BellmanChangelog implements IBellmanContent {
  final List<ChangelogData> changelog;
  final String? appVersion;

  BellmanChangelog({
    required this.changelog,
    this.appVersion,
  });

  @override
  Widget display(BuildContext context) {
    final changelogData = ListView(
      children: changelog
          .map(
            (data) => _displaySingleChangelog(
              context: context,
              changelog: data,
            ),
          )
          .toList(),
    );

    late Widget result;
    if (appVersion != null) {
      result = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(appVersion!),
          yGap,
          changelogData,
        ],
      );
    } else {
      result = changelogData;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingValue),
      child: result,
    );
  }

  Widget _displaySingleChangelog({
    required BuildContext context,
    required ChangelogData changelog,
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
                    Expanded(child: Text(change)),
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
