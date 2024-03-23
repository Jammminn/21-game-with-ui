import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
  brightness: Brightness.light,
  background:
      Color.fromARGB(255, 212, 202, 205), // Background for buttons and app.
  onBackground:
      Color.fromARGB(255, 127, 99, 110), // Visible but not distracting.
  surfaceVariant:
      Color.fromARGB(70, 50, 50, 50), // For the radio button selected.
  primary: Color.fromARGB(255, 4, 21, 31), // for text light purple.
  onPrimary: Color.fromARGB(255, 4, 21, 31), // Large header text.
  tertiary: Color.fromARGB(255, 127, 209, 185), // For the play button.
  onTertiary: Color.fromARGB(255, 20, 19, 1), // For the play button text.
  shadow: Color.fromARGB(200, 0, 0, 0), // shadow parts of the buttons
  surfaceTint: Color.fromARGB(255, 255, 255,
      255), // For the parts where the light "shines" on the buttons.
));
