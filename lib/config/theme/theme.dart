import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => _themeData(Brightness.light);
  static ThemeData get dark => _themeData(Brightness.dark);

  static ThemeData _themeData(Brightness brightness) {
    final themeData = ThemeData.from(
      useMaterial3: true,
      colorScheme: brightness == Brightness.light
          ? const ColorScheme(
              brightness: Brightness.light,
              primary: Color(0xfff9d924),
              onPrimary: Color(0xFFFFFFFF),
              secondary: Color(0xFFE8BB0A),
              onSecondary: Color(0xffffffff),
              error: Color(0xff790000),
              onError: Color(0xffffffff),
              surface: Color(0xfffdfaf8),
              onSurface: Color(0xff090909),
            )
          : const ColorScheme(
              brightness: Brightness.dark,
              primary: Color(0xfff9d924),
              onPrimary: Color(0xff14110b),
              secondary: Color(0xFFE8BB0A),
              onSecondary: Color(0xff14110e),
              error: Color(0xffcf6679),
              onError: Color(0xff140c0d),
              surface: Color(0xff1c1814),
              onSurface: Color(0xffedecec),
            ),
    );

    return themeData.copyWith(
      textTheme: themeData.textTheme.apply(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      dividerTheme: const DividerThemeData(space: 0),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
