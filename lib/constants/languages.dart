import 'package:flutter/material.dart';

/// One selectable app language (native label shown in UI).
class AppLanguage {
  const AppLanguage({
    required this.locale,
    required this.nativeLabel,
    required this.englishName,
  });

  final Locale locale;
  final String nativeLabel;
  final String englishName;

  /// Short uppercase badge for the leading avatar (e.g. 'EN', 'HI', 'UR').
  String get badge {
    if (locale.countryCode != null && locale.countryCode!.isNotEmpty) {
      return locale.countryCode!.toUpperCase();
    }
    return locale.languageCode.toUpperCase();
  }

  bool matches(Locale other) =>
      locale.languageCode == other.languageCode &&
      locale.countryCode == other.countryCode;

  bool matchesQuery(String query) {
    final String q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return nativeLabel.toLowerCase().contains(q) ||
        englishName.toLowerCase().contains(q) ||
        badge.toLowerCase().contains(q) ||
        locale.languageCode.toLowerCase().contains(q);
  }
}

/// Edit [supported] to add/remove app languages.
class Languages {
  Languages._();

  /// Audience-first: India / South Asia, then Africa/East Asia, then MENA/SE Asia.
  static const List<AppLanguage> supported = [
    AppLanguage(
      locale: Locale('en'),
      nativeLabel: 'English',
      englishName: 'English',
    ),
    AppLanguage(
      locale: Locale('hi'),
      nativeLabel: 'हिंदी',
      englishName: 'Hindi',
    ),
    AppLanguage(locale: Locale('ur'), nativeLabel: 'اردو', englishName: 'Urdu'),
    AppLanguage(
      locale: Locale('bn'),
      nativeLabel: 'বাংলা',
      englishName: 'Bengali',
    ),
    AppLanguage(
      locale: Locale('ne'),
      nativeLabel: 'नेपाली',
      englishName: 'Nepali',
    ),
    AppLanguage(
      locale: Locale('am'),
      nativeLabel: 'አማርኛ',
      englishName: 'Amharic',
    ),
    AppLanguage(
      locale: Locale('my'),
      nativeLabel: 'မြန်မာစာ',
      englishName: 'Burmese',
    ),
    AppLanguage(
      locale: Locale('fil'),
      nativeLabel: 'Filipino',
      englishName: 'Filipino',
    ),
    AppLanguage(
      locale: Locale('si'),
      nativeLabel: 'සිංහල',
      englishName: 'Sinhala',
    ),
    AppLanguage(
      locale: Locale('ta'),
      nativeLabel: 'தமிழ்',
      englishName: 'Tamil',
    ),
    AppLanguage(
      locale: Locale('ur', 'RO'),
      nativeLabel: 'Roman Urdu',
      englishName: 'Roman Urdu',
    ),
    AppLanguage(
      locale: Locale('ar'),
      nativeLabel: 'العربية',
      englishName: 'Arabic',
    ),
    AppLanguage(
      locale: Locale('sd'),
      nativeLabel: 'سنڌي',
      englishName: 'Sindhi',
    ),
    AppLanguage(
      locale: Locale('ms'),
      nativeLabel: 'Melayu',
      englishName: 'Malay',
    ),
    AppLanguage(
      locale: Locale('ps'),
      nativeLabel: 'پښتو',
      englishName: 'Pashto',
    ),
    AppLanguage(
      locale: Locale('fa'),
      nativeLabel: 'فارسی',
      englishName: 'Persian',
    ),
    AppLanguage(
      locale: Locale('fr'),
      nativeLabel: 'Français',
      englishName: 'French',
    ),
    AppLanguage(
      locale: Locale('es'),
      nativeLabel: 'Español',
      englishName: 'Spanish',
    ),
    AppLanguage(
      locale: Locale('id'),
      nativeLabel: 'Indonesia',
      englishName: 'Indonesian',
    ),
    AppLanguage(
      locale: Locale('tr'),
      nativeLabel: 'Türkçe',
      englishName: 'Turkish',
    ),
  ];

  static String nativeLabelFor(Locale locale) {
    for (final AppLanguage option in supported) {
      if (option.matches(locale)) return option.nativeLabel;
    }
    final String? country = locale.countryCode;
    if (country != null && country.isNotEmpty) {
      return '${locale.languageCode}_$country';
    }
    return locale.languageCode;
  }
}
