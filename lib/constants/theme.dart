import 'package:flutter/material.dart';

class CustomThemeData {
  static const primaryColor = Color(0xFF3F51B5);
  static const primaryColorDark = Color(0xFF303F9F);
  static const primaryColorLight = Color(0xFFC5CAE9);
  static const accentColor = Color(0xFF00BCD4);
  static const primaryTextColor = Color(0xFF212121);
  static const secondaryTextColor = Color(0xFF757575);
  static const dividerColor = Color(0xFFBDBDBD);

  static ThemeData getThemeData() {
    return ThemeData(
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLight,
      hintColor: accentColor,
      textTheme: getTextTheme(),
      appBarTheme: AppBarTheme(
        titleTextStyle: getTextTheme().headlineMedium,
        iconTheme: IconThemeData(color: primaryTextColor),
        actionsIconTheme: IconThemeData(color: primaryTextColor),
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: primaryTextColor,
        elevation: 5,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: dividerColor),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.black87,
        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
        ),
      ),
    );
  }

  static ThemeData getDarkThemeData() {
    return ThemeData(
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLight,
      hintColor: accentColor,
      brightness: Brightness.dark,
      textTheme: getTextTheme(),
      appBarTheme: AppBarTheme(
        titleTextStyle: getTextTheme().headlineMedium,
        iconTheme: IconThemeData(color: primaryTextColor),
        actionsIconTheme: IconThemeData(color: primaryTextColor),
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.black87,
        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
        ),
      ),
    );
  }

  static TextTheme getTextTheme() {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      displayMedium: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      displaySmall: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: primaryTextColor),
      bodyMedium: TextStyle(fontSize: 14, color: primaryTextColor),
      bodySmall: TextStyle(fontSize: 12, color: primaryTextColor),
      labelLarge: TextStyle(fontSize: 16, color: secondaryTextColor),
      labelMedium: TextStyle(fontSize: 14, color: secondaryTextColor),
      labelSmall: TextStyle(fontSize: 12, color: secondaryTextColor),
    );
  }
}
