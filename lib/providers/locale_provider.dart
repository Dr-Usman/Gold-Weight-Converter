import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  Future<void> setLocale(String languageCode) async {
    state = Locale(languageCode);
    await ref.read(preferencesServiceProvider).saveLanguage(languageCode);
  }

  /// Get the current language code
  String getCurrentLanguageCode() {
    return state.languageCode;
  }
}
