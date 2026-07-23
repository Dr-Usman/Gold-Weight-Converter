import 'package:gold_weight_converter/constants/purity_enum.dart';
import 'package:gold_weight_converter/constants/unit_enum.dart';
import 'package:gold_weight_converter/constants/zakat_constants.dart';
import 'package:gold_weight_converter/models/gold_item_model.dart';
import 'package:gold_weight_converter/services/weight_converter.dart';

/// Immutable summary of zakat on a list of gold items.
class ZakatSummary {
  final double totalGrossGrams;
  final double totalPureGrams;
  final double? totalValue;
  final double? zakatDue;
  final bool hasGoldRate;

  const ZakatSummary({
    required this.totalGrossGrams,
    required this.totalPureGrams,
    required this.totalValue,
    required this.zakatDue,
    required this.hasGoldRate,
  });

  double get totalPureTola => WeightConverter.gramsToTola(totalPureGrams);

  static const ZakatSummary empty = ZakatSummary(
    totalGrossGrams: 0,
    totalPureGrams: 0,
    totalValue: null,
    zakatDue: null,
    hasGoldRate: false,
  );
}

/// Pure Dart zakat math — no Flutter / UI dependencies.
class ZakatCalculator {
  ZakatCalculator._();

  /// Pure gold grams for one item: gross grams × (karat / 24).
  static double pureGramsForItem(GoldItemModel item) {
    final double gross = WeightConverter.toGrams(item.weight, item.unit);
    final int karat = item.effectiveKarat;
    return gross * PurityEnum.fractionForKarat(karat);
  }

  /// Gross grams for one item (before purity).
  static double grossGramsForItem(GoldItemModel item) {
    return WeightConverter.toGrams(item.weight, item.unit);
  }

  /// Computes zakat on [items] using a shared market [rate] quoted per [rateUnit].
  ///
  /// Always applies 2.5% when a positive rate is provided — no nisab gate.
  static ZakatSummary calculate({
    required List<GoldItemModel> items,
    required double rate,
    required UnitEnum rateUnit,
  }) {
    if (items.isEmpty) return ZakatSummary.empty;

    double totalGross = 0;
    double totalPure = 0;
    for (final item in items) {
      if (item.weight <= 0) continue;
      totalGross += grossGramsForItem(item);
      totalPure += pureGramsForItem(item);
    }

    final bool hasRate = rate > 0;
    if (!hasRate || totalPure <= 0) {
      return ZakatSummary(
        totalGrossGrams: totalGross,
        totalPureGrams: totalPure,
        totalValue: null,
        zakatDue: null,
        hasGoldRate: hasRate,
      );
    }

    final double gramRate = WeightConverter.ratePerGram(rate, rateUnit);
    final double totalValue = totalPure * gramRate;
    final double zakatDue = totalValue * ZakatConstants.zakatRate;

    return ZakatSummary(
      totalGrossGrams: totalGross,
      totalPureGrams: totalPure,
      totalValue: totalValue,
      zakatDue: zakatDue,
      hasGoldRate: true,
    );
  }
}
