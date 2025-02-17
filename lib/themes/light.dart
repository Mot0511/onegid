import 'package:flutter/material.dart';

final primaryColor = Colors.green;

final textTheme = TextTheme(
  headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
  headlineMedium: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
  titleLarge: TextStyle(fontSize: 25),
  titleMedium: TextStyle(fontSize: 18),
  titleSmall: TextStyle(fontSize: 15, color: Colors.white),
  labelMedium: TextStyle(color: primaryColor),
  labelSmall: TextStyle(fontSize: 10, color: primaryColor)
);

final ligthTheme = ThemeData(
  primaryColor: primaryColor,
  progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(primaryColor),
      foregroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
    ),
  ),
  textTheme: textTheme
);