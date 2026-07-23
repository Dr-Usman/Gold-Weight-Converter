import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/analytics_service.dart';
import '../services/preferences_service.dart';

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(() {
  return LocaleNotifier();
});

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    final prefs = ref.read(preferencesServiceProvider);
    return prefs.getLocale();
  }

  /// Change the app locale and save it
  Future<void> setLocale(Locale? locale) async {
    final prefs = ref.read(preferencesServiceProvider);
    final newLocale = locale ?? const Locale('en');
    final Locale previousLocale = state;

    final bool isSameLocale =
        previousLocale.languageCode == newLocale.languageCode &&
        previousLocale.countryCode == newLocale.countryCode;
    if (isSameLocale) return;

    state = newLocale;
    await prefs.saveLocale(newLocale);
    AnalyticsService.trackLanguageChanged(
      language: newLocale,
      previousLanguage: previousLocale,
    );
  }

  /// Get the current language code
  String getCurrentLanguageCode() {
    return state.languageCode;
  }
}
