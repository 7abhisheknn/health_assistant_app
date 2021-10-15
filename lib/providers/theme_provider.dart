import 'package:flutter/material.dart';

/// widget to contain all sorts of themes for the app
class ThemeProvider with ChangeNotifier {
  String currentTheme = 'light';
  Map<String, ThemeData> appTheme = {
    'dark': ThemeData.dark(),
    'light': ThemeData.light(),
    'terminal': ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.grey,
      ).copyWith(
        secondary: Colors.green,
      ),
      // textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.purple)),
      // above line for more specific customization
    ),
  };
}
