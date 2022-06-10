import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/providers/preferences.dart';

class ThemeManager with ChangeNotifier {
  final ThemePreferences themePrefs = ThemePreferences();

  int _themeNumber = -1;
  int get themeNumber => _themeNumber;

  void setTheme(int value) {
    _themeNumber = value;
    themePrefs.setThemeNumber(value);
    notifyListeners();
  }
}
