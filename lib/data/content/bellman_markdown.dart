import 'package:bellman/data/content/bellman_content_interface.dart';
import 'package:flutter/material.dart';

class BellmanMarkdown implements IBellmanContent {
  final String rawMarkdown;

  BellmanMarkdown(this.rawMarkdown);

  @override
  Widget display() {
    return Center(child: Text(rawMarkdown));
  }
}
