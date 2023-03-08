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

  BellmanConfig({
    this.displayOption = AppStartDisplay.once,
    this.showAfterDuration,
    this.showAfterFunctionEnd,
  }) : assert(!(showAfterDuration != null && showAfterFunctionEnd != null));

  BellmanConfig copyWith({
    AppStartDisplay? displayOption,
    Duration? showAfterDuration,
    void Function()? showAfterFunctionEnd,
  }) {
    return BellmanConfig(
      displayOption: displayOption ?? this.displayOption,
      showAfterDuration: showAfterDuration ?? this.showAfterDuration,
      showAfterFunctionEnd: showAfterFunctionEnd ?? this.showAfterFunctionEnd,
    );
  }
}
