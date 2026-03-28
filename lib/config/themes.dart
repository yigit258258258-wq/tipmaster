import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  // ============================================================
  // TEMA LİSTESİ
  // ============================================================
  static const List<Map<String, dynamic>> themeList = [
    {'name': 'Gece Mavisi', 'icon': Icons.nightlight_round, 'key': 'night_blue'},
    {'name': 'Orman Yeşili', 'icon': Icons.forest, 'key': 'forest_green'},
    {'name': 'Gün Batımı', 'icon': Icons.wb_twilight, 'key': 'sunset'},
    {'name': 'Okyanus', 'icon': Icons.water, 'key': 'ocean'},
    {'name': 'Lavanta', 'icon': Icons.local_florist, 'key': 'lavender'},
    {'name': 'Kuzey Işığı', 'icon': Icons.auto_awesome, 'key': 'aurora'},
    {'name': 'Sıcak Kahve', 'icon': Icons.coffee, 'key': 'warm_coffee'},
    {'name': 'Kiraz Çiçeği', 'icon': Icons.spa, 'key': 'cherry_blossom'},
  ];

  // ============================================================
  // TEMA VERİLERİ
  // ============================================================
  static ThemeData getTheme(String key) {
    switch (key) {
      case 'night_blue':
        return _buildTheme(
          brightness: Brightness.dark,
          primary: const Color(0xFF5B8DEF),
          secondary: const Color(0xFF64FFDA),
          background: const Color(0xFF0D1B2A),
          surface: const Color(0xFF1B2838),
          card: const Color(0xFF233044),
          onPrimary: Colors.white,
          onBackground: const Color(0xFFE0E6ED),
          accent: const Color(0xFF5B8DEF),
        );
      case 'forest_green':
        return _buildTheme(
          brightness: Brightness.dark,
          primary: const Color(0xFF66BB6A),
          secondary: const Color(0xFFA5D6A7),
          background: const Color(0xFF1A2E1A),
          surface: const Color(0xFF243524),
          card: const Color(0xFF2E4230),
          onPrimary: Colors.white,
          onBackground: const Color(0xFFD7E8D0),
          accent: const Color(0xFF81C784),
        );
      case 'sunset':
        return _buildTheme(
          brightness: Brightness.dark,
          primary: const Color(0xFFFF8A65),
          secondary: const Color(0xFFFFCC02),
          background: const Color(0xFF2D1B14),
          surface: const Color(0xFF3D2820),
          card: const Color(0xFF4A322A),
          onPrimary: Colors.white,
          onBackground: const Color(0xFFF5E0D0),
          accent: const Color(0xFFFF8A65),
        );
      case 'ocean':
        return _buildTheme(
          brightness: Brightness.dark,
          primary: const Color(0xFF26C6DA),
          secondary: const Color(0xFF80DEEA),
          background: const Color(0xFF0A1929),
          surface: const Color(0xFF132F4C),
          card: const Color(0xFF173A5E),
          onPrimary: Colors.white,
          onBackground: const Color(0xFFB2EBF2),
          accent: const Color(0xFF00BCD4),
        );
      case 'lavender':
        return _buildTheme(
          brightness: Brightness.dark,
          primary: const Color(0xFFBA68C8),
          secondary: const Color(0xFFCE93D8),
          background: const Color(0xFF1A1028),
          surface: const Color(0xFF2A1B3D),
          card: const Color(0xFF352248),
          onPrimary: Colors.white,
          onBackground: const Color(0xFFE1BEE7),
          accent: const Color(0xFFAB47BC),
        );
      case 'aurora':
        return _buildTheme(
          brightness: Brightness.dark,
          primary: const Color(0xFF69F0AE),
          secondary: const Color(0xFF40C4FF),
          background: const Color(0xFF0B1628),
          surface: const Color(0xFF122240),
          card: const Color(0xFF1A2C4E),
          onPrimary: Colors.black,
          onBackground: const Color(0xFFCAF0E0),
          accent: const Color(0xFF69F0AE),
        );
      case 'warm_coffee':
        return _buildTheme(
          brightness: Brightness.dark,
          primary: const Color(0xFFBCAAA4),
          secondary: const Color(0xFFD7CCC8),
          background: const Color(0xFF1C1410),
          surface: const Color(0xFF2C221C),
          card: const Color(0xFF3E3028),
          onPrimary: Colors.white,
          onBackground: const Color(0xFFEFEBE9),
          accent: const Color(0xFFA1887F),
        );
      case 'cherry_blossom':
        return _buildTheme(
          brightness: Brightness.dark,
          primary: const Color(0xFFF48FB1),
          secondary: const Color(0xFFF8BBD0),
          background: const Color(0xFF1C1018),
          surface: const Color(0xFF2C1B25),
          card: const Color(0xFF3A2230),
          onPrimary: Colors.white,
          onBackground: const Color(0xFFFCE4EC),
          accent: const Color(0xFFEC407A),
        );
      default:
        return _buildTheme(
          brightness: Brightness.dark,
          primary: const Color(0xFF5B8DEF),
          secondary: const Color(0xFF64FFDA),
          background: const Color(0xFF0D1B2A),
          surface: const Color(0xFF1B2838),
          card: const Color(0xFF233044),
          onPrimary: Colors.white,
          onBackground: const Color(0xFFE0E6ED),
          accent: const Color(0xFF5B8DEF),
        );
    }
  }

  // ============================================================
  // TEMA BUILDER
  // ============================================================
  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color primary,
    required Color secondary,
    required Color background,
    required Color surface,
    required Color card,
    required Color onPrimary,
    required Color onBackground,
    required Color accent,
  }) {
    return ThemeData(
      brightness: brightness,
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      cardColor: card,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: Colors.black,
        error: const Color(0xFFEF5350),
        onError: Colors.white,
        surface: surface,
        onSurface: onBackground,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        TextTheme(
          displayLarge: TextStyle(color: onBackground, fontWeight: FontWeight.w700),
          displayMedium: TextStyle(color: onBackground, fontWeight: FontWeight.w600),
          displaySmall: TextStyle(color: onBackground, fontWeight: FontWeight.w600),
          headlineLarge: TextStyle(color: onBackground, fontWeight: FontWeight.w700),
          headlineMedium: TextStyle(color: onBackground, fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(color: onBackground, fontWeight: FontWeight.w500),
          titleLarge: TextStyle(color: onBackground, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(color: onBackground, fontWeight: FontWeight.w500),
          titleSmall: TextStyle(color: onBackground, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: onBackground),
          bodyMedium: TextStyle(color: onBackground),
          bodySmall: TextStyle(color: onBackground.withOpacity(0.7)),
          labelLarge: TextStyle(color: onBackground, fontWeight: FontWeight.w600),
          labelMedium: TextStyle(color: onBackground),
          labelSmall: TextStyle(color: onBackground.withOpacity(0.6)),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: onBackground,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      iconTheme: IconThemeData(color: accent),
      dividerColor: onBackground.withOpacity(0.1),
    );
  }
}
