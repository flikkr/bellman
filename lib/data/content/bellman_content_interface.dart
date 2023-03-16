import 'package:flutter/material.dart';

/// Interface for implementing content to display in the Bellman widget
/// 
/// Implement [IBellmanContent] and override the [display] method to display your own UI.
abstract class IBellmanContent {
  Widget display(BuildContext context);
}
