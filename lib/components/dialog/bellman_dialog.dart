import 'package:bellman/components/dialog/bellman_dialog_content.dart';
import 'package:bellman/components/dialog/bellman_dialog_header.dart';
import 'package:bellman/theme/bellman_style.dart';
import 'package:bellman/theme/constants.dart';
import 'package:bellman/util/bellman_dialog_config.dart';
import 'package:flutter/material.dart';
import 'package:bellman/data/bellman_data.dart';

class BellmanDialog extends StatelessWidget {
  final BellmanData data;
  final BellmanStyle? style;
  final BellmanDialogConfig? dialogConfig;

  const BellmanDialog({
    super.key,
    required this.data,
    this.style,
    this.dialogConfig,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveStyle = style ?? BellmanStyle();
    final effectiveDialogConfig = dialogConfig ?? BellmanDialogConfig();
    final screenSize = MediaQuery.of(context).size;
    double insetPaddingValue;
    if (screenSize.width < smallBreakpoint) {
      insetPaddingValue = 25.0;
    } else {
      insetPaddingValue = 50.0;
    }
    final dialogInsetPadding = EdgeInsets.all(insetPaddingValue);
    return Dialog(
      insetPadding: dialogInsetPadding,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: effectiveStyle.dialogBorderRadius,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: effectiveStyle.backgroundColor ?? theme.dialogBackgroundColor,
          boxShadow: kElevationToShadow[16],
        ),
        constraints: effectiveDialogConfig.constraints,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BellmanDialogHeader(title: data.title),
            Expanded(child: BellmanDialogContent(categories: data.categories)),
          ],
        ),
      ),
    );
  }
}
