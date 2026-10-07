import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gold_weight_converter/l10n/app_localizations.dart';
import 'package:gold_weight_converter/models/conversion_history_item.dart';
import 'package:gold_weight_converter/models/gold_item_model.dart';
import 'package:gold_weight_converter/providers/history_provider.dart';
import 'package:gold_weight_converter/screens/history/conversion_history_screen.dart';
import 'package:gold_weight_converter/services/preferences_service.dart';

class _FakePreferencesService extends PreferencesService {
  List<ConversionHistoryItem> _history = [];

  @override
  ThemeMode getThemeMode() => ThemeMode.light;

  @override
  Locale getLocale() => const Locale('en');

  @override
  String? getCurrencyCode() => 'PKR';

  @override
  List<GoldItemModel> getZakatItems() => const [];

  @override
  String getConverterRateText() => '';

  @override
  List<ConversionHistoryItem> getConversionHistory() =>
      List.unmodifiable(_history);

  @override
  Future<void> saveConversionHistory(List<ConversionHistoryItem> items) async {
    _history = List.from(items);
  }
}

void main() {
  group('ConversionHistoryItem Model', () {
    test('serializes to and from json correctly', () {
      final now = DateTime.now();
      final item = ConversionHistoryItem(
        id: 'test-123',
        timestamp: now,
        inputs: {'tola': 1.5, 'masha': 2.0},
        goldRate: 250000.0,
        rateUnit: 'tola',
        currencyCode: 'PKR',
        totalGrams: 19.432,
        totalTola: 1.6666,
        priceFormatted: 'PKR 416,650',
        resultText: 'Conversion results text',
        isNepaliSystem: false,
      );

      final json = item.toJson();
      final reconstructed = ConversionHistoryItem.fromJson(json);

      expect(reconstructed.id, item.id);
      expect(reconstructed.inputs['tola'], 1.5);
      expect(reconstructed.inputs['masha'], 2.0);
      expect(reconstructed.goldRate, 250000.0);
      expect(reconstructed.rateUnit, 'tola');
      expect(reconstructed.currencyCode, 'PKR');
      expect(reconstructed.totalGrams, 19.432);
      expect(reconstructed.totalTola, 1.6666);
      expect(reconstructed.priceFormatted, 'PKR 416,650');
      expect(reconstructed.resultText, 'Conversion results text');
      expect(reconstructed.isNepaliSystem, isFalse);
    });
  });

  group('ConversionHistoryNotifier Provider', () {
    test('adds items and enforces maxHistoryCount limit', () async {
      final fakePrefs = _FakePreferencesService();
      final container = ProviderContainer(
        overrides: [preferencesServiceProvider.overrideWithValue(fakePrefs)],
      );
      addTearDown(container.dispose);

      final notifier = container.read(conversionHistoryProvider.notifier);

      for (int i = 0; i < 35; i++) {
        await notifier.addEntry(
          ConversionHistoryItem(
            id: 'item-$i',
            timestamp: DateTime.now().add(Duration(minutes: i)),
            inputs: {'tola': i.toDouble() + 1.0},
            totalGrams: (i + 1) * 11.66,
            totalTola: i + 1.0,
          ),
        );
      }

      final list = container.read(conversionHistoryProvider);
      expect(list.length, ConversionHistoryNotifier.maxHistoryCount);
      expect(list.first.id, 'item-34'); // newest item at the top
    });

    test(
      'deduplicates identical consecutive calculation submissions',
      () async {
        final fakePrefs = _FakePreferencesService();
        final container = ProviderContainer(
          overrides: [preferencesServiceProvider.overrideWithValue(fakePrefs)],
        );
        addTearDown(container.dispose);

        final notifier = container.read(conversionHistoryProvider.notifier);

        final item = ConversionHistoryItem(
          id: 'dup-1',
          timestamp: DateTime.now(),
          inputs: {'tola': 2.0},
          totalGrams: 23.32,
          totalTola: 2.0,
          goldRate: 200000,
          rateUnit: 'tola',
        );

        final itemDuplicate = ConversionHistoryItem(
          id: 'dup-2',
          timestamp: DateTime.now(),
          inputs: {'tola': 2.0},
          totalGrams: 23.32,
          totalTola: 2.0,
          goldRate: 200000,
          rateUnit: 'tola',
        );

        await notifier.addEntry(item);
        expect(container.read(conversionHistoryProvider).length, 1);

        await notifier.addEntry(itemDuplicate);
        expect(container.read(conversionHistoryProvider).length, 1);
      },
    );

    test('deletes individual entry and clears all entries', () async {
      final fakePrefs = _FakePreferencesService();
      final container = ProviderContainer(
        overrides: [preferencesServiceProvider.overrideWithValue(fakePrefs)],
      );
      addTearDown(container.dispose);

      final notifier = container.read(conversionHistoryProvider.notifier);

      await notifier.addEntry(
        ConversionHistoryItem(
          id: 'item-a',
          timestamp: DateTime.now(),
          inputs: {'tola': 1.0},
          totalGrams: 11.66,
          totalTola: 1.0,
        ),
      );
      await notifier.addEntry(
        ConversionHistoryItem(
          id: 'item-b',
          timestamp: DateTime.now(),
          inputs: {'tola': 2.0},
          totalGrams: 23.32,
          totalTola: 2.0,
        ),
      );

      expect(container.read(conversionHistoryProvider).length, 2);

      await notifier.deleteEntry('item-a');
      expect(container.read(conversionHistoryProvider).length, 1);
      expect(container.read(conversionHistoryProvider).first.id, 'item-b');

      await notifier.clearAll();
      expect(container.read(conversionHistoryProvider), isEmpty);
    });
  });

  group('ConversionHistoryScreen Widget', () {
    testWidgets('shows empty state when history is empty', (tester) async {
      final fakePrefs = _FakePreferencesService();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [preferencesServiceProvider.overrideWithValue(fakePrefs)],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: ConversionHistoryScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.history_rounded), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets('renders history cards and restores when tapped', (
      tester,
    ) async {
      final fakePrefs = _FakePreferencesService();
      final container = ProviderContainer(
        overrides: [preferencesServiceProvider.overrideWithValue(fakePrefs)],
      );
      addTearDown(container.dispose);

      final item = ConversionHistoryItem(
        id: 'hist-1',
        timestamp: DateTime.now(),
        inputs: {'tola': 1.5, 'gram': 2.0},
        totalGrams: 19.49,
        totalTola: 1.6715,
        priceFormatted: 'PKR 450,000',
      );
      await container.read(conversionHistoryProvider.notifier).addEntry(item);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: ConversionHistoryScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('1.6715'), findsOneWidget);
      expect(find.text('PKR 450,000'), findsOneWidget);

      // Tap restore
      await tester.tap(find.byIcon(Icons.restore));
      await tester.pumpAndSettle();

      final pending = container.read(pendingRestoreProvider);
      expect(pending?.id, 'hist-1');
    });

    testWidgets(
      'dismissing a card shows snackbar with undo and restores on undo tap',
      (tester) async {
        final fakePrefs = _FakePreferencesService();
        final container = ProviderContainer(
          overrides: [preferencesServiceProvider.overrideWithValue(fakePrefs)],
        );
        addTearDown(container.dispose);

        final item = ConversionHistoryItem(
          id: 'hist-1',
          timestamp: DateTime.now(),
          inputs: {'tola': 1.0},
          totalGrams: 11.66,
          totalTola: 1.0,
        );
        await container.read(conversionHistoryProvider.notifier).addEntry(item);

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: ConversionHistoryScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(Dismissible), findsOneWidget);

        // Swipe to dismiss
        await tester.drag(find.byType(Dismissible), const Offset(-500, 0));
        await tester.pumpAndSettle();

        expect(container.read(conversionHistoryProvider), isEmpty);
        expect(find.byType(SnackBar), findsOneWidget);

        // Tap undo
        await tester.tap(find.text('Undo'));
        await tester.pumpAndSettle();

        expect(container.read(conversionHistoryProvider).length, 1);
        expect(container.read(conversionHistoryProvider).first.id, 'hist-1');
      },
    );
  });
}
