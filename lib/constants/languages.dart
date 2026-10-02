import 'package:flutter/material.dart';

/// One selectable app language (native label shown in UI).
class AppLanguage {
  const AppLanguage({
    required this.locale,
    required this.nativeLabel,
    required this.englishName,
    required this.flag,
  });

  final Locale locale;
  final String nativeLabel;
  final String englishName;
  final String flag;

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
        locale.languageCode.toLowerCase().contains(q) ||
        flag.contains(q);
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
      flag: '🇺🇸',
    ),
    AppLanguage(
      locale: Locale('hi'),
      nativeLabel: 'हिंदी',
      englishName: 'Hindi',
      flag: '🇮🇳',
    ),
    AppLanguage(
      locale: Locale('ur'),
      nativeLabel: 'اردو',
      englishName: 'Urdu',
      flag: '🇵🇰',
    ),
    AppLanguage(
      locale: Locale('bn'),
      nativeLabel: 'বাংলা',
      englishName: 'Bengali',
      flag: '🇧🇩',
    ),
    AppLanguage(
      locale: Locale('ne'),
      nativeLabel: 'नेपाली',
      englishName: 'Nepali',
      flag: '🇳🇵',
    ),
    AppLanguage(
      locale: Locale('am'),
      nativeLabel: 'አማርኛ',
      englishName: 'Amharic',
      flag: '🇪🇹',
    ),
    AppLanguage(
      locale: Locale('my'),
      nativeLabel: 'မြန်မာစာ',
      englishName: 'Burmese',
      flag: '🇲🇲',
    ),
    AppLanguage(
      locale: Locale('fil'),
      nativeLabel: 'Filipino',
      englishName: 'Filipino',
      flag: '🇵🇭',
    ),
    AppLanguage(
      locale: Locale('si'),
      nativeLabel: 'සිංහල',
      englishName: 'Sinhala',
      flag: '🇱🇰',
    ),
    AppLanguage(
      locale: Locale('ta'),
      nativeLabel: 'தமிழ்',
      englishName: 'Tamil',
      flag: '🇮🇳',
    ),
    AppLanguage(
      locale: Locale('ur', 'RO'),
      nativeLabel: 'Roman Urdu',
      englishName: 'Roman Urdu',
      flag: '🇵🇰',
    ),
    AppLanguage(
      locale: Locale('ar'),
      nativeLabel: 'العربية',
      englishName: 'Arabic',
      flag: '🇸🇦',
    ),
    AppLanguage(
      locale: Locale('sd'),
      nativeLabel: 'سنڌي',
      englishName: 'Sindhi',
      flag: '🇵🇰',
    ),
    AppLanguage(
      locale: Locale('ms'),
      nativeLabel: 'Melayu',
      englishName: 'Malay',
      flag: '🇲🇾',
    ),
    AppLanguage(
      locale: Locale('ps'),
      nativeLabel: 'پښتو',
      englishName: 'Pashto',
      flag: '🇦🇫',
    ),
    AppLanguage(
      locale: Locale('fa'),
      nativeLabel: 'فارسی',
      englishName: 'Persian',
      flag: '🇮🇷',
    ),
    AppLanguage(
      locale: Locale('fr'),
      nativeLabel: 'Français',
      englishName: 'French',
      flag: '🇫🇷',
    ),
    AppLanguage(
      locale: Locale('es'),
      nativeLabel: 'Español',
      englishName: 'Spanish',
      flag: '🇪🇸',
    ),
    AppLanguage(
      locale: Locale('id'),
      nativeLabel: 'Indonesia',
      englishName: 'Indonesian',
      flag: '🇮🇩',
    ),
    AppLanguage(
      locale: Locale('tr'),
      nativeLabel: 'Türkçe',
      englishName: 'Turkish',
      flag: '🇹🇷',
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
