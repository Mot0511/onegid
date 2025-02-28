import 'package:flutter/material.dart';

final primaryColor = Colors.green;

final textTheme = TextTheme(
  headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white),
  headlineMedium: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
  titleLarge: TextStyle(fontSize: 25, color: Colors.white),
  titleMedium: TextStyle(fontSize: 18, color: Colors.white),
  titleSmall: TextStyle(fontSize: 15, color: Colors.white),
  labelLarge: TextStyle(fontSize: 20, color: Colors.white),
  labelMedium: TextStyle(color: Colors.white),
  labelSmall: TextStyle(fontSize: 10, color: primaryColor),
  bodyMedium: TextStyle(fontSize: 15, color: Colors.white)
);


final darkTheme = ThemeData(
  primaryColor: primaryColor,
  canvasColor: const Color.fromARGB(255, 35, 35, 35),
  scaffoldBackgroundColor: Colors.black,
  textTheme: textTheme,
  progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(primaryColor),
      foregroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    labelStyle: textTheme.labelMedium,
    focusColor: Colors.white
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all<Color?>(Colors.white),
    trackColor: WidgetStateProperty.all<Color?>(Color.fromARGB(255, 35, 35, 35)),
  ),
  
);