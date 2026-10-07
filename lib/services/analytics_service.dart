import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

/// Central Mixpanel analytics wrapper. Initialize once at app startup via [init].
class AnalyticsService {
  AnalyticsService._();

  /// Override with `--dart-define=MIXPANEL_TOKEN=...` for non-default projects.
  static const String projectToken = String.fromEnvironment(
    'MIXPANEL_TOKEN',
    defaultValue: '69f057903a79346a0ca9365e92a23960',
  );

  static Mixpanel? _mixpanel;

  static Mixpanel? get instance => _mixpanel;

  static Future<void> init({
    Locale? initialLocale,
    ThemeMode? initialThemeMode,
    String? initialPreferredCurrency,
    Locale? deviceLocale,
    Duration? timeZoneOffset,
  }) async {
    if (_mixpanel != null) return;

    final Locale resolvedDeviceLocale =
        deviceLocale ?? PlatformDispatcher.instance.locale;
    final Duration resolvedOffset =
        timeZoneOffset ?? DateTime.now().timeZoneOffset;

    final initialSuperProperties = <String, dynamic>{
      'device_locale': formatDeviceLocale(resolvedDeviceLocale),
      'device_timezone_offset': formatTimeZoneOffset(resolvedOffset),
      if (initialLocale != null)
        'preferred_language': localeToAnalyticsCode(initialLocale),
      if (initialThemeMode != null)
        'theme_mode': themeModeToAnalyticsValue(initialThemeMode),
      if (initialPreferredCurrency != null &&
          initialPreferredCurrency.isNotEmpty)
        'preferred_currency': initialPreferredCurrency,
    };

    _mixpanel = await Mixpanel.init(
      projectToken,
      trackAutomaticEvents: true,
      superProperties: initialSuperProperties.isNotEmpty
          ? initialSuperProperties
          : null,
    );

    if (initialSuperProperties.isNotEmpty) {
      final people = _mixpanel?.getPeople();
      if (people != null) {
        for (final entry in initialSuperProperties.entries) {
          people.set(entry.key, entry.value);
        }
      }
    }

    trackAppOpened();
  }

  /// Sync saved preferences as Super Properties (attached to every event)
  /// and onto the Mixpanel People profile.
  static void syncUserPreferences({
    Locale? locale,
    ThemeMode? themeMode,
    String? preferredCurrency,
  }) {
    final properties = <String, dynamic>{
      if (locale != null) 'preferred_language': localeToAnalyticsCode(locale),
      if (themeMode != null) 'theme_mode': themeModeToAnalyticsValue(themeMode),
      if (preferredCurrency != null && preferredCurrency.isNotEmpty)
        'preferred_currency': preferredCurrency,
    };

    if (properties.isEmpty) return;

    _mixpanel?.registerSuperProperties(properties);

    final people = _mixpanel?.getPeople();
    if (people == null) return;

    for (final entry in properties.entries) {
      people.set(entry.key, entry.value);
    }
  }

  static void flush() {
    _mixpanel?.flush();
  }

  static void _track(
    String eventName, [
    Map<String, dynamic>? properties,
    bool forceFlush = false,
  ]) {
    assert(() {
      debugPrint('📊 [Mixpanel] Track: $eventName ${properties ?? ""}');
      return true;
    }());
    _mixpanel?.track(eventName, properties: properties);
    if (kDebugMode || forceFlush) {
      _mixpanel?.flush();
    }
  }

  static void trackAppOpened() {
    _track('app_opened');
  }

  static void trackConversionCompleted({
    required List<String> inputUnitsUsed,
    required String rateUnit,
    required bool hasGoldRate,
    required double totalGrams,
    required double totalTola,
  }) {
    _track('conversion_completed', {
      'input_units_used': inputUnitsUsed,
      'rate_unit': rateUnit,
      'is_gold_rate_set': hasGoldRate,
      'total_grams': totalGrams,
      'total_tola': totalTola,
    }, true);
  }

  static void trackZakatCalculated({
    required int itemCount,
    required String rateUnit,
    required bool hasGoldRate,
    required double totalGrams,
    required double totalPureGrams,
    required List<String> puritiesUsed,
    required List<String> weightUnitsUsed,
    required bool hasCustomKarat,
  }) {
    _track('zakat_calculated', {
      'item_count': itemCount,
      'rate_unit': rateUnit,
      'is_gold_rate_set': hasGoldRate,
      'total_grams': totalGrams,
      'total_pure_grams': totalPureGrams,
      'purities_used': puritiesUsed,
      'weight_units_used': weightUnitsUsed,
      'has_custom_karat': hasCustomKarat,
    }, true);
  }

