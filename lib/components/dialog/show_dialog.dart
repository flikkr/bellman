import 'package:bellman/bellman.dart';
import 'package:bellman/data/bellman_data.dart';
import 'package:bellman/theme/constants.dart';
import 'package:flutter/material.dart';

Future<void> showBellmanDialog({
  required BuildContext context,
  BellmanData? data,
  Widget Function(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation)? builder,
  bool barrierDismissible = kDialogBarrierDismissible,
  Color barrierColor = kDialogBarrierColor,
  String? barrierLabel,
  Duration transitionDuration = kDialogTransitionDuration,
}) {
  data ??= Bellman.maybeOf(context)?.data;
  assert(data != null, "Data must be provided to the Bellman widget or dialog directly");
  return showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    barrierLabel: barrierLabel,
    transitionDuration: transitionDuration,
    pageBuilder: builder ??
        (context, animation, secondaryAnimation) {
          return BellmanDialog(data: data!);
        },
  );
}
