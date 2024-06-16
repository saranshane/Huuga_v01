import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static Future<void> saveText(String key, String text) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, text);
  }
}
