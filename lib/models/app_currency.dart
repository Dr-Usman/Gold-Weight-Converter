import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Display currency for gold price / zakat summaries (no FX conversion).
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

  bool matchesQuery(String query) {
    final String q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return code.toLowerCase().contains(q) ||
        name.toLowerCase().contains(q) ||
        symbol.toLowerCase().contains(q);
  }

  static const AppCurrency inr = AppCurrency(
    code: 'INR',
    name: 'Indian Rupee',
    symbol: '₹',
    locale: 'en_IN',
  );

  static const List<AppCurrency> all = [
    inr,
    AppCurrency(
      code: 'PKR',
      name: 'Pakistani Rupee',
      symbol: 'Rs. ',
      locale: 'en_PK',
    ),
    AppCurrency(
      code: 'BDT',
      name: 'Bangladeshi Taka',
      symbol: '৳',
      locale: 'en_BD',
    ),
    AppCurrency(
      code: 'AED',
      name: 'UAE Dirham',
      symbol: 'AED ',
      locale: 'en_AE',
    ),
    AppCurrency(
      code: 'SAR',
      name: 'Saudi Riyal',
      symbol: 'SAR ',
      locale: 'en_SA',
    ),
    AppCurrency(code: 'USD', name: 'US Dollar', symbol: '\$', locale: 'en_US'),
    AppCurrency(code: 'EUR', name: 'Euro', symbol: '€', locale: 'en'),
    AppCurrency(
      code: 'GBP',
      name: 'British Pound',
      symbol: '£',
      locale: 'en_GB',
    ),
    AppCurrency(
      code: 'TRY',
      name: 'Turkish Lira',
      symbol: '₺',
      locale: 'tr_TR',
    ),
    AppCurrency(
      code: 'MYR',
      name: 'Malaysian Ringgit',
      symbol: 'RM ',
      locale: 'en_MY',
    ),
    AppCurrency(
      code: 'IDR',
      name: 'Indonesian Rupiah',
      symbol: 'Rp ',
      locale: 'id_ID',
    ),
    AppCurrency(
      code: 'IRR',
      name: 'Iranian Rial',
      symbol: '﷼',
      locale: 'fa_IR',
    ),
    AppCurrency(
      code: 'AFN',
      name: 'Afghan Afghani',
      symbol: '؋',
      locale: 'en_AF',
    ),
    AppCurrency(
      code: 'QAR',
      name: 'Qatari Riyal',
      symbol: 'QAR ',
      locale: 'en_QA',
    ),
    AppCurrency(
      code: 'KWD',
      name: 'Kuwaiti Dinar',
      symbol: 'KD ',
      locale: 'en_KW',
    ),
    AppCurrency(
      code: 'OMR',
      name: 'Omani Rial',
      symbol: 'OMR ',
      locale: 'en_OM',
    ),
    AppCurrency(
      code: 'BHD',
      name: 'Bahraini Dinar',
      symbol: 'BD ',
      locale: 'en_BH',
    ),
    AppCurrency(
      code: 'EGP',
      name: 'Egyptian Pound',
      symbol: 'E£',
      locale: 'en_EG',
    ),
    AppCurrency(
      code: 'LKR',
      name: 'Sri Lankan Rupee',
      symbol: 'Rs. ',
      locale: 'en_LK',
    ),
    AppCurrency(
      code: 'NPR',
      name: 'Nepalese Rupee',
      symbol: 'Rs. ',
      locale: 'en_NP',
    ),
    AppCurrency(
      code: 'CAD',
      name: 'Canadian Dollar',
      symbol: 'CA\$',
      locale: 'en_CA',
    ),
    AppCurrency(
      code: 'AUD',
      name: 'Australian Dollar',
      symbol: 'A\$',
      locale: 'en_AU',
    ),
    AppCurrency(
      code: 'SGD',
      name: 'Singapore Dollar',
      symbol: 'S\$',
      locale: 'en_SG',
    ),
    AppCurrency(
      code: 'HKD',
      name: 'Hong Kong Dollar',
      symbol: 'HK\$',
      locale: 'en_HK',
    ),
    AppCurrency(
      code: 'JPY',
      name: 'Japanese Yen',
      symbol: '¥',
      locale: 'ja_JP',
    ),
    AppCurrency(
      code: 'CNY',
      name: 'Chinese Yuan',
      symbol: '¥',
      locale: 'zh_CN',
    ),
    AppCurrency(
      code: 'CHF',
      name: 'Swiss Franc',
      symbol: 'CHF ',
      locale: 'en_CH',
    ),
    AppCurrency(
      code: 'ZAR',
      name: 'South African Rand',
      symbol: 'R ',
      locale: 'en_ZA',
    ),
    AppCurrency(
      code: 'NGN',
      name: 'Nigerian Naira',
      symbol: '₦',
      locale: 'en_NG',
    ),
    AppCurrency(
      code: 'KES',
      name: 'Kenyan Shilling',
      symbol: 'KSh ',
      locale: 'en_KE',
    ),
  ];

  static final Map<String, AppCurrency> _byCode = {
    for (final AppCurrency currency in all) currency.code: currency,
  };

  static AppCurrency? tryParse(String? code) {
    if (code == null || code.isEmpty) return null;
    return _byCode[code.toUpperCase()];
  }

  static AppCurrency fromCode(String? code) {
    return tryParse(code) ?? inr;
  }

  /// First-launch default from device locale; ultimate fallback is INR.
  static AppCurrency resolveDefault(Locale deviceLocale) {
    final String? country = deviceLocale.countryCode?.toUpperCase();
    if (country != null && country.isNotEmpty) {
      final AppCurrency? byCountry = _fromCountryCode(country);
      if (byCountry != null) return byCountry;
    }

    final String language = deviceLocale.languageCode.toLowerCase();
    final AppCurrency? byLanguage = _fromLanguageCode(language);
    if (byLanguage != null) return byLanguage;

    return inr;
  }

  static AppCurrency? _fromCountryCode(String country) {
    return switch (country) {
      'IN' => inr,
      'PK' => _byCode['PKR'],
      'BD' => _byCode['BDT'],
      'AE' => _byCode['AED'],
      'SA' => _byCode['SAR'],
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
      'hi' => inr,
      'bn' => _byCode['BDT'],
      'ur' => _byCode['PKR'],
      'sd' => _byCode['PKR'],
      'ps' => _byCode['AFN'],
      'fa' => _byCode['IRR'],
      // Skip 'ar' — many Arabic locales (EG/AE/MA/…) need country, not SAR.
      'tr' => _byCode['TRY'],
      'ms' => _byCode['MYR'],
      'id' => _byCode['IDR'],
      _ => null,
    };
  }
}
