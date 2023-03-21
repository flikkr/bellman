import 'package:shared_preferences/shared_preferences.dart';

/// Wrapper around shared preferences to handle local storage functionalities
class BellmanStorage {
  /// Key to use for setting whether the dialog has been seen or not
  static const seenKey = 'bellman-seen';

  final SharedPreferences sharedPreferences;
  bool hasSeenInSession = false;

  BellmanStorage({
    required this.sharedPreferences,
  });

  /// Clear all Bellman data from local storage
  Future<void> clearStorage() async {
    await sharedPreferences.remove(seenKey);
  }

  /// [hasSeenBellman] indicates whether the dialog has been shown to the user and is set to `true`
  /// if that is the case
  bool get hasSeenBellman => sharedPreferences.getBool(seenKey) ?? false;
  set hasSeenBellman(bool? hasSeen) {
    if (hasSeen == null) {
      sharedPreferences.remove(seenKey);
    }
    sharedPreferences.setBool(seenKey, hasSeen!);
  }
}
