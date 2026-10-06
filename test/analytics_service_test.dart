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

    test(
      'themeModeToAnalyticsValue returns expected string representations',
      () {
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
      },
    );

    test('formatDeviceLocale formats locales with and without country', () {
      expect(
        AnalyticsService.formatDeviceLocale(const Locale('en')),
        equals('en'),
      );
      expect(
        AnalyticsService.formatDeviceLocale(const Locale('en', 'US')),
        equals('en_US'),
      );
      expect(
        AnalyticsService.formatDeviceLocale(const Locale('fr', 'FR')),
        equals('fr_FR'),
      );
      expect(
        AnalyticsService.formatDeviceLocale(const Locale('ar', 'QA')),
        equals('ar_QA'),
      );
    });

    test('formatTimeZoneOffset formats positive and negative offsets', () {
      expect(
        AnalyticsService.formatTimeZoneOffset(Duration.zero),
        equals('+00:00'),
      );
      expect(
        AnalyticsService.formatTimeZoneOffset(const Duration(hours: 2)),
        equals('+02:00'),
      );
      expect(
        AnalyticsService.formatTimeZoneOffset(
          const Duration(hours: 5, minutes: 30),
        ),
        equals('+05:30'),
      );
      expect(
        AnalyticsService.formatTimeZoneOffset(const Duration(hours: -5)),
        equals('-05:00'),
      );
      expect(
        AnalyticsService.formatTimeZoneOffset(
          const Duration(hours: -3, minutes: -30),
        ),
        equals('-03:30'),
      );
    });
  });
}
