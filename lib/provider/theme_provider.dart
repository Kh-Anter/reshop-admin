import 'package:flutter/material.dart';

import 'package:responsivedashboard/services/theme_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool isDarkTheme = false;

  Future<bool> init() async {
    isDarkTheme = await ThemePreference().getTheme();
    return isDarkTheme;
  }

  void changeTheme() async {
    isDarkTheme = !isDarkTheme;
    await ThemePreference().changeTheme(isDarkTheme);
    notifyListeners();
  }
}
