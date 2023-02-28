import 'package:bellman/bellman.dart';
import 'package:flutter/material.dart';

Future<void> showBellmanDialog({
  required BuildContext context,
  WidgetBuilder? builder,
  bool barrierDismissible = true,
  Color barrierColor = Colors.black54,
  String? barrierLabel,
  bool useSafeArea = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  Duration? transitionDuration,
}) {
  return showGeneralDialog(
    context: context,
    anchorPoint: anchorPoint,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    barrierLabel: barrierLabel ?? '',
    pageBuilder: (context, animation, secondaryAnimation) {
      return const BellmanDialog();
    },
    transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
    routeSettings: routeSettings,
  );
}
