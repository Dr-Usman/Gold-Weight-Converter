import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/unit_enum.dart';
import '../models/conversion_history_item.dart';
import '../models/gold_item_model.dart';

final preferencesServiceProvider = Provider<PreferencesService>((ref) {
  throw UnimplementedError('preferencesServiceProvider must be overridden');
});

/// Manages reactive state for the 24-hour ad-free pass earned via rewarded ad.
final adFreePassProvider = NotifierProvider<AdFreePassNotifier, DateTime?>(
  AdFreePassNotifier.new,
);

class AdFreePassNotifier extends Notifier<DateTime?> {
  @override
  DateTime? build() {
    final prefs = ref.watch(preferencesServiceProvider);
    final until = prefs.getAdFreeUntil();
    if (until != null && DateTime.now().isBefore(until)) {
      return until;
    }
    return null;
  }

  bool get isActive {
    final until = state;
    return until != null && DateTime.now().isBefore(until);
  }

  Future<void> grant24HourPass() async {
    final until = DateTime.now().add(const Duration(hours: 24));
    final prefs = ref.read(preferencesServiceProvider);
    await prefs.saveAdFreeUntil(until);
    state = until;
  }
}

class PreferencesService {
  static const String _themeModeKey = 'theme_mode';
  static const String _languageKey = 'language_code';
  static const String _currencyKey = 'currency_code';
  static const String _zakatItemsKey = 'zakat_gold_items';
  static const String _zakatRateKey = 'zakat_gold_rate';
  static const String _zakatRateUnitKey = 'zakat_rate_unit';
  static const String _converterRateKey = 'converter_gold_rate';
  static const String _converterRateUnitKey = 'converter_rate_unit';
  static const String _conversionHistoryKey = 'conversion_history';
  static const String _adFreeUntilKey = 'ad_free_until';

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

  /// Save locale to disk
  Future<void> saveLocale(Locale locale) async {
    final String localeString = locale.toString();
    await _prefs.setString(_languageKey, localeString);
  }

  /// Get the saved locale, defaults to 'en'
  Locale getLocale() {
    final code = _prefs.getString(_languageKey) ?? 'en';
    return _localeFromString(code);
  }

  // ============ Currency Methods ============

  /// Saved ISO currency code, or `null` when the user has never chosen one.
  String? getCurrencyCode() {
    return _prefs.getString(_currencyKey);
  }

  Future<void> saveCurrencyCode(String code) async {
    await _prefs.setString(_currencyKey, code);
  }

  /// Helper: Parse string to Locale
  Locale _localeFromString(String code) {
    final parts = code.split('_');
    if (parts.length == 1) {
      return Locale(parts[0]);
    } else if (parts.length == 2) {
      return Locale(parts[0], parts[1]);
    } else if (parts.length == 3) {
      return Locale.fromSubtags(
        languageCode: parts[0],
        countryCode: parts[1],
        scriptCode: parts[2],
      );
    } else {
      return Locale('en'); // Fallback
    }
  }
  // ============ Zakat Methods ============

  /// Saved gold items for zakat, or empty list when unset/corrupt.
  List<GoldItemModel> getZakatItems() {
    final String? raw = _prefs.getString(_zakatItemsKey);
    if (raw == null || raw.isEmpty) return const [];

    try {
      final dynamic decoded = jsonDecode(raw);
      if (decoded is! List) return const [];
      return decoded
          .whereType<Map>()
          .map(
            (item) => GoldItemModel.fromJson(Map<String, dynamic>.from(item)),
          )
          .where((item) => item.id.isNotEmpty)
          .toList();
    } catch (_) {
      return const [];
    }
  }

  Future<void> saveZakatItems(List<GoldItemModel> items) async {
    final List<Map<String, dynamic>> encoded = items
        .map((item) => item.toJson())
        .toList();
    await _prefs.setString(_zakatItemsKey, jsonEncode(encoded));
  }

  /// Last entered zakat gold rate text, or empty when unset.
  String getZakatRateText() {
    return _prefs.getString(_zakatRateKey) ?? '';
  }

  Future<void> saveZakatRateText(String rateText) async {
    await _prefs.setString(_zakatRateKey, rateText);
  }

  UnitEnum getZakatRateUnit() {
    return UnitEnum.fromString(_prefs.getString(_zakatRateUnitKey));
  }

  Future<void> saveZakatRateUnit(UnitEnum unit) async {
    await _prefs.setString(_zakatRateUnitKey, unit.name);
  }

  // ============ Converter Methods ============

  String getConverterRateText() {
    return _prefs.getString(_converterRateKey) ?? '';
  }

  Future<void> saveConverterRateText(String rateText) async {
    await _prefs.setString(_converterRateKey, rateText);
  }

  UnitEnum getConverterRateUnit() {
    return UnitEnum.fromString(_prefs.getString(_converterRateUnitKey));
  }

  Future<void> saveConverterRateUnit(UnitEnum unit) async {
    await _prefs.setString(_converterRateUnitKey, unit.name);
  }

  // ============ History Methods ============

  List<ConversionHistoryItem> getConversionHistory() {
    final String? raw = _prefs.getString(_conversionHistoryKey);
    if (raw == null || raw.isEmpty) return const [];

    try {
      final dynamic decoded = jsonDecode(raw);
      if (decoded is! List) return const [];
      return decoded
          .whereType<Map>()
          .map(
            (item) =>
                ConversionHistoryItem.fromJson(Map<String, dynamic>.from(item)),
          )
          .where((item) => item.id.isNotEmpty)
          .toList();
    } catch (_) {
      return const [];
    }
  }

  Future<void> saveConversionHistory(List<ConversionHistoryItem> items) async {
    final List<Map<String, dynamic>> encoded = items
        .map((item) => item.toJson())
        .toList();
    await _prefs.setString(_conversionHistoryKey, jsonEncode(encoded));
  }

  // ============ Ad-Free Pass Methods ============

  /// Returns expiration date of active ad-free pass, or null if none.
  DateTime? getAdFreeUntil() {
    try {
      final String? raw = _prefs.getString(_adFreeUntilKey);
      if (raw == null || raw.isEmpty) return null;
      return DateTime.tryParse(raw);
    } catch (_) {
      return null;
    }
  }

  /// Saves or clears expiration date of ad-free pass.
  Future<void> saveAdFreeUntil(DateTime? until) async {
    try {
      if (until == null) {
        await _prefs.remove(_adFreeUntilKey);
      } else {
        await _prefs.setString(_adFreeUntilKey, until.toIso8601String());
      }
    } catch (_) {}
  }

  /// Whether user currently holds an active ad-free pass.
  bool isAdFreeActive() {
    final until = getAdFreeUntil();
    if (until == null) return false;
    return DateTime.now().isBefore(until);
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
