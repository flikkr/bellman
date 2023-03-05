import 'package:bellman/components/bellman_provider.dart';
import 'package:bellman/components/show_dialog.dart';
import 'package:bellman/util/bellman_config.dart';
import 'package:bellman/data/bellman_data.dart';
import 'package:bellman/util/bellman_storage.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class BellmanWidget extends StatefulWidget {
  final Widget child;
  final BellmanConfig? config;
  final BellmanData? data;

  const BellmanWidget({
    super.key,
    required this.child,
    required this.data,
    this.config,
  });

  @override
  State<BellmanWidget> createState() => _BellmanWidgetState();
}

class _BellmanWidgetState extends State<BellmanWidget> {
  late BellmanConfig config;

  @override
  void initState() {
    super.initState();
    config = widget.config ?? BellmanConfig();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final storage = BellmanStorage(sharedPreferences: snapshot.data!);
          return Bellman(
            config: config,
            data: widget.data,
            storage: storage,
            child: FutureBuilder(
              future: _showDialog(context, storage),
              builder: (context, snapshot) => widget.child,
            ),
          );
        } else {
          // Sharedprefs not ready yet
          return Container();
        }
      },
    );
  }

  Future<void> _showDialog(BuildContext context, BellmanStorage storage) async {
    // check whether a dialog is currently being shown
    if (ModalRoute.of(context)?.isCurrent != true) {
      Navigator.pop(context);
    }
    final dontShow = config.displayOption == AppStartDisplay.never;
    final hasSeenDialog = config.displayOption == AppStartDisplay.once && storage.hasSeenDialog();
    if (dontShow || hasSeenDialog) return;
    if (config.showAfterFunctionEnd != null) {
      config.showAfterFunctionEnd?.call();
    } else if (config.showAfterDuration != null) {
      await Future.delayed(config.showAfterDuration!);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showBellmanDialog(
        context: context,
        data: widget.data,
        transitionDuration: config.transitionDuration,
      ).then((_) {
        storage.setHasSeenDialog(true);
      });
    });
  }
}
