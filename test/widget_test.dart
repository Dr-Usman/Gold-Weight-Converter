import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gold_weight_converter/constants/purity_enum.dart';
import 'package:gold_weight_converter/constants/unit_enum.dart';
import 'package:gold_weight_converter/constants/weight_unit_enum.dart';
import 'package:gold_weight_converter/main.dart';
import 'package:gold_weight_converter/models/conversion_history_item.dart';
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

  List<ConversionHistoryItem> _history = [];

  @override
  List<ConversionHistoryItem> getConversionHistory() => _history;

  @override
  Future<void> saveConversionHistory(List<ConversionHistoryItem> items) async {
    _history = items;
  }
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

    expect(find.textContaining('Gold Price: ₹1,166'), findsOneWidget);
    expect(find.textContaining('(Rate: ₹1,166 per Tola)'), findsOneWidget);
  });

  testWidgets('calculates gold price using the 10 Gram rate unit', (
    WidgetTester tester,
  ) async {
    await pumpConverterApp(tester);

    await enterField(tester, 4, '10');
    await enterField(tester, 5, '2000');
    await selectRateUnit(tester, '10 Gram');
    await tapCalculate(tester);

    expect(find.textContaining('Gold Price: ₹2,000'), findsOneWidget);
    expect(find.textContaining('(Rate: ₹2,000 per 10 Gram)'), findsOneWidget);
  });

  testWidgets('calculates gold price using the 1 Gram rate unit', (
    WidgetTester tester,
  ) async {
    await pumpConverterApp(tester);

    await enterField(tester, 4, '5');
    await enterField(tester, 5, '3000');
    await selectRateUnit(tester, '1 Gram');
    await tapCalculate(tester);

    expect(find.textContaining('Gold Price: ₹15,000'), findsOneWidget);
    expect(find.textContaining('(Rate: ₹3,000 per 1 Gram)'), findsOneWidget);
  });

  testWidgets('calculates gold price and converts weight using Ounce unit', (
    WidgetTester tester,
  ) async {
    await pumpConverterApp(tester);

    await selectRateUnit(tester, 'Ounce');

    // With Ounce selected, the Ounce field (index 5) appears before Rate field (index 6)
    await enterField(tester, 5, '1'); // 1 Ounce
    await enterField(tester, 6, '3000'); // 3000 per Ounce
    await tapCalculate(tester);

    expect(find.textContaining('Gold Price: ₹3,000'), findsOneWidget);
    expect(find.textContaining('(Rate: ₹3,000 per Ounce)'), findsOneWidget);
    expect(find.textContaining('Total Weight: 31.1035 grams'), findsOneWidget);
    expect(find.textContaining('Ounce: 1.0000 oz'), findsOneWidget);
  });

  testWidgets('formats decimals when rate contains fraction', (
    WidgetTester tester,
  ) async {
    await pumpConverterApp(tester);

    await enterField(tester, 4, '5');
    await enterField(tester, 5, '3000.50');
    await selectRateUnit(tester, '1 Gram');
    await tapCalculate(tester);

    expect(find.textContaining('Gold Price: ₹15,002.50'), findsOneWidget);
    expect(find.textContaining('(Rate: ₹3,000.50 per 1 Gram)'), findsOneWidget);
  });

  testWidgets(
    'rounds off gold price when gold rate is whole number even if conversion produces fraction',
    (WidgetTester tester) async {
      await pumpConverterApp(tester);

      await enterField(tester, 4, '1'); // 1 Gram
      await enterField(tester, 5, '100000'); // 100,000 per Tola
      await selectRateUnit(tester, 'Tola');
      await tapCalculate(tester);

      // 1 gram / 11.66 * 100000 = 8576.329... -> rounds to 8,576
      expect(find.textContaining('Gold Price: ₹8,576'), findsOneWidget);
      expect(find.textContaining('(Rate: ₹1,00,000 per Tola)'), findsOneWidget);
    },
  );

  testWidgets(
    'preserves decimals when gold rate has fractions with fractional weight',
    (WidgetTester tester) async {
      await pumpConverterApp(tester);

      await enterField(tester, 0, '0.5'); // 0.5 Tola
      await enterField(tester, 5, '98600.50'); // 98,600.50 per Tola
      await selectRateUnit(tester, 'Tola');
      await tapCalculate(tester);

      // 0.5 * 98,600.50 = 49,300.25
      expect(find.textContaining('Gold Price: ₹49,300.25'), findsOneWidget);
      expect(
        find.textContaining('(Rate: ₹98,600.50 per Tola)'),
        findsOneWidget,
      );
    },
  );

  testWidgets('treats rate with .00 as whole number and rounds price', (
    WidgetTester tester,
  ) async {
    await pumpConverterApp(tester);

    await enterField(tester, 0, '1');
    await enterField(tester, 5, '98600.00');
    await selectRateUnit(tester, 'Tola');
    await tapCalculate(tester);

    expect(find.textContaining('Gold Price: ₹98,600'), findsOneWidget);
    expect(find.textContaining('(Rate: ₹98,600 per Tola)'), findsOneWidget);
  });

  testWidgets('rounds price for 10 Gram rate unit when rate is whole number', (
    WidgetTester tester,
  ) async {
    await pumpConverterApp(tester);

    await enterField(tester, 4, '5'); // 5 Grams
    await enterField(tester, 5, '80000'); // 80,000 per 10 Gram
    await selectRateUnit(tester, '10 Gram');
    await tapCalculate(tester);

    // 5 * (80,000 / 10) = 40,000
    expect(find.textContaining('Gold Price: ₹40,000'), findsOneWidget);
    expect(find.textContaining('(Rate: ₹80,000 per 10 Gram)'), findsOneWidget);
  });

  testWidgets(
    'preserves decimals for 10 Gram rate unit when rate is fractional',
    (WidgetTester tester) async {
      await pumpConverterApp(tester);

      await enterField(tester, 4, '5'); // 5 Grams
      await enterField(tester, 5, '80000.75'); // 80,000.75 per 10 Gram
      await selectRateUnit(tester, '10 Gram');
      await tapCalculate(tester);

      // 5 * (80,000.75 / 10) = 40,000.375 -> rounds to 40,000.38
      expect(find.textContaining('Gold Price: ₹40,000.38'), findsOneWidget);
      expect(
        find.textContaining('(Rate: ₹80,000.75 per 10 Gram)'),
        findsOneWidget,
      );
    },
  );

  testWidgets('rounds price with mixed traditional units and whole rate', (
    WidgetTester tester,
  ) async {
    await pumpConverterApp(tester);

    await enterField(tester, 0, '1'); // 1 Tola
    await enterField(tester, 1, '2'); // 2 Masha
    await enterField(tester, 3, '4'); // 4 Ratti
    await enterField(tester, 5, '120000'); // 120,000 per Tola
    await selectRateUnit(tester, 'Tola');
    await tapCalculate(tester);

    // Total grams = 11.66 + 1.944 + 0.486 = 14.09g
    // 14.09 / 11.66 * 120,000 = 145,008.576... -> rounds to 145,009
    expect(find.textContaining('Gold Price: ₹1,45,009'), findsOneWidget);
    expect(find.textContaining('(Rate: ₹1,20,000 per Tola)'), findsOneWidget);
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

  testWidgets(
    'rounds up zakat due to next whole digit and rounds total value when rate is whole number',
    (WidgetTester tester) async {
      final prefs = _ZakatTestPreferencesService(
        items: const [
          GoldItemModel(
            id: '1',
            weight: 10,
            unit: WeightUnitEnum.gram,
            purity: PurityEnum.karat24,
          ),
        ],
        rateText: '100000',
        rateUnit: UnitEnum.tola,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [preferencesServiceProvider.overrideWithValue(prefs)],
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Gold Zakat'));
      await tester.pumpAndSettle();

      final Finder calculateBtn = find.text('Calculate zakat');
      await tester.ensureVisible(calculateBtn);
      await tester.tap(calculateBtn);
      await tester.pumpAndSettle();

      // 10g pure / 11.66 * 100,000 = 85,763.293... -> total value rounded to 85,763
      // Zakat due: 85,763.293... * 0.025 = 2,144.0823... -> ceils to 2,145
      expect(find.text('₹85,763'), findsOneWidget);
      expect(find.text('₹2,145'), findsOneWidget);
    },
  );

  testWidgets(
    'preserves decimals for zakat due and total value when rate has fractions',
    (WidgetTester tester) async {
      final prefs = _ZakatTestPreferencesService(
        items: const [
          GoldItemModel(
            id: '1',
            weight: 10,
            unit: WeightUnitEnum.gram,
            purity: PurityEnum.karat24,
          ),
        ],
        rateText: '100000.50',
        rateUnit: UnitEnum.tola,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [preferencesServiceProvider.overrideWithValue(prefs)],
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Gold Zakat'));
      await tester.pumpAndSettle();

      final Finder calculateBtn = find.text('Calculate zakat');
      await tester.ensureVisible(calculateBtn);
      await tester.tap(calculateBtn);
      await tester.pumpAndSettle();

      // 10g pure / 11.66 * 100,000.50 = 85,763.722... -> ₹85,763.72
      // Zakat due: 85,763.722... * 0.025 = 2,144.093... -> ₹2,144.09
      expect(find.text('₹85,763.72'), findsOneWidget);
      expect(find.text('₹2,144.09'), findsOneWidget);
    },
  );

  testWidgets(
    'handles exact whole zakat without extra ceil increment when rate is whole number',
    (WidgetTester tester) async {
      final prefs = _ZakatTestPreferencesService(
        items: const [
          GoldItemModel(
            id: '1',
            weight: 10,
            unit: WeightUnitEnum.gram,
            purity: PurityEnum.karat24,
          ),
        ],
        rateText: '1000',
        rateUnit: UnitEnum.oneGram,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [preferencesServiceProvider.overrideWithValue(prefs)],
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Gold Zakat'));
      await tester.pumpAndSettle();

      final Finder calculateBtn = find.text('Calculate zakat');
      await tester.ensureVisible(calculateBtn);
      await tester.tap(calculateBtn);
      await tester.pumpAndSettle();

      // 10g * 1,000 = 10,000 total value
      // Zakat due: 10,000 * 0.025 = 250 -> ceil(250) is 250
      expect(find.text('₹10,000'), findsOneWidget);
      expect(find.text('₹250'), findsOneWidget);
    },
  );

  testWidgets(
    'treats zakat rate with .00 as whole number and applies ceiling rounding',
    (WidgetTester tester) async {
      final prefs = _ZakatTestPreferencesService(
        items: const [
          GoldItemModel(
            id: '1',
            weight: 10,
            unit: WeightUnitEnum.gram,
            purity: PurityEnum.karat24,
          ),
        ],
        rateText: '100000.00',
        rateUnit: UnitEnum.tola,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [preferencesServiceProvider.overrideWithValue(prefs)],
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Gold Zakat'));
      await tester.pumpAndSettle();

      final Finder calculateBtn = find.text('Calculate zakat');
      await tester.ensureVisible(calculateBtn);
      await tester.tap(calculateBtn);
      await tester.pumpAndSettle();

      // 100000.00 is treated as whole number -> total value 85,763 and zakat due 2,145
      expect(find.text('₹85,763'), findsOneWidget);
      expect(find.text('₹2,145'), findsOneWidget);
    },
  );

  testWidgets(
    'calculates zakat for multiple mixed purity items (24k, 22k, 18k) with 10 Gram rate unit and ceiling rounds zakat',
    (WidgetTester tester) async {
      final prefs = _ZakatTestPreferencesService(
        items: const [
          GoldItemModel(
            id: '1',
            name: 'Pure bar',
            weight: 10,
            unit: WeightUnitEnum.gram,
            purity: PurityEnum.karat24,
          ),
          GoldItemModel(
            id: '2',
            name: 'Bangle',
            weight: 12,
            unit: WeightUnitEnum.gram,
            purity: PurityEnum.karat22,
          ),
          GoldItemModel(
            id: '3',
            name: 'Ring',
            weight: 8,
            unit: WeightUnitEnum.gram,
            purity: PurityEnum.karat18,
          ),
        ],
        rateText: '75000',
        rateUnit: UnitEnum.tenGram,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [preferencesServiceProvider.overrideWithValue(prefs)],
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Gold Zakat'));
      await tester.pumpAndSettle();

      await tester.drag(find.byType(ListView), const Offset(0, -400));
      await tester.pumpAndSettle();

      final Finder calculateBtn = find.text('Calculate zakat');
      await tester.tap(calculateBtn);
      await tester.pumpAndSettle();

      // Pure grams: 10 + (12 * 22/24 = 11) + (8 * 18/24 = 6) = 27.0g pure
      // Total value: 27.0g * (75,000 / 10) = 202,500 -> ₹2,02,500
      // Zakat due: 202,500 * 0.025 = 5,062.50 -> ceil is 5,063 -> ₹5,063
      expect(find.text('₹2,02,500'), findsOneWidget);
      expect(find.text('₹5,063'), findsOneWidget);
    },
  );

  testWidgets(
    'calculates zakat for multiple mixed purity items with fractional 10 Gram rate unit preserving decimals',
    (WidgetTester tester) async {
      final prefs = _ZakatTestPreferencesService(
        items: const [
          GoldItemModel(
            id: '1',
            weight: 10,
            unit: WeightUnitEnum.gram,
            purity: PurityEnum.karat24,
          ),
          GoldItemModel(
            id: '2',
            weight: 12,
            unit: WeightUnitEnum.gram,
            purity: PurityEnum.karat22,
          ),
          GoldItemModel(
            id: '3',
            weight: 8,
            unit: WeightUnitEnum.gram,
            purity: PurityEnum.karat18,
          ),
        ],
        rateText: '75000.50',
        rateUnit: UnitEnum.tenGram,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [preferencesServiceProvider.overrideWithValue(prefs)],
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Gold Zakat'));
      await tester.pumpAndSettle();

      await tester.drag(find.byType(ListView), const Offset(0, -400));
      await tester.pumpAndSettle();

      final Finder calculateBtn = find.text('Calculate zakat');
      await tester.tap(calculateBtn);
      await tester.pumpAndSettle();

      // Pure grams: 27.0g
      // Total value: 27.0g * (75,000.50 / 10) = 202,501.35 -> ₹2,02,501.35
      // Zakat due: 202,501.35 * 0.025 = 5,062.53375 -> ₹5,062.53
      expect(find.text('₹2,02,501.35'), findsOneWidget);
      expect(find.text('₹5,062.53'), findsOneWidget);
    },
  );

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
    expect(find.text('More apps'), findsOneWidget);
    expect(find.text('Share app'), findsOneWidget);
  });

  testWidgets('opens language bottom sheet and selects language', (
    WidgetTester tester,
  ) async {
    await pumpConverterApp(tester);

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();

    expect(find.text('Please select your language'), findsOneWidget);
    final nepaliOption = find.byWidgetPredicate(
      (w) => w is RichText && w.text.toPlainText().contains('नेपाली'),
    );
    expect(nepaliOption, findsOneWidget);

    // Tap Nepali
    await tester.tap(nepaliOption);
    await tester.pumpAndSettle();

    // Verify converter rendered in Nepali
    expect(find.text('सुनको तौल रूपान्तरक'), findsWidgets);
    expect(find.text('गणना गर्नुहोस्'), findsOneWidget);
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

  testWidgets('renders converter in Nepali when locale is ne', (tester) async {
    final prefs = _NepaliPreferencesService();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [preferencesServiceProvider.overrideWithValue(prefs)],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('सुनको तौल रूपान्तरक'), findsOneWidget);
    expect(find.text('गणना गर्नुहोस्'), findsOneWidget);
    expect(find.text('सबै खाली गर्नुहोस्'), findsOneWidget);
  });

  testWidgets('renders converter in Amharic when locale is am', (tester) async {
    final prefs = _LocalePreferencesService(const Locale('am'));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [preferencesServiceProvider.overrideWithValue(prefs)],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('የወርቅ ክብደት መለወጫ'), findsOneWidget);
    expect(find.text('አስላ'), findsOneWidget);
    expect(find.text('ሁሉንም አጽዳ'), findsOneWidget);
  });

  testWidgets('renders converter in Burmese when locale is my', (tester) async {
    final prefs = _LocalePreferencesService(const Locale('my'));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [preferencesServiceProvider.overrideWithValue(prefs)],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('ရွှေအလေးချိန် တွက်ချက်စက်'), findsOneWidget);
    expect(find.text('တွက်ချက်မည်'), findsOneWidget);
    expect(find.text('အားလုံးရှင်းမည်'), findsOneWidget);
  });

  testWidgets('renders converter in Filipino when locale is fil', (
    tester,
  ) async {
    final prefs = _LocalePreferencesService(const Locale('fil'));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [preferencesServiceProvider.overrideWithValue(prefs)],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Kalkulahin'), findsOneWidget);
    expect(find.text('I-clear Lahat'), findsOneWidget);
  });

  testWidgets('renders converter in Sinhala when locale is si', (tester) async {
    final prefs = _LocalePreferencesService(const Locale('si'));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [preferencesServiceProvider.overrideWithValue(prefs)],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('රන් බර පරිවර්තකය'), findsOneWidget);
    expect(find.text('ගණනය කරන්න'), findsOneWidget);
  });

  testWidgets('renders converter in Tamil when locale is ta', (tester) async {
    final prefs = _LocalePreferencesService(const Locale('ta'));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [preferencesServiceProvider.overrideWithValue(prefs)],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('தங்க எடை மாற்றி'), findsOneWidget);
    expect(find.text('கணக்கிடு'), findsOneWidget);
  });

  testWidgets('renders converter in French when locale is fr', (tester) async {
    final prefs = _LocalePreferencesService(const Locale('fr'));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [preferencesServiceProvider.overrideWithValue(prefs)],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text("Convertisseur de Poids d'Or"), findsOneWidget);
    expect(find.text('Calculer'), findsOneWidget);
  });

  testWidgets('renders converter in Spanish when locale is es', (tester) async {
    final prefs = _LocalePreferencesService(const Locale('es'));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [preferencesServiceProvider.overrideWithValue(prefs)],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Conversor de Peso de Oro'), findsOneWidget);
    expect(find.text('Calcular'), findsOneWidget);
  });

  testWidgets('renders Lal field and converts correctly in Nepali mode', (
    tester,
  ) async {
    final prefs = _NepaliPreferencesService();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [preferencesServiceProvider.overrideWithValue(prefs)],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    // In Nepali mode, fields are Tola, Ana, Lal, Gram
    expect(find.text('तोला'), findsWidgets);
    expect(find.text('आना'), findsWidgets);
    expect(find.text('लाल'), findsWidgets);
    expect(find.text('ग्राम'), findsWidgets);
    expect(find.text('मासा'), findsNothing);
    expect(find.text('रत्ती'), findsNothing);

    // Enter 1 Tola, 10 Lal
    await enterField(tester, 0, '1'); // Tola
    await enterField(tester, 2, '10'); // Lal

    final Finder calcButton = find.text('गणना गर्नुहोस्');
    await tester.ensureVisible(calcButton);
    await tester.tap(calcButton);
    await tester.pumpAndSettle();

    expect(find.textContaining('12.8260'), findsOneWidget);
    expect(
      find.textContaining('तोला: 1.0 × 11.66 = 11.6600 ग्राम'),
      findsOneWidget,
    );
    expect(
      find.textContaining('लाल: 10.0 × 0.1166 = 1.1660 ग्राम'),
      findsOneWidget,
    );
  });

  testWidgets('renders Lal field when currency is NPR in English mode', (
    tester,
  ) async {
    final prefs = _NprPreferencesService();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [preferencesServiceProvider.overrideWithValue(prefs)],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    // With NPR currency, Nepali bullion units (Tola, Ana, Lal, Gram) are shown
    expect(find.text('Tola'), findsWidgets);
    expect(find.text('Ana'), findsWidgets);
    expect(find.text('Lal'), findsWidgets);
    expect(find.text('Gram'), findsWidgets);
    expect(find.text('Masha'), findsNothing);
    expect(find.text('Ratti'), findsNothing);

    // Enter 2 Lal
    await enterField(tester, 2, '2');
    await tapCalculate(tester);

    expect(
      find.textContaining('Lal: 2.0 × 0.1166 = 0.2332 grams'),
      findsOneWidget,
    );
    expect(find.textContaining('Total Weight: 0.2332 grams'), findsOneWidget);
    expect(find.textContaining('Lal: 2.0000'), findsOneWidget);
  });
}

class _NepaliPreferencesService extends _TestPreferencesService {
  @override
  Locale getLocale() => const Locale('ne');
}

class _NprPreferencesService extends _TestPreferencesService {
  @override
  String? getCurrencyCode() => 'NPR';
}

class _LocalePreferencesService extends _TestPreferencesService {
  final Locale _locale;
  _LocalePreferencesService(this._locale);

  @override
  Locale getLocale() => _locale;
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

class _ZakatTestPreferencesService extends _TestPreferencesService {
  final List<GoldItemModel> items;
  final String rateText;
  final UnitEnum rateUnit;

  _ZakatTestPreferencesService({
    required this.items,
    this.rateText = '',
    this.rateUnit = UnitEnum.tola,
  });

  @override
  List<GoldItemModel> getZakatItems() => items;

  @override
  String getZakatRateText() => rateText;

  @override
  UnitEnum getZakatRateUnit() => rateUnit;
}
