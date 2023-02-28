// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shared_preferences/shared_preferences.dart';

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
  }) : assert(trackingId == null ? true : trackingId.isNotEmpty);

  BellmanConfig copyWith({
    String? apiKey,
    String? projectId,
    String? trackingId,
    bool? showOnceOnAppStart,
    bool? showAlwaysOnAppStart,
    Duration? showAfterDuration,
    void Function()? showAfterFunctionEnd,
    Duration? transitionDuration,
  }) {
    assert(apiKey?.isNotEmpty ?? true);
    assert(projectId?.isNotEmpty ?? true);
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
