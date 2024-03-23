import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    background:
        Color.fromARGB(255, 30, 31, 34), // Background for buttons and app.
    onBackground:
        Color.fromARGB(255, 100, 110, 150), // Visible but not distracting.
    surfaceVariant: Color.fromARGB(255, 40, 41, 45),
    primary: Color.fromARGB(255, 235, 210, 220), // for text light purple.
    onPrimary: Color.fromARGB(255, 220, 210, 235), // slightly lighter text
    tertiary: Color.fromARGB(255, 144, 194, 144), // accent color
    onTertiary: Color.fromARGB(255, 25, 30, 25),
    shadow: Color.fromARGB(255, 0, 0, 0), // shadow parts of the buttons
    surfaceTint: Color.fromARGB(199, 100, 100,
        100), // For the parts where the light "shines" on the buttons.
  ),
);
