import 'package:bellman/util/bellman_dialog_config.dart';

enum AppStartDisplay {
  once,
  always,
  never,
}

class BellmanConfig {
  final AppStartDisplay? displayOption;
  final Duration? showAfterDuration;
  final void Function()? showAfterFunctionEnd;
  final BellmanDialogConfig? dialogConfig;

  BellmanConfig({
    this.displayOption = AppStartDisplay.once,
    this.showAfterDuration,
    this.showAfterFunctionEnd,
    this.dialogConfig,
  }) : assert(!(showAfterDuration != null && showAfterFunctionEnd != null));

  BellmanConfig copyWith({
    AppStartDisplay? displayOption,
    Duration? showAfterDuration,
    void Function()? showAfterFunctionEnd,
    BellmanDialogConfig? dialogConfig,
  }) {
    return BellmanConfig(
      displayOption: displayOption ?? this.displayOption,
      showAfterDuration: showAfterDuration ?? this.showAfterDuration,
      showAfterFunctionEnd: showAfterFunctionEnd ?? this.showAfterFunctionEnd,
      dialogConfig: dialogConfig ?? this.dialogConfig,
    );
  }
}
