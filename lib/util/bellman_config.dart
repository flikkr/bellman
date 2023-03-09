import 'package:bellman/util/bellman_dialog_config.dart';

/// Decides the behaviour of Bellman during app start-up.
/// 
/// [once] means that Bellman will only be shown once to the user, after which a flag will be
/// written to shared preferences so that it is not shown anymore. [always] means that Bellman
/// will always be shown to the user, regardless if they have been seen the dialog. [never] is used
/// when the dialog should not be shown to the user at app start, but dialog can still be shown 
/// by using [showBellmanDialog]
enum AppStartDisplay {
  once,
  always,
  never,
}

/// Configurations for how Bellman should be shown to the user.
/// 
/// Use [displayOption] to decide when to show the dialog to the user. [showAfterDuration] will
/// display the dialog after a given duration since the app start. [showAfterFunctionEnd] takes
/// a function and will show the dialog only once the function has finished executing, useful . 
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
