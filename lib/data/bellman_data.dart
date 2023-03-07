import 'package:bellman/data/bellman_category.dart';
import 'package:flutter/material.dart';

class BellmanData {
  final Widget? title;
  final List<BellmanCategory> categories;

  BellmanData({
    this.title,
    required this.categories,
  });
}
