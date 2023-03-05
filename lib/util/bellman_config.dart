enum AppStartDisplay {
  once,
  always,
  never,
}

class BellmanConfig {
  final AppStartDisplay? displayOption;
  final Duration? showAfterDuration;
  final void Function()? showAfterFunctionEnd;
  final Duration? transitionDuration;

  BellmanConfig({
    this.displayOption = AppStartDisplay.once,
    this.showAfterDuration,
    this.showAfterFunctionEnd,
    this.transitionDuration,
  }) : assert(!(showAfterDuration != null && showAfterFunctionEnd != null));

  BellmanConfig copyWith({
    AppStartDisplay? displayOption,
    Duration? showAfterDuration,
    void Function()? showAfterFunctionEnd,
    Duration? transitionDuration,
  }) {
    return BellmanConfig(
      displayOption: displayOption ?? this.displayOption,
      showAfterDuration: showAfterDuration ?? this.showAfterDuration,
      showAfterFunctionEnd: showAfterFunctionEnd ?? this.showAfterFunctionEnd,
      transitionDuration: transitionDuration ?? this.transitionDuration,
    );
  }
}
