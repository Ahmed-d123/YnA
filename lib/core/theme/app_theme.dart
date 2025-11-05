import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  // --- Base Text Theme ---
  static final TextTheme _baseTextTheme = GoogleFonts.spaceGroteskTextTheme();

  // --- Dark Theme ---
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    // Use colorScheme for modern theming
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.primary,
      surface: AppColors.surfaceDark,
      onPrimary: AppColors.backgroundDark,   // Main body text
      onSurface: AppColors.textWhite,      // Text on cards
      error: Colors.redAccent,
      onError: AppColors.textWhite,
    ),

    // App Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundDark.withOpacity(0.8),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: _baseTextTheme.titleLarge?.copyWith(
        color: AppColors.textWhite,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: AppColors.textWhite),
    ),

    // Text Theme
    textTheme: _baseTextTheme.copyWith(
      // Headlines
      displayLarge: _baseTextTheme.displayLarge?.copyWith(color: AppColors.textWhite, fontWeight: FontWeight.bold),
      displayMedium: _baseTextTheme.displayMedium?.copyWith(color: AppColors.textWhite, fontWeight: FontWeight.bold),
      displaySmall: _baseTextTheme.displaySmall?.copyWith(color: AppColors.textWhite, fontWeight: FontWeight.bold),
      headlineSmall: _baseTextTheme.headlineSmall?.copyWith(color: AppColors.textWhite, fontWeight: FontWeight.bold),

      // Titles
      titleLarge: _baseTextTheme.titleLarge?.copyWith(color: AppColors.textWhite, fontWeight: FontWeight.bold),
      titleMedium: _baseTextTheme.titleMedium?.copyWith(color: AppColors.textWhite),

      // Body
      bodyLarge: _baseTextTheme.bodyLarge?.copyWith(color: AppColors.textLight),
      bodyMedium: _baseTextTheme.bodyMedium?.copyWith(color: AppColors.textMedium),

    ).apply(
      bodyColor: AppColors.textLight,
      displayColor: AppColors.textWhite,
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.backgroundDark,
        textStyle: _baseTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textWhite,
        side: const BorderSide(color: AppColors.primary),
        textStyle: _baseTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: AppColors.surfaceDark,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.black.withOpacity(0.2),
      hintStyle: _baseTextTheme.bodyLarge?.copyWith(color: AppColors.textMedium),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    ),

    // Bottom Nav Bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundDark.withOpacity(0.9),
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textMedium,
      selectedLabelStyle: _baseTextTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: _baseTextTheme.bodySmall,
      type: BottomNavigationBarType.fixed,
    ),
  );

  // --- Light Theme (Scaffold) ---
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundLight,

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primary,
      background: AppColors.backgroundLight,
      surface: AppColors.surfaceLight,
      onPrimary: AppColors.backgroundDark,
      onBackground: AppColors.textDark,
      onSurface: AppColors.textDark,
      error: Colors.red,
      onError: AppColors.textWhite,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundLight.withOpacity(0.8),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: _baseTextTheme.titleLarge?.copyWith(
        color: AppColors.textDark,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: AppColors.textDark),
    ),

    textTheme: _baseTextTheme.copyWith(
      displayLarge: _baseTextTheme.displayLarge?.copyWith(color: AppColors.textDark, fontWeight: FontWeight.bold),
      displayMedium: _baseTextTheme.displayMedium?.copyWith(color: AppColors.textDark, fontWeight: FontWeight.bold),
      displaySmall: _baseTextTheme.displaySmall?.copyWith(color: AppColors.textDark, fontWeight: FontWeight.bold),
      headlineSmall: _baseTextTheme.headlineSmall?.copyWith(color: AppColors.textDark, fontWeight: FontWeight.bold),
      titleLarge: _baseTextTheme.titleLarge?.copyWith(color: AppColors.textDark, fontWeight: FontWeight.bold),
      titleMedium: _baseTextTheme.titleMedium?.copyWith(color: AppColors.textDark),
      bodyLarge: _baseTextTheme.bodyLarge?.copyWith(color: AppColors.textDark),
      bodyMedium: _baseTextTheme.bodyMedium?.copyWith(color: AppColors.textLightDark),
    ).apply(
      bodyColor: AppColors.textDark,
      displayColor: AppColors.textDark,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.backgroundDark,
        textStyle: _baseTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textDark,
        side: const BorderSide(color: AppColors.primary),
        textStyle: _baseTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: AppColors.surfaceLight,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.black.withOpacity(0.1)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.black.withOpacity(0.05),
      hintStyle: _baseTextTheme.bodyLarge?.copyWith(color: AppColors.textLightDark),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundLight.withOpacity(0.9),
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textLightDark,
      selectedLabelStyle: _baseTextTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: _baseTextTheme.bodySmall,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
