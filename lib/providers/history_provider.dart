import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/conversion_history_item.dart';
import '../services/analytics_service.dart';
import '../services/preferences_service.dart';

final conversionHistoryProvider =
    NotifierProvider<ConversionHistoryNotifier, List<ConversionHistoryItem>>(
      () {
        return ConversionHistoryNotifier();
      },
    );

final pendingRestoreProvider =
    NotifierProvider<PendingRestoreNotifier, ConversionHistoryItem?>(() {
      return PendingRestoreNotifier();
    });

class PendingRestoreNotifier extends Notifier<ConversionHistoryItem?> {
  @override
  ConversionHistoryItem? build() => null;

  void requestRestore(ConversionHistoryItem item) {
    state = item;
  }

  void clear() {
    state = null;
  }
}

class ConversionHistoryNotifier extends Notifier<List<ConversionHistoryItem>> {
  static const int maxHistoryCount = 30;

  @override
  List<ConversionHistoryItem> build() {
    final PreferencesService prefs = ref.read(preferencesServiceProvider);
    return prefs.getConversionHistory();
  }

  Future<void> addEntry(ConversionHistoryItem item) async {
    // Avoid immediate duplicate entry if inputs, rate, and unit match the latest
    if (state.isNotEmpty) {
      final ConversionHistoryItem latest = state.first;
      if (_areEntriesSimilar(latest, item)) {
        return;
      }
    }

    final List<ConversionHistoryItem> updated = [
      item,
      ...state,
    ].take(maxHistoryCount).toList();

    state = updated;
    await ref.read(preferencesServiceProvider).saveConversionHistory(updated);
  }

  Future<void> deleteEntry(String id) async {
    final List<ConversionHistoryItem> updated = state
        .where((entry) => entry.id != id)
        .toList();
    state = updated;
    await ref.read(preferencesServiceProvider).saveConversionHistory(updated);
  }

  Future<void> clearAll() async {
    final int count = state.length;
    state = const [];
    await ref.read(preferencesServiceProvider).saveConversionHistory(const []);
    AnalyticsService.trackHistoryCleared(count);
  }

  bool _areEntriesSimilar(ConversionHistoryItem a, ConversionHistoryItem b) {
    if (a.totalGrams != b.totalGrams ||
        a.totalTola != b.totalTola ||
        a.goldRate != b.goldRate ||
        a.rateUnit != b.rateUnit ||
        a.isNepaliSystem != b.isNepaliSystem) {
      return false;
    }

    if (a.inputs.length != b.inputs.length) return false;
    for (final entry in a.inputs.entries) {
      if (b.inputs[entry.key] != entry.value) {
        return false;
      }
    }
    return true;
  }
}
