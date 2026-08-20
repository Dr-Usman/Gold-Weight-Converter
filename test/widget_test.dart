import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gold_weight_converter/constants/unit_enum.dart';
import 'package:gold_weight_converter/main.dart';
import 'package:gold_weight_converter/models/gold_item_model.dart';
import 'package:gold_weight_converter/services/preferences_service.dart';

class _TestPreferencesService extends PreferencesService {
  @override
  ThemeMode getThemeMode() {
    return ThemeMode.light;
  }

  @override
  Locale getLocale() {
    return const Locale('en');
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {}

  @override
  Future<void> saveLocale(Locale locale) async {}

  @override
  String? getCurrencyCode() => 'INR';

  @override
  Future<void> saveCurrencyCode(String code) async {}

  @override
  Future<void> clearAll() async {}

  @override
  List<GoldItemModel> getZakatItems() => const [];

  @override
  Future<void> saveZakatItems(List<GoldItemModel> items) async {}

  @override
  String getZakatRateText() => '';

  @override
  Future<void> saveZakatRateText(String rateText) async {}

  @override
  UnitEnum getZakatRateUnit() => UnitEnum.tola;

  @override
  Future<void> saveZakatRateUnit(UnitEnum unit) async {}

  @override
  String getConverterRateText() => '';

  @override
  Future<void> saveConverterRateText(String rateText) async {}

  @override
  UnitEnum getConverterRateUnit() => UnitEnum.tola;

  @override
  Future<void> saveConverterRateUnit(UnitEnum unit) async {}
}

Future<void> pumpConverterApp(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        preferencesServiceProvider.overrideWithValue(_TestPreferencesService()),
      ],
      child: const MyApp(),
    ),
  );
  await tester.pumpAndSettle();
}

Finder fieldAt(int index) => find.byType(TextFormField).at(index);

Future<void> enterField(WidgetTester tester, int index, String value) async {
  await tester.enterText(fieldAt(index), value);
  await tester.pumpAndSettle();
}

Future<void> tapCalculate(WidgetTester tester) async {
  final Finder button = find.text('Calculate');
  await tester.ensureVisible(button);
  await tester.tap(button);
  await tester.pumpAndSettle();
}

Future<void> tapClearAll(WidgetTester tester) async {
  final Finder button = find.text('Clear All');
  await tester.ensureVisible(button);
  await tester.tap(button);
  await tester.pumpAndSettle();
}

Future<void> selectRateUnit(WidgetTester tester, String unitLabel) async {
  final Finder dropdown = find.byType(DropdownButton<String>);
  await tester.ensureVisible(dropdown);
  await tester.tap(dropdown);
  await tester.pumpAndSettle();
  await tester.tap(find.text(unitLabel).last);
  await tester.pumpAndSettle();
}

double totalGramsFor(List<double> weights) {
  const double tolaToGram = 11.66;
  const double mashaToGram = 0.972;
  const double anaToGram = 0.72875;
  const double rattiToGram = 0.1215;

  return weights[0] * tolaToGram +
      weights[1] * mashaToGram +
      weights[2] * anaToGram +
      weights[3] * rattiToGram +
      weights[4];
}

