import 'package:bellman/bellman.dart';
import 'package:bellman/data/bellman_data.dart';
import 'package:bellman/theme/constants.dart';
import 'package:bellman/util/bellman_dialog_config.dart';
import 'package:flutter/material.dart';

Future<void> showBellmanDialog({
  required BuildContext context,
  required BellmanData data,
  BellmanDialogConfig? dialogConfig,
}) {
  dialogConfig ??= BellmanDialogConfig();
  return showGeneralDialog(
    context: context,
    barrierDismissible: dialogConfig.barrierDismissible,
    barrierColor: dialogConfig.barrierColor,
    barrierLabel: dialogConfig.barrierLabel,
    transitionDuration: dialogConfig.transitionDuration,
    pageBuilder: dialogConfig.builder ??
        (context, animation, secondaryAnimation) {
          return BellmanDialog(data: data);
        },
  );
}
