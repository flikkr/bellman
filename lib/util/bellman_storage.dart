import 'package:shared_preferences/shared_preferences.dart';

/// Wrapper around shared preferences to handle local storage functionalities
class BellmanStorage {
  /// Key to use for setting whether the dialog has been seen or not
  static const seenKey = 'bellman-seen';
  static const lastSeenVersionKey = 'last-seen-version';

  final SharedPreferences sharedPreferences;

  BellmanStorage({
    required this.sharedPreferences,
  });

  /// Clear all Bellman data from local storage
  Future<void> clearStorage() async {
    await sharedPreferences.remove(seenKey);
    await sharedPreferences.remove(lastSeenVersionKey);
  }

  /// [hasSeenDialog] indicates whether the dialog has been shown to the user and is set to `true`
  /// if that is the case
  bool get hasSeenDialog => sharedPreferences.getBool(seenKey) ?? false;
  set hasSeenDialog(bool? hasSeen) {
    if (hasSeen == null) {
      sharedPreferences.remove(seenKey);
    }
    sharedPreferences.setBool(seenKey, hasSeen!);
  }

  String? get lastSeenVersion => sharedPreferences.getString(lastSeenVersionKey);
  set lastSeenVersion(String? version) {
    if (version == null) {
      sharedPreferences.remove(lastSeenVersionKey);
    }
    sharedPreferences.setString(lastSeenVersionKey, version!);
  }
}
