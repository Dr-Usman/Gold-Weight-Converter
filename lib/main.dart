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

  // Screenshot / store-listing demo overrides (compile-time dart-defines).
  // Example:
  //   --dart-define=SCREENSHOT_DEMO=true --dart-define=SCREENSHOT_LOCALE=ur
  //   --dart-define=SCREENSHOT_CURRENCY=PKR --dart-define=SCREENSHOT_RATE=438,000
  const bool screenshotDemo = bool.fromEnvironment(
    'SCREENSHOT_DEMO',
    defaultValue: false,
  );
  if (screenshotDemo) {
    const String screenshotLocale = String.fromEnvironment(
      'SCREENSHOT_LOCALE',
      defaultValue: '',
    );
    const String screenshotCurrency = String.fromEnvironment(
      'SCREENSHOT_CURRENCY',
      defaultValue: '',
    );
    const String screenshotRate = String.fromEnvironment(
      'SCREENSHOT_RATE',
      defaultValue: '',
    );
    if (screenshotLocale.isNotEmpty) {
      final parts = screenshotLocale.split('_');
      final locale = parts.length >= 2
          ? Locale(parts[0], parts[1])
          : Locale(parts[0]);
      await preferencesService.saveLocale(locale);
    }
    if (screenshotCurrency.isNotEmpty) {
      await preferencesService.saveCurrencyCode(screenshotCurrency);
    }
    // Prefer dart-define rate; otherwise keep whatever prefs already have.
    if (screenshotRate.isNotEmpty) {
      await preferencesService.saveConverterRateText(screenshotRate);
      await preferencesService.saveZakatRateText(screenshotRate);
    }
    // Unlock full conversion history for Play Store shots.
    await preferencesService.saveAdFreeUntil(
      DateTime.now().add(const Duration(days: 7)),
    );
  }

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
