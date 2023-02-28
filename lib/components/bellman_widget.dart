import 'package:bellman/components/show_dialog.dart';
import 'package:bellman/util/bellman_config.dart';
import 'package:bellman/util/bellman_data.dart';
import 'package:bellman/util/bellman_storage.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Bellman extends StatefulWidget {
  final Widget child;
  final BellmanConfig config;
  final BellmanData data;

  Bellman({
    super.key,
    required this.child,
    required this.config,
    required this.data,
  })  : assert(!(config.showAlwaysOnAppStart && config.showOnceOnAppStart)),
        assert(!(config.showAfterDuration != null && config.showAfterFunctionEnd != null));

  @override
  State<Bellman> createState() => _BellmanState();
}

class _BellmanState extends State<Bellman> {
  late BellmanStorage bellmanStorage;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _showDialog(context),
      builder: (context, snapshot) => widget.child,
    );
  }

  Future<void> _showDialog(BuildContext context) async {
    final config = widget.config;
    // check whether a dialog is currently being shown
    if (ModalRoute.of(context)?.isCurrent != true) {
      Navigator.pop(context);
    }
    final sharedPreferences = await SharedPreferences.getInstance();
    bellmanStorage = BellmanStorage(sharedPreferences: sharedPreferences);
    if (config.showAlwaysOnAppStart) {
      // return;
    } else if (config.showOnceOnAppStart) {
      if (bellmanStorage.hasSeenDialog(trackingId: config.trackingId)) {
        return;
      }
    }
    if (config.showAfterFunctionEnd != null) {
      config.showAfterFunctionEnd?.call();
    } else if (config.showAfterDuration != null) {
      await Future.delayed(config.showAfterDuration!);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showBellmanDialog(
        context: context,
        transitionDuration: config.transitionDuration,
      ).then((_) {
        bellmanStorage.setHasSeenDialog(hasSeen: true);
      });
    });
  }
}
