class BellmanConfig {
  final bool showOnceOnAppStart;
  final bool showAlwaysOnAppStart;
  final Duration? showAfterDuration;
  final void Function()? showAfterFunctionEnd;
  final Duration? transitionDuration;

  BellmanConfig({
    this.showOnceOnAppStart = true,
    this.showAlwaysOnAppStart = false,
    this.showAfterDuration,
    this.showAfterFunctionEnd,
    this.transitionDuration,
  })  : assert(!(showAlwaysOnAppStart && showOnceOnAppStart)),
        assert(!(showAfterDuration != null && showAfterFunctionEnd != null));

  BellmanConfig copyWith({
    bool? showOnceOnAppStart,
    bool? showAlwaysOnAppStart,
    Duration? showAfterDuration,
    void Function()? showAfterFunctionEnd,
    Duration? transitionDuration,
  }) {
    return BellmanConfig(
      showOnceOnAppStart: showOnceOnAppStart ?? this.showOnceOnAppStart,
      showAlwaysOnAppStart: showAlwaysOnAppStart ?? this.showAlwaysOnAppStart,
      showAfterDuration: showAfterDuration ?? this.showAfterDuration,
      showAfterFunctionEnd: showAfterFunctionEnd ?? this.showAfterFunctionEnd,
      transitionDuration: transitionDuration ?? this.transitionDuration,
    );
  }
}
