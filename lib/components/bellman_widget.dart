import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bellman/components/bellman_provider.dart';
import 'package:bellman/data/bellman_data.dart';
import 'package:bellman/theme/bellman_style.dart';
import 'package:bellman/util/bellman_config.dart';
import 'package:bellman/util/bellman_dialog_config.dart';
import 'package:bellman/util/bellman_storage.dart';

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
/// or not by using [dialogConfig].
/// To configure UI elements of the widget, use [style].
// class BellmanWidget extends StatefulWidget {
//   final Widget child;
//   final BellmanData? data;
//   final BellmanConfig? config;
//   final BellmanDialogConfig? dialogConfig;
//   final BellmanStyle? style;

//   const BellmanWidget({
//     super.key,
//     required this.child,
//     required this.data,
//     this.config,
//     this.dialogConfig,
//     this.style,
//   });

//   @override
//   State<BellmanWidget> createState() => _BellmanWidgetState();
// }

// class _BellmanWidgetState extends State<BellmanWidget> {
//   late BellmanConfig config;
//   late BellmanDialogConfig dialogConfig;
//   late BellmanStyle style;

//   @override
//   void initState() {
//     super.initState();
//     config = widget.config ?? BellmanConfig();
//     dialogConfig = widget.dialogConfig ?? BellmanDialogConfig();
//     style = widget.style ?? BellmanStyle();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: SharedPreferences.getInstance(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final storage = BellmanStorage(sharedPreferences: snapshot.data!);
//           return Bellman(
//             storage: storage,
//             config: config,
//             dialogConfig: dialogConfig,
//             style: style,
//             child: FutureBuilder(
//               future: _showDialog(context: context, storage: storage),
//               builder: (context, snapshot) => widget.child,
//             ),
//           );
//         } else {
//           // Shared prefs not ready yet
//           return Container();
//         }
//       },
//     );
//   }

//   Future<void> _showDialog({
//     required BuildContext context,
//     required BellmanStorage storage,
//   }) async {
//     final data = widget.data;
//     if (data == null) return;
//     // check whether a dialog is currently being shown
//     if (ModalRoute.of(context)?.isCurrent != true) {
//       Navigator.pop(context);
//     }
//     final dontShow = config.displayOption == AppStartDisplay.never;
//     final hasSeenDialog = config.displayOption == AppStartDisplay.once && storage.hasSeenDialog;
//     if (dontShow || hasSeenDialog) return;
//     if (config.showAfterFunctionEnd != null) {
//       config.showAfterFunctionEnd?.call();
//     } else if (config.showAfterDuration != null) {
//       await Future.delayed(config.showAfterDuration!);
//     }
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Bellman.of(context)
//           .showDialog(
//         context: context,
//         data: data,
//         dialogConfig: dialogConfig,
//         style: style,
//       )
//           .then((_) {
//         storage.hasSeenDialog = true;
//       });
//     });
//   }
// }

class BellmanWidget extends StatelessWidget {
  final Widget child;
  final BellmanData? data;
  final BellmanConfig? config;
  final BellmanDialogConfig? dialogConfig;
  final BellmanStyle? style;

  const BellmanWidget({
    super.key,
    required this.child,
    required this.data,
    this.config,
    this.dialogConfig,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Bellman(
            storage: BellmanStorage(sharedPreferences: snapshot.data!),
            data: data,
            config: config,
            dialogConfig: dialogConfig,
            style: style,
            child: BellmanWidgetChild(child: child),
          );
        } else {
          // Shared prefs not ready yet
          return Container();
        }
      },
    );
  }
}

class BellmanWidgetChild extends StatefulWidget {
  final Widget child;

  const BellmanWidgetChild({
    super.key,
    required this.child,
  });

  @override
  State<BellmanWidgetChild> createState() => _BellmanWidgetChildState();
}

class _BellmanWidgetChildState extends State<BellmanWidgetChild> {
  late BellmanConfig config;
  late BellmanDialogConfig dialogConfig;
  late BellmanStyle style;

  @override
  Widget build(BuildContext context) {
    final bellman = Bellman.of(context);
    final storage = bellman.storage;
    config = bellman.config ?? BellmanConfig();
    dialogConfig = bellman.dialogConfig ?? BellmanDialogConfig();
    style = bellman.style ?? BellmanStyle();

    return FutureBuilder(
      future: _showDialog(context: context, storage: storage),
      builder: (context, snapshot) => widget.child,
    );
  }

  Future<void> _showDialog({
    required BuildContext context,
    required BellmanStorage storage,
  }) async {
    final bellman = Bellman.of(context);
    final data = bellman.data;

    if (data == null) return;
    final dontShow = config.displayOption == AppStartDisplay.never;
    final hasSeenDialog =
        (config.displayOption == AppStartDisplay.once && storage.hasSeenBellman) || storage.hasSeenInSession;

    if (dontShow || hasSeenDialog) return;
    if (config.showAfterFunctionEnd != null) {
      config.showAfterFunctionEnd?.call();
    } else if (config.showAfterDuration != null) {
      await Future.delayed(config.showAfterDuration!);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // check whether a dialog is currently being shown
      if (ModalRoute.of(context)?.isCurrent != true) {
        Navigator.pop(context);
      }
      Bellman.of(context)
          .showDialog(
        context: context,
        data: data,
        dialogConfig: dialogConfig,
        style: style,
      )
          .then((_) {
        storage.hasSeenBellman = true;
        storage.hasSeenInSession = true;
      });
    });
  }
}
