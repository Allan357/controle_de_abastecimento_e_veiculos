import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFFD50000);
  static const Color secondary = Color(0xFFFFFFFF);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: secondary,
      brightness: Brightness.light,
    ),

    scaffoldBackgroundColor: Colors.transparent,

    appBarTheme: AppBarTheme(
      backgroundColor: primary,
      foregroundColor: secondary,
      centerTitle: true,
      elevation: 2,
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: secondary,
        fontWeight: FontWeight.bold,
      ),
    
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: primary),
      floatingLabelStyle: TextStyle(color: primary),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
      border: OutlineInputBorder(),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: secondary,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: secondary,
      elevation: 4,
      shape: CircleBorder(),
    ),

    listTileTheme: ListTileThemeData(
      iconColor: primary,
      textColor: Colors.black87,
      selectedColor: primary,
    ),

    drawerTheme: DrawerThemeData(
      backgroundColor: secondary,
      surfaceTintColor: secondary,
    ),

    textTheme: TextTheme(
      headlineLarge: TextStyle(
          color: primary, fontSize: 32, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(
          color: primary, fontSize: 26, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: Colors.black87, fontSize: 18),
      bodyMedium: TextStyle(color: Colors.black87, fontSize: 16),
      labelLarge: TextStyle(
          color: primary, fontSize: 16, fontWeight: FontWeight.bold),
    ),

    iconTheme: IconThemeData(color: primary, size: 26),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(primary),
      trackColor: WidgetStatePropertyAll(primary.withValues(alpha: 0.25)),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStatePropertyAll(primary),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStatePropertyAll(primary),
    ),
  );

}