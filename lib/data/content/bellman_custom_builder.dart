import 'package:bellman/data/content/bellman_content_interface.dart';
import 'package:flutter/src/widgets/framework.dart';

class BellmanCustomBuilder implements IBellmanContent {
  final Widget Function(BuildContext context) builder;

  BellmanCustomBuilder({
    required this.builder,
  });

  @override
  Widget display(BuildContext context) {
    return builder(context);
  }
}
