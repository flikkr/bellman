// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:bellman/data/bellman_category.dart';

/// Class used for storing the data to be displayed in a Bellman widget
/// 
/// [title] is the widget to be shown in the header section of the dialog. If not specified,
/// defaults to "What's new!"
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