void main() {
  testWidgets('loads the converter screen and primary actions', (
    WidgetTester tester,
  ) async {
    await pumpConverterApp(tester);

    expect(find.text('Gold Weight Converter'), findsOneWidget);
    expect(find.text('Tola'), findsAtLeastNWidgets(1));
    expect(find.text('Masha'), findsAtLeastNWidgets(1));
    expect(find.text('Ana'), findsAtLeastNWidgets(1));
    expect(find.text('Ratti'), findsAtLeastNWidgets(1));
    expect(find.text('Gram'), findsAtLeastNWidgets(1));
    expect(find.text('Calculate'), findsOneWidget);
    expect(find.text('Clear All'), findsOneWidget);
  });

  testWidgets('converts a single tola input into grams', (
    WidgetTester tester,
  ) async {
    await pumpConverterApp(tester);

    await enterField(tester, 0, '1');
    await tapCalculate(tester);

    expect(find.text('Conversion Details'), findsOneWidget);
    expect(
      find.textContaining('Tola: 1.0 × 11.66 = 11.6600 grams'),
      findsOneWidget,
    );
    expect(find.textContaining('Total Weight: 11.6600 grams'), findsOneWidget);
    expect(find.textContaining('Tola: 1.0000'), findsOneWidget);
  });

  testWidgets('sums multiple weight units before converting', (
    WidgetTester tester,
  ) async {
    await pumpConverterApp(tester);

    await enterField(tester, 0, '1');
    await enterField(tester, 1, '2');
    await enterField(tester, 2, '3');
    await enterField(tester, 3, '4');
    await enterField(tester, 4, '5');
    await tapCalculate(tester);

    final double expectedGrams = totalGramsFor([1, 2, 3, 4, 5]);
    final String expectedTotal = expectedGrams.toStringAsFixed(4);

    expect(
      find.textContaining('Masha: 2.0 × 0.972 = 1.9440 grams'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Ana: 3.0 × 0.72875 = 2.1863 grams'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Ratti: 4.0 × 0.1215 = 0.4860 grams'),
      findsOneWidget,
    );
    expect(find.textContaining('Gram: 5.0 grams'), findsOneWidget);
    expect(
      find.textContaining('Total Weight: $expectedTotal grams'),
      findsOneWidget,
    );
  });

  testWidgets('calculates gold price using the tola rate unit', (
    WidgetTester tester,
  ) async {
    await pumpConverterApp(tester);

    await enterField(tester, 0, '1');
    await enterField(tester, 5, '1166');
    await selectRateUnit(tester, 'Tola');
    await tapCalculate(tester);

    expect(find.textContaining('Gold Price: ₹1,166.00'), findsOneWidget);
    expect(find.textContaining('(Rate: ₹1,166.00 per Tola)'), findsOneWidget);
  });

  testWidgets('calculates gold price using the 10 Gram rate unit', (
    WidgetTester tester,
  ) async {
    await pumpConverterApp(tester);

    await enterField(tester, 4, '10');
    await enterField(tester, 5, '2000');
    await selectRateUnit(tester, '10 Gram');
    await tapCalculate(tester);

    expect(find.textContaining('Gold Price: ₹2,000.00'), findsOneWidget);
    expect(
      find.textContaining('(Rate: ₹2,000.00 per 10 Gram)'),
      findsOneWidget,
    );
  });

  testWidgets('calculates gold price using the 1 Gram rate unit', (
    WidgetTester tester,
  ) async {
    await pumpConverterApp(tester);

    await enterField(tester, 4, '5');
    await enterField(tester, 5, '3000');
    await selectRateUnit(tester, '1 Gram');
    await tapCalculate(tester);

    expect(find.textContaining('Gold Price: ₹15,000.00'), findsOneWidget);
    expect(find.textContaining('(Rate: ₹3,000.00 per 1 Gram)'), findsOneWidget);
  });

  testWidgets('clear all removes entered values and hides results', (
    WidgetTester tester,
  ) async {
    await pumpConverterApp(tester);

    await enterField(tester, 0, '1');
    await enterField(tester, 5, '1166');
    await tapCalculate(tester);
    expect(find.text('Conversion Details'), findsOneWidget);
    expect(find.textContaining('Gold Price:'), findsOneWidget);

    await tapClearAll(tester);

    for (final int index in List<int>.generate(6, (value) => value)) {
      expect(fieldAt(index), findsOneWidget);
      final TextFormField field = tester.widget<TextFormField>(fieldAt(index));
      expect(field.controller?.text ?? '', isEmpty);
    }

    expect(find.text('Conversion Details'), findsNothing);
    expect(find.textContaining('Gold Price:'), findsNothing);
  });

  testWidgets('opens gold zakat screen from the drawer', (
    WidgetTester tester,
  ) async {
    await pumpConverterApp(tester);

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    expect(find.text('Gold Zakat'), findsOneWidget);
    await tester.tap(find.text('Gold Zakat'));
    await tester.pumpAndSettle();

    expect(find.text('Your gold items'), findsOneWidget);
    expect(find.textContaining('Helper for gold items only'), findsOneWidget);
    expect(find.text('Add item'), findsOneWidget);
  });

  testWidgets('shows copy and share actions after converting', (
    WidgetTester tester,
  ) async {
    await pumpConverterApp(tester);

    await enterField(tester, 0, '1');
    await tapCalculate(tester);

    expect(find.byTooltip('Copy'), findsOneWidget);
    expect(find.byTooltip('Share'), findsOneWidget);
  });

  testWidgets('drawer exposes theme modes and about links', (
    WidgetTester tester,
  ) async {
    await pumpConverterApp(tester);

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    expect(find.text('Light'), findsOneWidget);
    expect(find.text('Dark'), findsOneWidget);
    expect(find.text('System'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
    expect(find.text('Privacy policy'), findsOneWidget);
    expect(find.text('Rate app'), findsOneWidget);
    expect(find.text('Share app'), findsOneWidget);
  });

  testWidgets('persists converter gold rate across launches', (
    WidgetTester tester,
  ) async {
    final _MemoryPreferencesService prefs = _MemoryPreferencesService();

    Future<void> pumpWithPrefs() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [preferencesServiceProvider.overrideWithValue(prefs)],
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();
    }

    await pumpWithPrefs();
    await enterField(tester, 5, '1166');
    expect(prefs.converterRateText.replaceAll(',', ''), '1166');

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
    await pumpWithPrefs();

    final TextFormField rateField = tester.widget<TextFormField>(fieldAt(5));
    expect(rateField.controller?.text.replaceAll(',', ''), '1166');
  });
}

class _MemoryPreferencesService extends _TestPreferencesService {
  String converterRateText = '';
  UnitEnum converterRateUnit = UnitEnum.tola;
  ThemeMode storedThemeMode = ThemeMode.light;

  @override
  String getConverterRateText() => converterRateText;

  @override
  Future<void> saveConverterRateText(String rateText) async {
    converterRateText = rateText;
  }

  @override
  UnitEnum getConverterRateUnit() => converterRateUnit;

  @override
  Future<void> saveConverterRateUnit(UnitEnum unit) async {
    converterRateUnit = unit;
  }

  @override
  ThemeMode getThemeMode() => storedThemeMode;

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    storedThemeMode = mode;
  }
}
