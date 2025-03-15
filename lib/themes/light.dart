import 'package:flutter/material.dart';


final colorScheme = ColorScheme(
  brightness: Brightness.light, 
  primary: Colors.green,
  onPrimary: Colors.black, 
  secondary: Colors.black, 
  onSecondary: Colors.white, 
  error: Colors.red, 
  onError: Colors.black, 
  surface: Colors.white, 
  onSurface: Colors.black
);


final textTheme = TextTheme(
  headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
  headlineMedium: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
  headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
  titleLarge: TextStyle(fontSize: 25, color: Colors.black),
  titleMedium: TextStyle(fontSize: 18, color: Colors.black),
  titleSmall: TextStyle(fontSize: 15, color: Colors.black),
  labelLarge: TextStyle(fontSize: 20, color: Colors.black),
  labelMedium: TextStyle(fontSize: 18, color: Colors.black),
  labelSmall: TextStyle(fontSize: 10, color: colorScheme.primary),
  bodyMedium: TextStyle(fontSize: 15, color: Colors.black)
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
  canvasColor: const Color.fromARGB(255, 206, 206, 206),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all<Color?>(Color.fromARGB(255, 35, 35, 35)),
    trackColor: WidgetStateProperty.all<Color?>(const Color.fromARGB(255, 207, 207, 207)),
  ),
);