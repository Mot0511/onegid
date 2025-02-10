import 'package:flutter/material.dart';

final textTheme = TextTheme(
  headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
  titleLarge: TextStyle(fontSize: 25)
);

final themeLight = ThemeData(
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.green),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 34, 180, 115)),
      foregroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
    ),
  ),
  textTheme: textTheme
);