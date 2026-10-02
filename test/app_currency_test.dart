import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gold_weight_converter/models/app_currency.dart';

void main() {
  group('AppCurrency.resolveDefault', () {
    test('resolves to PKR for en_GB when timezone is PKT (+05:00)', () {
      final currency = AppCurrency.resolveDefault(
        const Locale('en', 'GB'),
        timeZoneOffset: const Duration(hours: 5),
      );
      expect(currency.code, equals('PKR'));
    });

    test('resolves to PKR for en_US when timezone is PKT (+05:00)', () {
      final currency = AppCurrency.resolveDefault(
        const Locale('en', 'US'),
        timeZoneOffset: const Duration(hours: 5),
      );
      expect(currency.code, equals('PKR'));
    });

    test('resolves to PKR for plain en when timezone is PKT (+05:00)', () {
      final currency = AppCurrency.resolveDefault(
        const Locale('en'),
        timeZoneOffset: const Duration(hours: 5),
      );
      expect(currency.code, equals('PKR'));
    });

    test('resolves to GBP for genuine UK timezone (UTC+0 / UTC+1)', () {
      final gmtCurrency = AppCurrency.resolveDefault(
        const Locale('en', 'GB'),
        timeZoneOffset: Duration.zero,
      );
      expect(gmtCurrency.code, equals('GBP'));

      final bstCurrency = AppCurrency.resolveDefault(
        const Locale('en', 'GB'),
        timeZoneOffset: const Duration(hours: 1),
      );
      expect(bstCurrency.code, equals('GBP'));
    });

    test('resolves to USD for genuine US timezone (e.g. UTC-5 / UTC-8)', () {
      final easternCurrency = AppCurrency.resolveDefault(
        const Locale('en', 'US'),
        timeZoneOffset: const Duration(hours: -5),
      );
      expect(easternCurrency.code, equals('USD'));

      final pacificCurrency = AppCurrency.resolveDefault(
        const Locale('en', 'US'),
        timeZoneOffset: const Duration(hours: -8),
      );
      expect(pacificCurrency.code, equals('USD'));
    });

    test('directly respects country code when not GB or US', () {
      expect(
        AppCurrency.resolveDefault(const Locale('en', 'PK')).code,
        equals('PKR'),
      );
      expect(
        AppCurrency.resolveDefault(const Locale('en', 'IN')).code,
        equals('INR'),
      );
      expect(
        AppCurrency.resolveDefault(const Locale('en', 'MY')).code,
        equals('MYR'),
      );
      expect(
        AppCurrency.resolveDefault(const Locale('en', 'AE')).code,
        equals('AED'),
      );
      expect(
        AppCurrency.resolveDefault(const Locale('es', 'AR')).code,
        equals('ARS'),
      );
      expect(
        AppCurrency.resolveDefault(const Locale('es', 'CO')).code,
        equals('COP'),
      );
      expect(
        AppCurrency.resolveDefault(const Locale('es', 'VE')).code,
        equals('VES'),
      );
    });

    test(
      'disambiguates generic locales with other South Asian/Gulf timezones',
      () {
        // India Standard Time (UTC+5:30)
        expect(
          AppCurrency.resolveDefault(
            const Locale('en', 'US'),
            timeZoneOffset: const Duration(hours: 5, minutes: 30),
          ).code,
          equals('INR'),
        );

        // Nepal Time (UTC+5:45)
        expect(
          AppCurrency.resolveDefault(
            const Locale('en', 'GB'),
            timeZoneOffset: const Duration(hours: 5, minutes: 45),
          ).code,
          equals('NPR'),
        );

        // Bangladesh Standard Time (UTC+6:00)
        expect(
          AppCurrency.resolveDefault(
            const Locale('en', 'US'),
            timeZoneOffset: const Duration(hours: 6),
          ).code,
          equals('BDT'),
        );

        // UAE / Gulf Standard Time (UTC+4:00)
        expect(
          AppCurrency.resolveDefault(
            const Locale('en', 'GB'),
            timeZoneOffset: const Duration(hours: 4),
          ).code,
          equals('AED'),
        );

        // Saudi Arabia / Arabia Standard Time (UTC+3:00)
        expect(
          AppCurrency.resolveDefault(
            const Locale('en', 'US'),
            timeZoneOffset: const Duration(hours: 3),
          ).code,
          equals('SAR'),
        );
      },
    );

    test(
      'falls back to language code when country and timezone are unmapped',
      () {
        expect(
          AppCurrency.resolveDefault(
            const Locale('ur'),
            timeZoneOffset: const Duration(hours: 12),
          ).code,
          equals('PKR'),
        );
        expect(
          AppCurrency.resolveDefault(
            const Locale('hi'),
            timeZoneOffset: const Duration(hours: 12),
          ).code,
          equals('INR'),
        );
      },
    );

    test('falls back to INR when nothing matches', () {
      expect(
        AppCurrency.resolveDefault(
          const Locale('xx', 'ZZ'),
          timeZoneOffset: const Duration(hours: 12),
        ).code,
        equals('INR'),
      );
    });
  });

  group('AppCurrency.numberFormatWithDigits', () {
    test('formats whole numbers with zero decimals when requested', () {
      final pkr = AppCurrency.fromCode('PKR');
      final formattedZero = pkr.numberFormatWithDigits(0).format(98600);
      expect(formattedZero, equals('Rs. 98,600'));

      final inr = AppCurrency.fromCode('INR');
      final formattedInr = inr.numberFormatWithDigits(0).format(150000);
      expect(formattedInr, equals('₹1,50,000'));
    });

    test('formats decimals with 2 decimal places when requested', () {
      final pkr = AppCurrency.fromCode('PKR');
      final formattedTwo = pkr.numberFormatWithDigits(2).format(98600.5);
      expect(formattedTwo, equals('Rs. 98,600.50'));

      final usd = AppCurrency.fromCode('USD');
      final formattedUsd = usd.numberFormatWithDigits(2).format(1234.56);
      expect(formattedUsd, equals('\$1,234.56'));
    });
  });
}
