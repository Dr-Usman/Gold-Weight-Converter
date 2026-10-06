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

  final Locale deviceLocale = PlatformDispatcher.instance.locale;
  final Duration timeZoneOffset = DateTime.now().timeZoneOffset;

  final String preferredCurrency =
      preferencesService.getCurrencyCode() ??
      AppCurrency.resolveDefault(
        deviceLocale,
        timeZoneOffset: timeZoneOffset,
      ).code;

  await AnalyticsService.init(
    initialLocale: preferencesService.getLocale(),
    initialThemeMode: preferencesService.getThemeMode(),
    initialPreferredCurrency: preferredCurrency,
    deviceLocale: deviceLocale,
    timeZoneOffset: timeZoneOffset,
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
