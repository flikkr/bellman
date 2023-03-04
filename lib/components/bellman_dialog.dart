import 'package:bellman/components/bellman_dialog_content.dart';
import 'package:bellman/theme/bellman_style.dart';
import 'package:bellman/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:bellman/data/bellman_data.dart';

class BellmanDialog extends StatelessWidget {
  final BellmanData data;
  final BellmanStyle? style;

  const BellmanDialog({
    super.key,
    required this.data,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final _style = style ?? BellmanStyle();
    final screenSize = MediaQuery.of(context).size;

    return Dialog(
      child: SizedBox(
        width: 100,
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
    );
  }
}
