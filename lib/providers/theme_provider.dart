import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/preferences_service.dart';

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(() {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final prefs = ref.read(preferencesServiceProvider);
    return prefs.getThemeMode();
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
    ref.read(preferencesServiceProvider).saveThemeMode(mode);
  }

  void toggleThemeMode() {
    setThemeMode(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }
}
