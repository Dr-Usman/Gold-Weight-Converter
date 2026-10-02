import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/currencies.dart';

/// Display currency for gold price / zakat summaries (no FX conversion).
///
/// Supported currencies live in [Currencies.supportedCurrencies]
/// (`lib/constants/currencies.dart`).
class AppCurrency {
  const AppCurrency({
    required this.code,
    required this.name,
    required this.symbol,
    required this.locale,
  });

  final String code;
  final String name;
  final String symbol;
  final String locale;

  String get displayLabel => '$code · $symbol'.trim();

  NumberFormat get numberFormat =>
      NumberFormat.currency(locale: locale, symbol: symbol, decimalDigits: 2);

  NumberFormat numberFormatWithDigits(int decimalDigits) =>
      NumberFormat.currency(
        locale: locale,
        symbol: symbol,
        decimalDigits: decimalDigits,
      );

  bool matchesQuery(String query) {
    final String q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return code.toLowerCase().contains(q) ||
        name.toLowerCase().contains(q) ||
        symbol.toLowerCase().contains(q);
  }

  /// Same catalog as [Currencies.supportedCurrencies] — edit that list to add currencies.
  static const List<AppCurrency> all = Currencies.supportedCurrencies;

  /// Fast lookup: ISO currency code → [AppCurrency] (e.g. `'PKR'` → Pakistani Rupee).
  /// Indexing with `[]` returns one [AppCurrency?], not the whole map.
  static final Map<String, AppCurrency> _byCode = {
    for (final AppCurrency currency in all) currency.code: currency,
  };

  static AppCurrency? tryParse(String? code) {
    if (code == null || code.isEmpty) return null;
    return _byCode[code.toUpperCase()];
  }

  static AppCurrency fromCode(String? code) {
    return tryParse(code) ?? Currencies.inr;
  }

  /// First-launch default from device locale and timezone; ultimate fallback is INR.
  static AppCurrency resolveDefault(
    Locale deviceLocale, {
    Duration? timeZoneOffset,
  }) {
    final Duration offset = timeZoneOffset ?? DateTime.now().timeZoneOffset;
    final String? country = deviceLocale.countryCode?.toUpperCase();

    // If country is explicitly set and not a generic English locale (GB / US)
    // where users frequently select it outside those countries:
    if (country != null &&
        country.isNotEmpty &&
        country != 'GB' &&
        country != 'US') {
      final AppCurrency? byCountry = _fromCountryCode(country);
      if (byCountry != null) return byCountry;
    }

    // Disambiguate generic locales (GB, US, or unset country) using the device timezone.
    final AppCurrency? byTimezone = _fromTimezoneOffset(offset);
    if (byTimezone != null) return byTimezone;

    // Fall back to GB or US country code if timezone did not match a specific region
    if (country != null && country.isNotEmpty) {
      final AppCurrency? byCountry = _fromCountryCode(country);
      if (byCountry != null) return byCountry;
    }

    final String language = deviceLocale.languageCode.toLowerCase();
    final AppCurrency? byLanguage = _fromLanguageCode(language);
    if (byLanguage != null) return byLanguage;

    return Currencies.inr;
  }

  /// Maps a timezone offset to an [AppCurrency] when the country code is
  /// ambiguous (e.g. 'GB', 'US', or absent).
  static AppCurrency? _fromTimezoneOffset(Duration offset) {
    return switch (offset.inMinutes) {
      180 =>
        _byCode['SAR'], // UTC+3:00 (Saudi Arabia / Qatar / Kuwait / Bahrain)
      240 => _byCode['AED'], // UTC+4:00 (UAE / Oman)
      300 => _byCode['PKR'], // UTC+5:00 (Pakistan Standard Time - PKT)
      330 => Currencies.inr, // UTC+5:30 (India Standard Time - IST / Sri Lanka)
      345 => _byCode['NPR'], // UTC+5:45 (Nepal Time - NPT)
      360 => _byCode['BDT'], // UTC+6:00 (Bangladesh Standard Time - BST)
      _ => null,
    };
  }

  /// Maps a device *country* code (ISO 3166, e.g. `'PK'`) to a display currency.
  /// Uses [_byCode] so country `'PK'` resolves to currency `'PKR'`, etc.
  static AppCurrency? _fromCountryCode(String country) {
    return switch (country) {
      'IN' => Currencies.inr,
      'PK' => _byCode['PKR'],
      'BD' => _byCode['BDT'],
      'AE' => _byCode['AED'],
      'SA' => _byCode['SAR'],
      'AR' => _byCode['ARS'],
      'CO' => _byCode['COP'],
      'VE' => _byCode['VES'],
      'US' => _byCode['USD'],
      'GB' => _byCode['GBP'],
      'TR' => _byCode['TRY'],
      'MY' => _byCode['MYR'],
      'ID' => _byCode['IDR'],
      'IR' => _byCode['IRR'],
      'AF' => _byCode['AFN'],
      'QA' => _byCode['QAR'],
      'KW' => _byCode['KWD'],
      'OM' => _byCode['OMR'],
      'BH' => _byCode['BHD'],
      'EG' => _byCode['EGP'],
      'LK' => _byCode['LKR'],
      'NP' => _byCode['NPR'],
      'CA' => _byCode['CAD'],
      'AU' => _byCode['AUD'],
      'SG' => _byCode['SGD'],
      'HK' => _byCode['HKD'],
      'JP' => _byCode['JPY'],
      'CN' => _byCode['CNY'],
      'CH' => _byCode['CHF'],
      'ZA' => _byCode['ZAR'],
      'NG' => _byCode['NGN'],
      'KE' => _byCode['KES'],
      'ET' => _byCode['ETB'],
      'TH' => _byCode['THB'],
      'SL' => _byCode['SLE'],
      'PH' => _byCode['PHP'],
      'GH' => _byCode['GHS'],
      'MM' => _byCode['MMK'],
      'DE' ||
      'FR' ||
      'IT' ||
      'ES' ||
      'NL' ||
      'BE' ||
      'AT' ||
      'IE' ||
      'PT' ||
      'FI' ||
      'GR' ||
      'SK' ||
      'SI' ||
      'EE' ||
      'LV' ||
      'LT' ||
      'LU' ||
      'MT' ||
      'CY' => _byCode['EUR'],
      _ => null,
    };
  }

  static AppCurrency? _fromLanguageCode(String language) {
    return switch (language) {
      'hi' => Currencies.inr,
      'ne' => _byCode['NPR'],
      'bn' => _byCode['BDT'],
      'ur' => _byCode['PKR'],
      'sd' => _byCode['PKR'],
      'ps' => _byCode['AFN'],
      'fa' => _byCode['IRR'],
      // Skip 'ar' — many Arabic locales (EG/AE/MA/…) need country, not SAR.
      'tr' => _byCode['TRY'],
      'ms' => _byCode['MYR'],
      'id' => _byCode['IDR'],
      'th' => _byCode['THB'],
      'am' => _byCode['ETB'],
      'fil' || 'tl' => _byCode['PHP'],
      'si' => _byCode['LKR'],
      'ta' => Currencies.inr,
      'my' => _byCode['MMK'],
      _ => null,
    };
  }
}
