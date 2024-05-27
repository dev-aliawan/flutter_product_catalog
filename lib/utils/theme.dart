import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'Montserrat-Arabic',
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF5F5F5),
    ),
    primaryColor: const Color(0xFF3EB86F),
    primarySwatch: const MaterialColor(0xFF3EB86F, {
      50: Color(0xFFE6F5EC),
      100: Color(0xFFC1E6D0),
      200: Color(0xFF97D6B2),
      300: Color(0xFF6DC693),
      400: Color(0xFF4CB87A),
      500: Color(0xFF3EB86F),
      600: Color(0xFF35A463),
      700: Color(0xFF2C8E54),
      800: Color(0xFF237A46),
      900: Color(0xFF125C30),
    }),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF3EB86F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Colors.grey),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Colors.blue),
      ),
      contentPadding: const EdgeInsets.all(16.0),
      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16.0),
    ),
  );
}
