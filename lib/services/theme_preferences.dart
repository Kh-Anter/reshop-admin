import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  Future changeTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("THEME_IsDark", value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("THEME_IsDark") ?? false;
  }
}
