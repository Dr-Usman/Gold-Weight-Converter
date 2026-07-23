import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gold_weight_converter/constants/unit_enum.dart';
import 'package:gold_weight_converter/models/gold_item_model.dart';
import 'package:gold_weight_converter/services/preferences_service.dart';
import 'package:gold_weight_converter/services/zakat_calculator.dart';
import 'package:gold_weight_converter/utils/number_helper.dart';

/// Persisted zakat inventory + shared gold rate.
class ZakatState {
  final List<GoldItemModel> items;
  final String rateText;
  final UnitEnum rateUnit;

  const ZakatState({
    required this.items,
    required this.rateText,
    required this.rateUnit,
  });

  double get rateValue {
    final double? parsed = NumberHelper.parseFormattedNumber(rateText);
    if (parsed == null || parsed < 0) return 0;
    return parsed;
  }

  ZakatSummary get summary => ZakatCalculator.calculate(
    items: items,
    rate: rateValue,
    rateUnit: rateUnit,
  );

  ZakatState copyWith({
    List<GoldItemModel>? items,
    String? rateText,
    UnitEnum? rateUnit,
  }) {
    return ZakatState(
      items: items ?? this.items,
      rateText: rateText ?? this.rateText,
      rateUnit: rateUnit ?? this.rateUnit,
    );
  }
}

final zakatNotifierProvider = NotifierProvider<ZakatNotifier, ZakatState>(() {
  return ZakatNotifier();
});

class ZakatNotifier extends Notifier<ZakatState> {
  PreferencesService get _prefs => ref.read(preferencesServiceProvider);

  @override
  ZakatState build() {
    return ZakatState(
      items: _prefs.getZakatItems(),
      rateText: _prefs.getZakatRateText(),
      rateUnit: _prefs.getZakatRateUnit(),
    );
  }

  Future<void> addItem(GoldItemModel item) async {
    final List<GoldItemModel> next = [...state.items, item];
    state = state.copyWith(items: next);
    await _prefs.saveZakatItems(next);
  }

  Future<void> updateItem(GoldItemModel item) async {
    final List<GoldItemModel> next = [
      for (final GoldItemModel existing in state.items)
        if (existing.id == item.id) item else existing,
    ];
    state = state.copyWith(items: next);
    await _prefs.saveZakatItems(next);
  }

  Future<void> removeItem(String id) async {
    final List<GoldItemModel> next = state.items
        .where((item) => item.id != id)
        .toList();
    state = state.copyWith(items: next);
    await _prefs.saveZakatItems(next);
  }

  Future<void> clearItems() async {
    state = state.copyWith(items: const []);
    await _prefs.saveZakatItems(const []);
  }

  Future<void> setRateText(String rateText) async {
    state = state.copyWith(rateText: rateText);
    await _prefs.saveZakatRateText(rateText);
  }

  Future<void> setRateUnit(UnitEnum unit) async {
    state = state.copyWith(rateUnit: unit);
    await _prefs.saveZakatRateUnit(unit);
  }
}
