import 'package:bellman/components/dialog/bellman_dialog.dart';
import 'package:bellman/data/bellman_data.dart';
import 'package:bellman/theme/bellman_style.dart';
import 'package:bellman/util/bellman_config.dart';
import 'package:bellman/util/bellman_dialog_config.dart';
import 'package:bellman/util/bellman_storage.dart';
import 'package:flutter/material.dart';

class Bellman extends InheritedWidget {
  final BellmanConfig? config;
  final BellmanStorage storage;
  final BellmanData? data;
  final BellmanDialogConfig? dialogConfig;
  final BellmanStyle? style;

  const Bellman({
    super.key,
    required super.child,
    required this.storage,
    this.config,
    this.data,
    this.dialogConfig,
    this.style,
  });

  void clearStorage() {
    storage.clearStorage();
  }

  static Bellman? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Bellman>();
  }

  /// Find the closest Bellman widget up the widget tree
  static Bellman of(BuildContext context) {
    final Bellman? result = maybeOf(context);
    assert(result != null, 'No Bellman found in context');
    return result!;
  }

  /// Manually display the Bellman dialog
  ///
  /// Works similarly to Flutter's [showDialog], except that it takes in the Bellman [data] to
  /// display. Optionally, you can pass in [dialogConfig] options to specify configurations on
  /// the dialog behaviour. Style the dialog by passing in a custom [style], or leave it null
  /// to use the default BellmanStyle.
  Future<void> showDialog({
    required BuildContext context,
    required BellmanData data,
    BellmanDialogConfig? dialogConfig,
    BellmanStyle? style,
  }) {
    style ??= BellmanStyle();
    dialogConfig ??= BellmanDialogConfig();
    return showGeneralDialog(
      context: context,
      barrierDismissible: dialogConfig.barrierDismissible,
      barrierColor: dialogConfig.barrierColor,
      barrierLabel: dialogConfig.barrierLabel,
      transitionDuration: dialogConfig.transitionDuration,
      pageBuilder: dialogConfig.builder ??
          (_, __, ___) {
            return BellmanDialog(
              data: data,
              style: style,
              dialogConfig: dialogConfig,
            );
          },
    );
  }

  Bellman copyWith({
    Widget? child,
    BellmanConfig? config,
    BellmanData? data,
    BellmanStorage? storage,
    BellmanDialogConfig? dialogConfig,
    BellmanStyle? style,
  }) {
    return Bellman(
      config: config ?? this.config,
      data: data ?? this.data,
      storage: storage ?? this.storage,
      dialogConfig: dialogConfig ?? this.dialogConfig,
      style: style ?? this.style,
      child: child ?? this.child,
    );
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    oldWidget = oldWidget as Bellman;
    return config != oldWidget.config ||
        data != oldWidget.data ||
        storage != oldWidget.storage ||
        style != oldWidget.style ||
        child != oldWidget.child ||
        dialogConfig != oldWidget.dialogConfig;
  }
}
