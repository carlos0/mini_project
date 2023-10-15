import 'package:flutter/material.dart';

class ThemeClass {
  Color lightPrimaryColor = const Color(0xff17324f);
  Color darkPrimaryColor = const Color(0xff17324f);
  Color secondaryColor = const Color(0xffffffff);
  Color accentColor = const Color(0xff4E6C86);

  
  static ThemeData lightTheme = ThemeData(
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light().copyWith(primary: _themeClass.lightPrimaryColor, secondary: _themeClass.secondaryColor)
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.dark().copyWith(primary: _themeClass.darkPrimaryColor, secondary: _themeClass.accentColor)
  );
  
}

ThemeClass _themeClass = ThemeClass();