import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.light(
      background: Colors.grey.shade900,
      primary: Colors.grey.shade600,
      secondary: Colors.grey.shade800,
      inversePrimary: Colors.grey.shade300),
  // textTheme: const TextTheme(titleMedium: TextStyle(color: Colors.white)),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.white), // Set text color for dark mode
    bodyText2: TextStyle(color: Colors.white), // Set text color for dark mode
  ),
);
