import 'package:flutter/material.dart';

import 'package:bellman/theme/constants.dart';

typedef BellmanDialogBuilder = Widget Function(
    BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation);

/// Configuration options for the Bellman dialog widget
///
/// [transitionDuration], [barrierDismissible], [barrierColor], [barrierLabel], and [builder]
/// are parameters used in Flutter's [showGeneralDialog] widget, therefore the documentation
/// is unchanged from the original implementation. [constraints] allows you to change the min/max
/// width/height of the dialog, defaults [kDialogConstraints].
class BellmanDialogConfig {
  final Duration transitionDuration;
  final BellmanDialogBuilder? builder;
  final bool barrierDismissible;
  final Color barrierColor;
  final String? barrierLabel;
  final BoxConstraints constraints;

  BellmanDialogConfig({
    this.transitionDuration = kDialogTransitionDuration,
    this.builder,
    this.barrierDismissible = kDialogBarrierDismissible,
    this.barrierColor = kDialogBarrierColor,
    this.barrierLabel,
    BoxConstraints? constraints,
  }) : constraints = kDialogConstraints;

  BellmanDialogConfig copyWith({
    Duration? transitionDuration,
    BellmanDialogBuilder? builder,
    bool? barrierDismissible,
    Color? barrierColor,
    String? barrierLabel,
    BoxConstraints? constraints,
  }) {
    return BellmanDialogConfig(
      transitionDuration: transitionDuration ?? this.transitionDuration,
      builder: builder ?? this.builder,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      barrierColor: barrierColor ?? this.barrierColor,
      barrierLabel: barrierLabel ?? this.barrierLabel,
      constraints: constraints ?? this.constraints,
    );
  }
}
