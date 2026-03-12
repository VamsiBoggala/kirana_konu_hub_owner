import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';

/// App Theme Configuration for Kirana Konu
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  /// Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryBlue,
        secondary: AppColors.primaryBlueLight,
        surface: AppColors.lightCard,
        background: AppColors.lightBackground,
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.lightText,
        onBackground: AppColors.lightText,
        onError: AppColors.white,
      ),

      // Scaffold Background
      scaffoldBackgroundColor: AppColors.lightBackground,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.white),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        elevation: 2,
        shadowColor: AppColors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: const TextStyle(fontFamily: 'Poppins', fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.lightText),
        displayMedium: const TextStyle(fontFamily: 'Poppins', fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.lightText),
        displaySmall: const TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.lightText),
        headlineLarge: const TextStyle(fontFamily: 'Poppins', fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.lightText),
        headlineMedium: const TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.lightText),
        headlineSmall: const TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.lightText),
        titleLarge: const TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.lightText),
        titleMedium: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.lightText),
        titleSmall: const TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.lightText),
        bodyLarge: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.lightText),
        bodyMedium: const TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.lightText),
        bodySmall: const TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.lightTextSecondary),
        labelLarge: const TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.lightText),
        labelMedium: const TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.lightText),
        labelSmall: const TextStyle(fontFamily: 'Poppins', fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.lightTextSecondary),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.grey300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: AppColors.lightTextSecondary),
        hintStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: AppColors.grey400),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: AppColors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryBlue,
          textStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: AppColors.lightText, size: 24),

      // Divider Theme
      dividerTheme: const DividerThemeData(color: AppColors.lightDivider, thickness: 1, space: 1),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        elevation: 4,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.grey500,
        selectedLabelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.normal),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }

  /// Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryBlue,
        secondary: AppColors.primaryBlueLight,
        surface: AppColors.darkCard,
        background: AppColors.darkBackground,
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.darkText,
        onBackground: AppColors.darkText,
        onError: AppColors.white,
      ),

      // Scaffold Background
      scaffoldBackgroundColor: AppColors.darkBackground,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkCard,
        foregroundColor: AppColors.darkText,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.darkText),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 2,
        shadowColor: AppColors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: const TextStyle(fontFamily: 'Poppins', fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.darkText),
        displayMedium: const TextStyle(fontFamily: 'Poppins', fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.darkText),
        displaySmall: const TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.darkText),
        headlineLarge: const TextStyle(fontFamily: 'Poppins', fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.darkText),
        headlineMedium: const TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.darkText),
        headlineSmall: const TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.darkText),
        titleLarge: const TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.darkText),
        titleMedium: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.darkText),
        titleSmall: const TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.darkText),
        bodyLarge: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.darkText),
        bodyMedium: const TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.darkText),
        bodySmall: const TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.darkTextSecondary),
        labelLarge: const TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.darkText),
        labelMedium: const TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.darkText),
        labelSmall: const TextStyle(fontFamily: 'Poppins', fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.darkTextSecondary),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkCard,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.darkDivider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.darkDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: AppColors.darkTextSecondary),
        hintStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: AppColors.grey600),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: AppColors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryBlueLight,
          textStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: AppColors.darkText, size: 24),

      // Divider Theme
      dividerTheme: const DividerThemeData(color: AppColors.darkDivider, thickness: 1, space: 1),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        elevation: 4,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkCard,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.grey500,
        selectedLabelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.normal),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
