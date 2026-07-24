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

  static Future<void> init() async {
    if (_mixpanel != null) return;

    _mixpanel = await Mixpanel.init(projectToken, trackAutomaticEvents: true);

    trackAppOpened();
  }

  /// Sync saved preferences onto the Mixpanel People profile (no event).
  static void syncUserPreferences({
    required Locale locale,
    required ThemeMode themeMode,
    required String preferredCurrency,
  }) {
    final people = _mixpanel?.getPeople();
    if (people == null) return;

    people.set('preferred_language', localeToAnalyticsCode(locale));
    people.set('theme_mode', themeModeToAnalyticsValue(themeMode));
    people.set('preferred_currency', preferredCurrency);
  }

  static void trackAppOpened() {
    _mixpanel?.track('app_opened');
  }

  static void trackConversionCompleted({
    required List<String> inputUnitsUsed,
    required String rateUnit,
    required bool hasGoldRate,
  }) {
    _mixpanel?.track(
      'conversion_completed',
      properties: {
        'input_units_used': inputUnitsUsed,
        'rate_unit': rateUnit,
        'is_gold_rate_set': hasGoldRate,
      },
    );
  }

  static void trackZakatCalculated({
    required int itemCount,
    required String rateUnit,
    required bool hasGoldRate,
  }) {
    _mixpanel?.track(
      'zakat_calculated',
      properties: {
        'item_count': itemCount,
        'rate_unit': rateUnit,
        'is_gold_rate_set': hasGoldRate,
      },
    );
  }

  static void trackLanguageChanged({
    required Locale language,
    Locale? previousLanguage,
  }) {
    final String languageCode = localeToAnalyticsCode(language);
    _mixpanel?.track(
      'language_changed',
      properties: {
        'language': languageCode,
        if (previousLanguage != null)
          'previous_language': localeToAnalyticsCode(previousLanguage),
      },
    );
    _mixpanel?.getPeople().set('preferred_language', languageCode);
  }

  static void trackThemeChanged({
    required ThemeMode themeMode,
    ThemeMode? previousThemeMode,
  }) {
    final String themeValue = themeModeToAnalyticsValue(themeMode);
    _mixpanel?.track(
      'theme_changed',
      properties: {
        'theme_mode': themeValue,
        if (previousThemeMode != null)
          'previous_theme_mode': themeModeToAnalyticsValue(previousThemeMode),
      },
    );
    _mixpanel?.getPeople().set('theme_mode', themeValue);
  }

  static void trackCurrencyChanged({
    required String currency,
    String? previousCurrency,
  }) {
    _mixpanel?.track(
      'currency_changed',
      properties: {
        'currency': currency,
        'previous_currency': ?previousCurrency,
      },
    );
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
}
