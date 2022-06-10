import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const THEME_STATUS = "themeNumber";

  setThemeNumber(int value) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setInt(THEME_STATUS, value);
  }

  Future<int> getThemeNumber() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getInt(THEME_STATUS) ?? 0;
  }
}
