import 'package:bellman/components/bellman_dialog_content.dart';
import 'package:bellman/theme/bellman_dialog_style.dart';
import 'package:bellman/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:bellman/data/bellman_data.dart';

class BellmanDialog extends StatelessWidget {
  final BellmanData data;
  final BellmanDialogStyle? style;
  final EdgeInsets? insetPadding;
  final BoxConstraints? constraints;

  const BellmanDialog({
    super.key,
    required this.data,
    this.style,
    this.insetPadding,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final bellmanStyle = style ?? BellmanDialogStyle();
    final screenSize = MediaQuery.of(context).size;
    double insetPaddingValue;
    if (screenSize.width < smallBreakpoint) {
      insetPaddingValue = 25.0;
    } else if (screenSize.width < mediumBreakpoint) {
      insetPaddingValue = 50.0;
    } else {
      insetPaddingValue = 100.0;
    }
    final dialogPadding = insetPadding ?? EdgeInsets.symmetric(horizontal: insetPaddingValue);
    return Material(
      color: Colors.transparent,
      child: Center(
        child: AnimatedPadding(
          padding: dialogPadding,
          duration: const Duration(milliseconds: 300),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: kElevationToShadow[16],
            ),
            constraints: constraints ?? const BoxConstraints(maxWidth: 768),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: paddingValue,
                    right: paddingValue,
                    top: paddingValue,
                  ),
                  child: Text(
                    data.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                BellmanDialogContent(
                  categories: data.categories,
                ),
                Padding(
                  padding: const EdgeInsets.all(paddingValue),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
