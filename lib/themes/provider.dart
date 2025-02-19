import 'package:flutter/material.dart';
import 'package:onegid/utils/prefs.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _mode = ThemeMode.light;

  ThemeMode get mode => _mode;

  void set mode(ThemeMode value) {
    _mode = value;
    notifyListeners();  
  }

  ThemeProvider() {
    getMemoryTheme();
  }

  void getMemoryTheme() async {
    final String? theme = await getPrefs('theme');
    if (theme != null){
      switch (theme) {
        case 'light':
          _mode = ThemeMode.light;
          notifyListeners();  
        case 'dark':
          _mode = ThemeMode.dark;
          notifyListeners();
      }
    }
  }
}