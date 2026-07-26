import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'models/app_currency.dart';
import 'services/ads_service.dart';
import 'services/analytics_service.dart';
import 'services/preferences_service.dart';

export 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferencesService = PreferencesService();
  await preferencesService.init();

  final String preferredCurrency =
      preferencesService.getCurrencyCode() ??
      AppCurrency.resolveDefault(PlatformDispatcher.instance.locale).code;

  await AnalyticsService.init();
  AnalyticsService.syncUserPreferences(
    locale: preferencesService.getLocale(),
    themeMode: preferencesService.getThemeMode(),
    preferredCurrency: preferredCurrency,
  );
  await AdsService.init();

  runApp(
    ProviderScope(
      overrides: [
        preferencesServiceProvider.overrideWithValue(preferencesService),
      ],
      child: const GoldWeightConverterApp(),
    ),
  );
}
