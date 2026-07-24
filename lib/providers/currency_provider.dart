import 'dart:ui' show PlatformDispatcher;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_currency.dart';
import '../services/analytics_service.dart';
import '../services/preferences_service.dart';

final currencyProvider = NotifierProvider<CurrencyNotifier, AppCurrency>(() {
  return CurrencyNotifier();
});

class CurrencyNotifier extends Notifier<AppCurrency> {
  @override
  AppCurrency build() {
    final PreferencesService prefs = ref.read(preferencesServiceProvider);
    final String? savedCode = prefs.getCurrencyCode();
    if (savedCode != null && savedCode.isNotEmpty) {
      return AppCurrency.fromCode(savedCode);
    }
    return AppCurrency.resolveDefault(PlatformDispatcher.instance.locale);
  }

  Future<void> setCurrency(AppCurrency currency) async {
    if (state.code == currency.code) return;

    final AppCurrency previous = state;
    state = currency;
    await ref.read(preferencesServiceProvider).saveCurrencyCode(currency.code);
    AnalyticsService.trackCurrencyChanged(
      currency: currency.code,
      previousCurrency: previous.code,
    );
  }
}
