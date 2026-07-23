import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/analytics_service.dart';
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
    if (state == mode) return;

    final ThemeMode previousThemeMode = state;
    state = mode;
    ref.read(preferencesServiceProvider).saveThemeMode(mode);
    AnalyticsService.trackThemeChanged(
      themeMode: mode,
      previousThemeMode: previousThemeMode,
    );
  }

  void toggleThemeMode() {
    setThemeMode(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }
}
