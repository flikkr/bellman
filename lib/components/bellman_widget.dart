import 'package:bellman/components/dialog/show_dialog.dart';
import 'package:bellman/util/bellman_config.dart';
import 'package:bellman/data/bellman_data.dart';
import 'package:bellman/util/bellman_dialog_config.dart';
import 'package:bellman/util/bellman_storage.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

/// The core widget to enable Bellman in your application
///
/// To use Bellman, simply wrap your app with this widget.
/// ```
/// void main() {
///     runApp(
///         BellmanWidget(child: MyApp()),
///     );
/// }
/// ```
///
/// Pass the rest of your widgets through [child]. Provide your data to display through [data].
///
/// Optionally, you can configure how Bellman should behave by passing in a [config] object, like
/// whether to show it on app start or not.
/// You can also configure different options for the dialog, like whether to make it dismissible
/// or not.
class BellmanWidget extends StatefulWidget {
  final Widget child;
  final BellmanConfig? config;
  final BellmanData? data;
  final BellmanDialogConfig? dialogConfig;

  const BellmanWidget({
    super.key,
    required this.child,
    required this.data,
    this.config,
    this.dialogConfig,
  });

  @override
  State<BellmanWidget> createState() => _BellmanWidgetState();
}

class _BellmanWidgetState extends State<BellmanWidget> {
  late BellmanConfig config;
  late BellmanDialogConfig dialogConfig;

  @override
  void initState() {
    super.initState();
    config = widget.config ?? BellmanConfig();
    dialogConfig = widget.dialogConfig ?? BellmanDialogConfig();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final storage = BellmanStorage(sharedPreferences: snapshot.data!);
          return FutureBuilder(
            future: _showDialog(
              context: context,
              storage: storage,
              config: config,
              dialogConfig: dialogConfig,
            ),
            builder: (context, snapshot) => widget.child,
          );
        } else {
          // Shared prefs not ready yet
          return Container();
        }
      },
    );
  }

  Future<void> _showDialog({
    required BuildContext context,
    required BellmanStorage storage,
    required BellmanConfig config,
    required BellmanDialogConfig dialogConfig,
  }) async {
    final data = widget.data;
    if (data == null) return;
    // check whether a dialog is currently being shown
    if (ModalRoute.of(context)?.isCurrent != true) {
      Navigator.pop(context);
    }
    final dontShow = config.displayOption == AppStartDisplay.never;
    final hasSeenDialog = config.displayOption == AppStartDisplay.once && storage.hasSeenDialog;
    if (dontShow || hasSeenDialog) return;
    if (config.showAfterFunctionEnd != null) {
      config.showAfterFunctionEnd?.call();
    } else if (config.showAfterDuration != null) {
      await Future.delayed(config.showAfterDuration!);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showBellmanDialog(
        context: context,
        data: data,
        dialogConfig: dialogConfig,
      ).then((_) {
        storage.hasSeenDialog = true;
      });
    });
  }
}
