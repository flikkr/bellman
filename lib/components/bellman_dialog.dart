import 'package:bellman/components/bellman_dialog_content.dart';
import 'package:bellman/components/bellman_dialog_header.dart';
import 'package:bellman/theme/bellman_dialog_style.dart';
import 'package:bellman/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:bellman/data/bellman_data.dart';

class BellmanDialog extends StatelessWidget {
  final BellmanData data;
  final BellmanDialogStyle? style;
  final EdgeInsets? insetPadding;
  final BoxConstraints? constraints;
  final double contentHeight;

  const BellmanDialog({
    super.key,
    required this.data,
    this.style,
    this.insetPadding,
    this.constraints,
    this.contentHeight = 300,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bellmanDialogStyle = style ?? BellmanDialogStyle();
    final screenSize = MediaQuery.of(context).size;
    double insetPaddingValue;
    if (screenSize.width < smallBreakpoint) {
      insetPaddingValue = 25.0;
    } else {
      insetPaddingValue = 50.0;
    }
    final dialogPadding = insetPadding ?? EdgeInsets.all(insetPaddingValue);
    return Dialog(
      insetPadding: dialogPadding,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: bellmanDialogStyle.borderRadius ?? BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: bellmanDialogStyle.dialogBackgroundColor ?? theme.dialogBackgroundColor,
          boxShadow: kElevationToShadow[16],
        ),
        constraints: constraints ?? const BoxConstraints(maxWidth: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BellmanDialogHeader(
              title: data.title,
            ),
            BellmanDialogContent(
              categories: data.categories,
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}
