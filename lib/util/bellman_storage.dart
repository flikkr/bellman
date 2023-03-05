// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shared_preferences/shared_preferences.dart';

class BellmanStorage {
  static const seenKey = 'bellman-seen';
  static const lastSeenVersionKey = 'last-seen-version';

  SharedPreferences sharedPreferences;

  BellmanStorage({
    required this.sharedPreferences,
  });

  Future<bool> clearStorage() => sharedPreferences.clear();

  bool get hasSeenDialog {
    return sharedPreferences.getBool(seenKey) ?? false;
  }

  set hasSeenDialog(bool? hasSeen) {
    if (hasSeen == null) {
      sharedPreferences.remove(seenKey);
    }
    sharedPreferences.setBool(seenKey, hasSeen!);
  }

  String? get lastSeenVersion {
    return sharedPreferences.getString(lastSeenVersionKey);
  }

  set lastSeenVersion(String? version) {
    if (version == null) {
      sharedPreferences.remove(lastSeenVersionKey);
    }
    sharedPreferences.setString(lastSeenVersionKey, version!);
  }
}
