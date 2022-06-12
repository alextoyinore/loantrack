import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const THEME_STATUS = "themeNumber";
  static const ONBOARDING = 'onboarding';

  setThemeNumber(int value) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setInt(THEME_STATUS, value);
  }

  Future<int> getThemeNumber() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getInt(THEME_STATUS) ?? 0;
  }

  setOnboarding(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setBool(ONBOARDING, value);
  }

  Future<bool> getOnboarding() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(ONBOARDING) ?? true;
  }
}
