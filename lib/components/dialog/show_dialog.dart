import 'package:bellman/bellman.dart';
import 'package:bellman/data/bellman_data.dart';
import 'package:bellman/util/bellman_dialog_config.dart';
import 'package:flutter/material.dart';

/// Manually display the Bellman dialog
///
/// Works similarly to [showDialog], except that it takes in the Bellman [data] to display in the
/// dialog. Optionally, you can pass in [dialogConfig] options to specify configurations on
/// the dialog behaviour.
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
        (_, __, ___) {
          return BellmanDialog(data: data);
        },
  );
}
