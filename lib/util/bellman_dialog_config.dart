import 'package:bellman/theme/constants.dart';
import 'package:flutter/material.dart';

class BellmanDialogConfig {
  final Duration transitionDuration;
  final Widget Function(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation)?
      builder;
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
}
