import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gold_weight_converter/services/analytics_service.dart';

void main() {
  group('AnalyticsService helpers', () {
    test('localeToAnalyticsCode formats simple and regional locales', () {
      expect(
        AnalyticsService.localeToAnalyticsCode(const Locale('en')),
        equals('en'),
      );
      expect(
        AnalyticsService.localeToAnalyticsCode(const Locale('ur')),
        equals('ur'),
      );
      expect(
        AnalyticsService.localeToAnalyticsCode(const Locale('ur', 'RO')),
        equals('ur_ro'),
      );
      expect(
        AnalyticsService.localeToAnalyticsCode(const Locale('ne', 'NP')),
        equals('ne_np'),
      );
    });

    test('themeModeToAnalyticsValue returns expected string representations', () {
      expect(
        AnalyticsService.themeModeToAnalyticsValue(ThemeMode.light),
        equals('light'),
      );
      expect(
        AnalyticsService.themeModeToAnalyticsValue(ThemeMode.dark),
        equals('dark'),
      );
      expect(
        AnalyticsService.themeModeToAnalyticsValue(ThemeMode.system),
        equals('system'),
      );
    });
  });
}
