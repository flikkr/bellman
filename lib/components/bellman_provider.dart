import 'package:bellman/data/bellman_data.dart';
import 'package:bellman/util/bellman_config.dart';
import 'package:bellman/util/bellman_storage.dart';
import 'package:flutter/material.dart';

class Bellman extends InheritedWidget {
  final BellmanConfig config;
  final BellmanStorage storage;
  final BellmanData? data;

  const Bellman({
    super.key,
    required super.child,
    required this.config,
    required this.storage,
    this.data,
  });

  static Bellman? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Bellman>();
  }

  static Bellman of(BuildContext context) {
    final Bellman? result = maybeOf(context);
    assert(result == null, 'No Bellman found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    oldWidget = oldWidget as Bellman;
    return config != oldWidget.config || data != oldWidget.data || storage != oldWidget.storage;
  }

  Bellman copyWith({
    Widget? child,
    BellmanConfig? config,
    BellmanData? data,
    BellmanStorage? storage,
  }) {
    return Bellman(
      config: config ?? this.config,
      data: data ?? this.data,
      storage: storage ?? this.storage,
      child: child ?? this.child,
    );
  }
}
