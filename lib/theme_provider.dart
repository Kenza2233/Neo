import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'kpop_theme_type.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  KpopThemeType? _kpopTheme;

  ThemeMode get themeMode => _themeMode;
  KpopThemeType? get kpopTheme => _kpopTheme;

  ThemeData get currentTheme {
    if (_kpopTheme != null) {
      return MyThemes.getKpopTheme(_kpopTheme!);
    }
    return _themeMode == ThemeMode.dark ? MyThemes.darkTheme : MyThemes.lightTheme;
  }

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    final kpopThemeIndex = prefs.getInt('kpopTheme');
    if (kpopThemeIndex != null) {
      _kpopTheme = KpopThemeType.values[kpopThemeIndex];
    }
    notifyListeners();
  }

  void toggleTheme(bool isDarkMode) async {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    _kpopTheme = null; // Reset kpop theme when toggling standard theme
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
    await prefs.remove('kpopTheme');
    notifyListeners();
  }

  void setKpopTheme(KpopThemeType theme) async {
    _kpopTheme = theme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('kpopTheme', theme.index);
    notifyListeners();
  }
}

class MyThemes {
  static final Color _primaryColor = const Color(0xFF007AFF); // Biru Elektrik
  static final Color _darkScaffold = const Color(0xFF121212);
  static final Color _darkCard = const Color(0xFF1E1E1E);

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _darkScaffold,
    primaryColor: _primaryColor,
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    appBarTheme: AppBarTheme(
      backgroundColor: _darkScaffold,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
    ),
    cardTheme: CardTheme(
      color: _darkCard,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _primaryColor,
    ),
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    primaryColor: _primaryColor,
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFFF5F5F5),
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
      iconTheme: const IconThemeData(color: Colors.black),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _primaryColor,
    ),
  );

  static ThemeData getKpopTheme(KpopThemeType themeType) {
    switch (themeType) {
      case KpopThemeType.blackpink:
        return _createTheme(const Color(0xFFF7A6B4), const Color(0xFF000000));
      case KpopThemeType.bts:
        return _createTheme(const Color(0xFFB39DDB), const Color(0xFFF3F3F3));
      case KpopThemeType.twice:
        return _createTheme(const Color(0xFFFFD166), const Color(0xFFEF476F));
      case KpopThemeType.newjeans:
        return _createTheme(const Color(0xFFADD8E6), const Color(0xFFFFFFFF));
      // ... Add other 8 themes here with their respective color palettes
      default:
        return lightTheme;
    }
  }

  static ThemeData _createTheme(Color primary, Color accent) {
    return lightTheme.copyWith(
      primaryColor: primary,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accent,
      ),
      appBarTheme: lightTheme.appBarTheme.copyWith(
        backgroundColor: primary,
        titleTextStyle: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: accent),
      ),
    );
  }
}
