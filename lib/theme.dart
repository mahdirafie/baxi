import 'package:flutter/material.dart';

class LightTheme {
  static const Color surface = Colors.white;
  static const Color variantSurfaceColor = Color.fromARGB(255, 240, 240, 240);
  static const Color onSurface = Colors.black;
  static const Color backgroundColor = Colors.white;
  static const Color onBackground = Colors.black;
  static const Color primary = Colors.yellow;
  static const Color primaryVariantColor = Colors.black;
  static const Color onPrimary = Colors.black;
  static const Color onPrimaryVariantColor = Colors.white;
  static const Color secondary = Colors.black;
  static const Color onSecondary = Colors.yellow;
  static const Color primaryVariant = Colors.yellow;

  static const Color primaryTextColor = Colors.black;
  static const Color secondaryTextColor = Colors.grey;

  static Color dividerColor = Colors.grey.withOpacity(0.3);
  static ElevatedButtonThemeData elevatedButton1 = ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(onPrimary),
          foregroundColor: MaterialStatePropertyAll(primary), ));
}
