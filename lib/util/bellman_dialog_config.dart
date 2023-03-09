// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:bellman/theme/constants.dart';

typedef BellmanDialogBuilder = Widget Function(
    BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation);

class BellmanDialogConfig {
  final Duration transitionDuration;
  final BellmanDialogBuilder? builder;
  final bool barrierDismissible;
  final Color barrierColor;
  final String? barrierLabel;

  BellmanDialogConfig({
    this.transitionDuration = kDialogTransitionDuration,
    this.builder,
    this.barrierDismissible = kDialogBarrierDismissible,
    this.barrierColor = kDialogBarrierColor,
    this.barrierLabel,
  });

  BellmanDialogConfig copyWith({
    Duration? transitionDuration,
    bool? barrierDismissible,
    Color? barrierColor,
    String? barrierLabel,
  }) {
    return BellmanDialogConfig(
      transitionDuration: transitionDuration ?? this.transitionDuration,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      barrierColor: barrierColor ?? this.barrierColor,
      barrierLabel: barrierLabel ?? this.barrierLabel,
    );
  }
}