  static void trackLanguageChanged({
    required Locale language,
    Locale? previousLanguage,
  }) {
    final String languageCode = localeToAnalyticsCode(language);
    _mixpanel?.registerSuperProperties({'preferred_language': languageCode});
    _track('language_changed', {
      'language': languageCode,
      if (previousLanguage != null)
        'previous_language': localeToAnalyticsCode(previousLanguage),
    });
    _mixpanel?.getPeople().set('preferred_language', languageCode);
  }

  static void trackThemeChanged({
    required ThemeMode themeMode,
    ThemeMode? previousThemeMode,
  }) {
    final String themeValue = themeModeToAnalyticsValue(themeMode);
    _mixpanel?.registerSuperProperties({'theme_mode': themeValue});
    _track('theme_changed', {
      'theme_mode': themeValue,
      if (previousThemeMode != null)
        'previous_theme_mode': themeModeToAnalyticsValue(previousThemeMode),
    });
    _mixpanel?.getPeople().set('theme_mode', themeValue);
  }

  static void trackResultsCopied({
    required String screen,
    double? totalGrams,
    double? totalTola,
    String? totalPrice,
  }) {
    _track('results_copied', {
      'screen': screen,
      'total_grams': ?totalGrams,
      'total_tola': ?totalTola,
      if (totalPrice != null && totalPrice.isNotEmpty)
        'total_price': totalPrice,
    });
  }

  static void trackResultsShared({
    required String screen,
    double? totalGrams,
    double? totalTola,
    String? totalPrice,
  }) {
    _track('results_shared', {
      'screen': screen,
      'total_grams': ?totalGrams,
      'total_tola': ?totalTola,
      if (totalPrice != null && totalPrice.isNotEmpty)
        'total_price': totalPrice,
    });
  }

  static void trackAppUpdatePrompted() {
    _track('app_update_prompted');
  }

  static void trackAppUpdateCompleted() {
    _track('app_update_completed');
  }

  static void trackDrawerItemClicked(String itemName) {
    _track('drawer_item_clicked', {'item_name': itemName});
  }

  static void trackHistoryItemRestored({
    required double totalGrams,
    required double totalTola,
    required bool hasGoldRate,
  }) {
    _track('history_item_restored', {
      'total_grams': totalGrams,
      'total_tola': totalTola,
      'is_gold_rate_set': hasGoldRate,
    });
  }

  static void trackHistoryItemDeleted({
    required double totalGrams,
    required double totalTola,
    required bool hasGoldRate,
    String? totalPrice,
  }) {
    _track('history_item_deleted', {
      'total_grams': totalGrams,
      'total_tola': totalTola,
      'is_gold_rate_set': hasGoldRate,
      if (totalPrice != null && totalPrice.isNotEmpty)
        'total_price': totalPrice,
    });
  }

  static void trackHistoryCleared(int countCleared) {
    _track('history_cleared', {'count_cleared': countCleared});
  }

  static void trackCurrencyChanged({
    required String currency,
    String? previousCurrency,
  }) {
    _mixpanel?.registerSuperProperties({'preferred_currency': currency});
    _track('currency_changed', {
      'currency': currency,
      'previous_currency': ?previousCurrency,
    });
    _mixpanel?.getPeople().set('preferred_currency', currency);
  }

  /// Snake_case locale key, e.g. `en`, `ur`, `ur_ro`.
  static String localeToAnalyticsCode(Locale locale) {
    final String language = locale.languageCode.toLowerCase();
    final String? country = locale.countryCode?.toLowerCase();
    if (country == null || country.isEmpty) return language;
    return '${language}_$country';
  }

  static String themeModeToAnalyticsValue(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.dark => 'dark',
      ThemeMode.light => 'light',
      ThemeMode.system => 'system',
    };
  }

  /// Formats a device locale into an analytics string (e.g. `en_US`, `fr_FR`, `en`).
  static String formatDeviceLocale(Locale locale) {
    return locale.toString();
  }

  /// Formats a timezone offset into an ISO-like offset string (e.g. `+02:00`, `-05:00`, `+05:30`).
  static String formatTimeZoneOffset(Duration offset) {
    final String sign = offset.isNegative ? '-' : '+';
    final int totalMinutes = offset.inMinutes.abs();
    final int hours = totalMinutes ~/ 60;
    final int minutes = totalMinutes % 60;
    return '$sign${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }
}
