// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shared_preferences/shared_preferences.dart';

class BellmanStorage {
  static const seenKey = 'bellman-seen';

  SharedPreferences sharedPreferences;

  BellmanStorage({
    required this.sharedPreferences,
  });

  Future<bool> clearStorage() => sharedPreferences.clear();

  bool hasSeenDialog() {
    return sharedPreferences.getBool(seenKey) ?? false;
  }

  Future<void> setHasSeenDialog(bool hasSeen) async {
    sharedPreferences.setBool(seenKey, hasSeen);
  }
}
