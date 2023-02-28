// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shared_preferences/shared_preferences.dart';

class BellmanStorage {
  static const seenKey = 'saw-dialog';

  SharedPreferences sharedPreferences;

  BellmanStorage({
    required this.sharedPreferences,
  });

  Future<bool> clearStorage() => sharedPreferences.clear();

  bool hasSeenDialog({String? trackingId}) {
    String key = _getFormattedKey(trackingId);
    return sharedPreferences.getBool(key) ?? false;
  }

  Future<void> setHasSeenDialog({String? trackingId, required bool hasSeen}) async {
    String key = _getFormattedKey(trackingId);
    sharedPreferences.setBool(key, hasSeen);
  }

  String _getFormattedKey(String? trackingId) {
    String key = seenKey;
    if (trackingId != null && trackingId.isNotEmpty) {
      key = '$trackingId-$key';
    }
    return key;
  }
}
