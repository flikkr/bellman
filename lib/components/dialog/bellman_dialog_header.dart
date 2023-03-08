import 'package:bellman/theme/constants.dart';
import 'package:flutter/material.dart';

class BellmanDialogHeader extends StatelessWidget {
  final Widget? title;

  const BellmanDialogHeader({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(paddingValue),
        child: Row(
          children: [
            Expanded(
              child: title ??
                  Text(
                    "What's new!",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              constraints: const BoxConstraints(),
              color: Theme.of(context).colorScheme.onPrimary,
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }
}
