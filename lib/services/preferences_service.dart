import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final preferencesServiceProvider = Provider<PreferencesService>((ref) {
  throw UnimplementedError('preferencesServiceProvider must be overridden');
});

class PreferencesService {
  static const String _themeModeKey = 'theme_mode';
  static const String _languageKey = 'language_code';

  late SharedPreferences _prefs;

  /// Initialize the preferences service
  /// Must be called before using other methods
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ============ Theme Methods ============

  /// Get the saved theme mode, defaults to system
  ThemeMode getThemeMode() {
    final value = _prefs.getString(_themeModeKey);
    return _themeModeFromString(value);
  }

  /// Save theme mode to disk
  Future<void> saveThemeMode(ThemeMode mode) async {
    await _prefs.setString(_themeModeKey, mode.name);
  }

  // ============ Language Methods ============

  /// Get the saved language code, defaults to 'en'
  String getLanguageCode() {
    return _prefs.getString(_languageKey) ?? 'en';
  }

  /// Save language code to disk
  Future<void> saveLanguage(String languageCode) async {
    await _prefs.setString(_languageKey, languageCode);
  }

  /// Get the locale based on saved language code
  Locale getLocale() {
    final code = getLanguageCode();
    return Locale(code);
  }

  // ============ Helper Methods ============

  ThemeMode _themeModeFromString(String? value) {
    return switch (value) {
      'dark' => ThemeMode.dark,
      'system' => ThemeMode.system,
      _ => ThemeMode.light,
    };
  }

  /// Clear all preferences (useful for testing or reset)
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
