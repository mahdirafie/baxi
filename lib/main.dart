import 'package:baxi/bottomsheets/baxi_box_bottom_sheet.dart';
import 'package:baxi/map/choose_org.dart';
import 'package:baxi/splash/splash_screen.dart';
import 'package:baxi/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const defaultTextStyle =
        TextStyle(fontFamily: 'IranYekan', color: LightTheme.primaryTextColor);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: LightTheme.primary, width: 2))),
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(LightTheme.primary),
                foregroundColor:
                    MaterialStatePropertyAll(LightTheme.onPrimary))),
        dividerTheme: DividerThemeData(color: LightTheme.dividerColor, thickness: 1, space: 0),
        textTheme: TextTheme(
          displayLarge: defaultTextStyle.copyWith(
              fontSize: 96, fontWeight: FontWeight.w800),
          displayMedium: defaultTextStyle.copyWith(
              fontSize: 60, fontWeight: FontWeight.w800),
          displaySmall: defaultTextStyle.copyWith(
              fontSize: 48, fontWeight: FontWeight.w800),
          headlineMedium: defaultTextStyle.copyWith(
              fontSize: 34, fontWeight: FontWeight.w600),
          headlineSmall: defaultTextStyle.copyWith(
              fontSize: 22, fontWeight: FontWeight.w600),
          titleLarge: defaultTextStyle.copyWith(
              fontSize: 20, fontWeight: FontWeight.w500),
          titleMedium: defaultTextStyle.copyWith(
              fontSize: 18, fontWeight: FontWeight.w500),
          bodyLarge: defaultTextStyle.copyWith(
              fontSize: 16, fontWeight: FontWeight.w500),
          bodyMedium: defaultTextStyle.copyWith(
              fontSize: 14, fontWeight: FontWeight.w400),
          bodySmall: defaultTextStyle.copyWith(
              fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
          labelLarge: defaultTextStyle.copyWith(
              fontSize: 14, fontWeight: FontWeight.w500),
        ),
        colorScheme: const ColorScheme.light(
            primary: LightTheme.primary,
            onPrimary: LightTheme.onPrimary,
            surface: LightTheme.surface,
            surfaceVariant: LightTheme.variantSurfaceColor,
            onSurface: LightTheme.onSurface,
            secondary: LightTheme.secondary,
            onSecondary: LightTheme.onSecondary,
            primaryContainer: LightTheme.primaryVariantColor,
            onPrimaryContainer: LightTheme.onPrimaryVariantColor,
            background: LightTheme.backgroundColor,
            onBackground: LightTheme.onBackground),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
