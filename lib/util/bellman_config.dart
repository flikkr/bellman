class BellmanConfig {
  final String? trackingId;
  final bool showOnceOnAppStart;
  final bool showAlwaysOnAppStart;
  final Duration? showAfterDuration;
  final void Function()? showAfterFunctionEnd;
  final Duration? transitionDuration;

  BellmanConfig({
    this.trackingId,
    this.showOnceOnAppStart = true,
    this.showAlwaysOnAppStart = false,
    this.showAfterDuration,
    this.showAfterFunctionEnd,
    this.transitionDuration,
  })  : assert(trackingId == null ? true : trackingId.isNotEmpty),
        assert(!(showAlwaysOnAppStart && showOnceOnAppStart)),
        assert(!(showAfterDuration != null && showAfterFunctionEnd != null));

  BellmanConfig copyWith({
    String? trackingId,
    bool? showOnceOnAppStart,
    bool? showAlwaysOnAppStart,
    Duration? showAfterDuration,
    void Function()? showAfterFunctionEnd,
    Duration? transitionDuration,
  }) {
    assert(trackingId == null ? true : trackingId.isNotEmpty);
    return BellmanConfig(
      trackingId: trackingId ?? this.trackingId,
      showOnceOnAppStart: showOnceOnAppStart ?? this.showOnceOnAppStart,
      showAlwaysOnAppStart: showAlwaysOnAppStart ?? this.showAlwaysOnAppStart,
      showAfterDuration: showAfterDuration ?? this.showAfterDuration,
      showAfterFunctionEnd: showAfterFunctionEnd ?? this.showAfterFunctionEnd,
      transitionDuration: transitionDuration ?? this.transitionDuration,
    );
  }
}
