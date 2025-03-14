import 'package:flutter/material.dart';

final colorScheme = ColorScheme(
  brightness: Brightness.dark, 
  primary: Colors.green,
  onPrimary: Colors.green, 
  secondary: Colors.white, 
  onSecondary: Colors.white, 
  error: Colors.red, 
  onError: Colors.red, 
  surface: Colors.black, 
  onSurface: Colors.black
);

final textTheme = TextTheme(
  headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white),
  headlineMedium: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
  headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
  titleLarge: TextStyle(fontSize: 25, color: Colors.white),
  titleMedium: TextStyle(fontSize: 18, color: Colors.white),
  titleSmall: TextStyle(fontSize: 15, color: Colors.white),
  labelLarge: TextStyle(fontSize: 20, color: Colors.white),
  labelMedium: TextStyle(fontSize: 18, color: Colors.white),
  labelSmall: TextStyle(fontSize: 10, color: colorScheme.primary),
  bodyMedium: TextStyle(fontSize: 15, color: Colors.white)
);



final darkTheme = ThemeData(
  primaryColor: colorScheme.primary,
  colorScheme: colorScheme,
  canvasColor: const Color.fromARGB(255, 35, 35, 35),
  scaffoldBackgroundColor: Colors.black,
  textTheme: textTheme,
  progressIndicatorTheme: ProgressIndicatorThemeData(color: colorScheme.primary),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(colorScheme.primary),
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