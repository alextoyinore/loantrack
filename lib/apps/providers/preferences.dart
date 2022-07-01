import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const THEME_STATUS = "themeNumber";
  static const ONBOARDING = 'onboarding';
  static String MONTHLY_INCOME =
      '${FirebaseAuth.instance.currentUser!.uid}MonthlyIncome';
  static String MARITAL_STATUS =
      '${FirebaseAuth.instance.currentUser!.uid}MaritalStatus';

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

  Future<double> getMonthlyIncome() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getDouble(MONTHLY_INCOME) ?? 0;
  }

  setMonthlyIncome(double value) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setDouble(MONTHLY_INCOME, value);
  }

  Future<String> getMaritalStatus() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(MARITAL_STATUS) ?? '';
  }

  setMaritalStatus(String value) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(MARITAL_STATUS, value);
  }
}
