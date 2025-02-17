import 'package:flutter/material.dart';

final primaryColor = Colors.green;

final textTheme = TextTheme(
  headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white),
  headlineMedium: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
  titleLarge: TextStyle(fontSize: 25, color: Colors.white),
  titleMedium: TextStyle(fontSize: 18, color: Colors.white),
  titleSmall: TextStyle(fontSize: 15, color: Colors.white),
  labelMedium: TextStyle(color: Colors.white),
  labelSmall: TextStyle(fontSize: 10, color: primaryColor)
);


final darkTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.black,
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
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: textTheme.labelMedium,
      focusColor: Colors.white,
      fillColor: Colors.black54
    ),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all<Color>(Colors.black54)
    )
  ),
  
  textTheme: textTheme
);