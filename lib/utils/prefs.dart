import 'package:shared_preferences/shared_preferences.dart';

Future<void> setPrefs(key, value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<String?> getPrefs(key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? res = prefs.getString(key);

  return res;
}