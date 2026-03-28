import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/themes.dart';

class ThemeProvider extends ChangeNotifier {
  String _currentThemeKey = 'night_blue';
  late SharedPreferences _prefs;

  String get currentThemeKey => _currentThemeKey;
  ThemeData get currentTheme => AppThemes.getTheme(_currentThemeKey);

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _currentThemeKey = _prefs.getString('theme_key') ?? 'night_blue';
    notifyListeners();
  }

  Future<void> setTheme(String themeKey) async {
    _currentThemeKey = themeKey;
    await _prefs.setString('theme_key', themeKey);
    notifyListeners();
  }
}
