import 'package:bellman/bellman.dart';
import 'package:bellman/data/bellman_data.dart';
import 'package:flutter/material.dart';

Future<void> showBellmanDialog({
  required BuildContext context,
  BellmanData? data,
  Widget Function(BuildContext, Animation<double>, Animation<double>)? pageBuilder,
  bool barrierDismissible = true,
  Color barrierColor = Colors.black54,
  String? barrierLabel,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  Duration? transitionDuration,
}) {
  data ??= Bellman.maybeOf(context)?.data;
  assert(data != null, "Data must be provided to the Bellman widget or dialog directly");
  return showGeneralDialog(
    context: context,
    anchorPoint: anchorPoint,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    barrierLabel: barrierLabel ?? '',
    pageBuilder: (context, animation, secondaryAnimation) {
      return BellmanDialog(data: data!);
    },
    transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
    routeSettings: routeSettings,
  );
}
