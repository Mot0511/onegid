import 'package:flutter/material.dart';


final colorScheme = ColorScheme(
  brightness: Brightness.dark, 
  primary: Colors.green,
  onPrimary: Colors.green, 
  secondary: Colors.black, 
  onSecondary: Colors.black, 
  error: Colors.red, 
  onError: Colors.red, 
  surface: Colors.white, 
  onSurface: Colors.white
);


final textTheme = TextTheme(
  headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
  headlineMedium: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
  titleLarge: TextStyle(fontSize: 25),
  titleMedium: TextStyle(fontSize: 18),
  titleSmall: TextStyle(fontSize: 15),
  labelLarge: TextStyle(fontSize: 24),
  labelMedium: TextStyle(color: colorScheme.primary),
  labelSmall: TextStyle(fontSize: 10, color: colorScheme.primary)
);

final ligthTheme = ThemeData(
  colorScheme: colorScheme,
  primaryColor: colorScheme.primary,
  progressIndicatorTheme: ProgressIndicatorThemeData(color: colorScheme.primary),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(colorScheme.primary),
      foregroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
    ),
  ),
  textTheme: textTheme,
  canvasColor: const Color.fromARGB(255, 206, 206, 206)
);