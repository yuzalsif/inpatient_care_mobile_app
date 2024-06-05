import 'package:shared_preferences/shared_preferences.dart';

class BaseUrlStorage {
  static String baseUrlStorageKey = 'BASE_URL_STORAGE_KEY';

  static Future<SharedPreferences> _prefs() async {
    return await SharedPreferences.getInstance();
  }

  static Future<String> get baseUrl =>
      _prefs().then((value) => value.getString(baseUrlStorageKey) ?? '');

  static Future<void> setBaseUrl(String baseUrl) =>
      _prefs().then((value) => value.setString(baseUrlStorageKey, baseUrl));

  static Future<void> clearBaseUrl() =>
      _prefs().then((value) => value.remove(baseUrlStorageKey));
}
