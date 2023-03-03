import 'package:bellman/data/content/bellman_content_interface.dart';

class BellmanCategory {
  final String? id;
  final String displayTitle;
  final IBellmanContent? content;
  final String? deeplink;

  BellmanCategory({
    this.id,
    required this.displayTitle,
    this.content,
    this.deeplink,
  });
}
