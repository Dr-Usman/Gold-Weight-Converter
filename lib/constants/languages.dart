import 'package:flutter/material.dart';

/// One selectable app language (native label shown in UI).
class AppLanguageOption {
  const AppLanguageOption({required this.locale, required this.nativeLabel});

  final Locale locale;
  final String nativeLabel;

  bool matches(Locale other) =>
      locale.languageCode == other.languageCode &&
      locale.countryCode == other.countryCode;
}

/// Edit [supported] to add/remove app languages.
class Languages {
  Languages._();

  /// Audience-first: India / South Asia, then MENA, then SE Asia / other.
  static const List<AppLanguageOption> supported = [
    AppLanguageOption(locale: Locale('en'), nativeLabel: 'English'),
    AppLanguageOption(locale: Locale('hi'), nativeLabel: 'हिंदी'),
    AppLanguageOption(locale: Locale('bn'), nativeLabel: 'বাংলা'),
    AppLanguageOption(locale: Locale('ur'), nativeLabel: 'اردو'),
    AppLanguageOption(locale: Locale('ur', 'RO'), nativeLabel: 'Roman Urdu'),
    AppLanguageOption(locale: Locale('sd'), nativeLabel: 'سنڌي'),
    AppLanguageOption(locale: Locale('ar'), nativeLabel: 'العربية'),
    AppLanguageOption(locale: Locale('fa'), nativeLabel: 'فارسی'),
    AppLanguageOption(locale: Locale('ps'), nativeLabel: 'پښتو'),
    AppLanguageOption(locale: Locale('ms'), nativeLabel: 'Melayu'),
    AppLanguageOption(locale: Locale('id'), nativeLabel: 'Indonesia'),
    AppLanguageOption(locale: Locale('tr'), nativeLabel: 'Türkçe'),
  ];

  static String nativeLabelFor(Locale locale) {
    for (final AppLanguageOption option in supported) {
      if (option.matches(locale)) return option.nativeLabel;
    }
    final String? country = locale.countryCode;
    if (country != null && country.isNotEmpty) {
      return '${locale.languageCode}_$country';
    }
    return locale.languageCode;
  }
}
