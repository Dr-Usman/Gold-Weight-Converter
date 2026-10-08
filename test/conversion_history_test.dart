import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gold_weight_converter/constants/ad_config.dart';
import 'package:gold_weight_converter/l10n/app_localizations.dart';
import 'package:gold_weight_converter/models/conversion_history_item.dart';
import 'package:gold_weight_converter/models/gold_item_model.dart';
import 'package:gold_weight_converter/providers/history_provider.dart';
import 'package:gold_weight_converter/screens/history/conversion_history_screen.dart';
import 'package:gold_weight_converter/screens/history/widgets/conversion_history_card.dart';
import 'package:gold_weight_converter/screens/history/widgets/history_unlock_card.dart';
import 'package:gold_weight_converter/services/ads_service.dart';
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

  DateTime? _adFreeUntil;

  @override
  DateTime? getAdFreeUntil() => _adFreeUntil;

  @override
  Future<void> saveAdFreeUntil(DateTime? until) async {
    _adFreeUntil = until;
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
    setUp(() {
      AdsService.bypassAdsForTesting = true;
    });

    tearDown(() {
      AdsService.bypassAdsForTesting = false;
    });

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

    testWidgets(
      'Option C: shows 1 item and unlock card when > 1 items and no pass',
      (tester) async {
        final fakePrefs = _FakePreferencesService();
        final container = ProviderContainer(
          overrides: [preferencesServiceProvider.overrideWithValue(fakePrefs)],
        );
        addTearDown(container.dispose);

        // Add 3 items
        for (int i = 1; i <= 3; i++) {
          await container
              .read(conversionHistoryProvider.notifier)
              .addEntry(
                ConversionHistoryItem(
                  id: 'hist-$i',
                  timestamp: DateTime.now().add(Duration(minutes: i)),
                  inputs: {'tola': i.toDouble()},
                  totalGrams: i * 11.66,
                  totalTola: i.toDouble(),
                ),
              );
        }

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

        // Exactly 1 ConversionHistoryCard visible (latest item)
        expect(find.byType(ConversionHistoryCard), findsOneWidget);
        // HistoryUnlockCard is rendered with unlock options
        expect(find.byType(HistoryUnlockCard), findsOneWidget);
        expect(find.textContaining('Showing 1 of 3'), findsOneWidget);
        expect(find.text('Quick Unlock (View All 3)'), findsOneWidget);
        expect(find.text('Unlock All + 24h Ad-Free'), findsOneWidget);
      },
    );

    testWidgets(
      'Option C: tapping quick unlock unlocks session and persists across navigation',
      (tester) async {
        tester.view.physicalSize = const Size(800, 2400);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final fakePrefs = _FakePreferencesService();
        final container = ProviderContainer(
          overrides: [preferencesServiceProvider.overrideWithValue(fakePrefs)],
        );
        addTearDown(container.dispose);

        for (int i = 1; i <= 5; i++) {
          await container
              .read(conversionHistoryProvider.notifier)
              .addEntry(
                ConversionHistoryItem(
                  id: 'hist-$i',
                  timestamp: DateTime.now().add(Duration(minutes: i)),
                  inputs: {'tola': i.toDouble()},
                  totalGrams: i * 11.66,
                  totalTola: i.toDouble(),
                ),
              );
        }

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

        expect(find.byType(ConversionHistoryCard), findsOneWidget);

        // Tap Quick Unlock button (dynamically shows View All 5)
        await tester.tap(find.text('Quick Unlock (View All 5)'));
        await tester.pumpAndSettle();

        // All 5 items are now visible (since 5 <= 7)
        expect(find.byType(ConversionHistoryCard), findsNWidgets(5));
        expect(find.byType(HistoryUnlockCard), findsNothing);

        // Simulate navigating away and coming back (re-mounting ConversionHistoryScreen)
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

        // Items remain unlocked across navigations for the session!
        expect(find.byType(ConversionHistoryCard), findsNWidgets(5));
        expect(find.byType(HistoryUnlockCard), findsNothing);
      },
    );

    testWidgets(
      'Option C: active 24h pass shows ad-free badge and unlocks all items',
      (tester) async {
        final fakePrefs = _FakePreferencesService();
        fakePrefs.saveAdFreeUntil(
          DateTime.now().add(const Duration(hours: 12)),
        );

        final container = ProviderContainer(
          overrides: [preferencesServiceProvider.overrideWithValue(fakePrefs)],
        );
        addTearDown(container.dispose);

        for (int i = 1; i <= 10; i++) {
          await container
              .read(conversionHistoryProvider.notifier)
              .addEntry(
                ConversionHistoryItem(
                  id: 'hist-$i',
                  timestamp: DateTime.now().add(Duration(minutes: i)),
                  inputs: {'tola': i.toDouble()},
                  totalGrams: i * 11.66,
                  totalTola: i.toDouble(),
                ),
              );
        }

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

        // Ad-free badge rendered
        expect(find.textContaining('Ad-Free Pass Active'), findsOneWidget);
        // No unlock card displayed
        expect(find.byType(HistoryUnlockCard), findsNothing);
      },
    );
  });

  group('AdConfig Placements & Unit IDs', () {
    test('returns official test IDs in debug / profile mode', () {
      expect(AdConfig.isUsingTestAds, isTrue);
      expect(
        AdConfig.getBannerAdUnitId(BannerPlacement.converter),
        'ca-app-pub-3940256099942544/6300978111',
      );
      expect(
        AdConfig.getBannerAdUnitId(BannerPlacement.zakat),
        'ca-app-pub-3940256099942544/6300978111',
      );
      expect(
        AdConfig.getBannerAdUnitId(BannerPlacement.history),
        'ca-app-pub-3940256099942544/6300978111',
      );
      expect(
        AdConfig.historyInterstitialAdUnitId,
        'ca-app-pub-3940256099942544/1033173712',
      );
      expect(
        AdConfig.historyRewardedAdUnitId,
        'ca-app-pub-3940256099942544/5224354917',
      );
    });
  });
}
