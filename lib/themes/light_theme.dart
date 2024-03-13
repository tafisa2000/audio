import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
      background: Colors.grey.shade300,
      primary: Colors.grey.shade500,
      secondary: Colors.grey.shade200,
      inversePrimary: Colors.grey.shade900),
  // textTheme: TextTheme()
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.black), // Set text color for light mode
    bodyText2: TextStyle(color: Colors.black), // Set text color for light mode
  ),
);
