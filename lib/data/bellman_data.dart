import 'package:flutter/material.dart';

import 'package:bellman/data/bellman_category.dart';

/// Class used for storing the data to be displayed in a Bellman widget
///
/// [title] is the widget to be shown in the header section of the dialog. If not specified,
/// defaults to showing a text widget with the text "What's new!". [categories] contains the main
/// data to be shown to the user.
class BellmanData {
  final Widget? title;
  final List<BellmanCategory> categories;

  BellmanData({
    this.title,
    required this.categories,
  });

  BellmanData copyWith({
    Widget? title,
    List<BellmanCategory>? categories,
  }) {
    return BellmanData(
      title: title ?? this.title,
      categories: categories ?? this.categories,
    );
  }
}
