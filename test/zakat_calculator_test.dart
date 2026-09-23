import 'package:flutter_test/flutter_test.dart';
import 'package:gold_weight_converter/constants/purity_enum.dart';
import 'package:gold_weight_converter/constants/unit_enum.dart';
import 'package:gold_weight_converter/constants/weight_unit_enum.dart';
import 'package:gold_weight_converter/constants/zakat_constants.dart';
import 'package:gold_weight_converter/models/gold_item_model.dart';
import 'package:gold_weight_converter/services/weight_converter.dart';
import 'package:gold_weight_converter/services/zakat_calculator.dart';

void main() {
  group('WeightConverter', () {
    test('converts tola to grams', () {
      expect(WeightConverter.toGrams(1, WeightUnitEnum.tola), 11.66);
    });

    test('converts lal to grams', () {
      expect(
        WeightConverter.toGrams(100, WeightUnitEnum.lal),
        closeTo(11.66, 0.0001),
      );
    });

    test('sums mixed units with lal', () {
      final double total = WeightConverter.totalGrams(
        tola: 1,
        lal: 50,
        gram: 5,
      );
      expect(total, closeTo(11.66 + (50 * 0.1166) + 5, 0.0001));
    });

    test('sums mixed units', () {
      final double total = WeightConverter.totalGrams(
        tola: 1,
        masha: 2,
        gram: 5,
      );
      expect(total, closeTo(11.66 + 1.944 + 5, 0.0001));
    });

    test('converts grams back to tola', () {
      expect(
        WeightConverter.fromGrams(11.66, WeightUnitEnum.tola),
        closeTo(1, 0.0001),
      );
    });

    test('converts grams back to lal', () {
      expect(
        WeightConverter.fromGrams(11.66, WeightUnitEnum.lal),
        closeTo(100, 0.0001),
      );
    });

    test('converts rate per tola to per gram', () {
      expect(
        WeightConverter.ratePerGram(1166, UnitEnum.tola),
        closeTo(100, 0.0001),
      );
    });

    test('converts ana to grams with exact 5-decimal precision', () {
      expect(
        WeightConverter.toGrams(1, WeightUnitEnum.ana),
        0.72875,
      );
      expect(
        WeightConverter.fromGrams(0.72875, WeightUnitEnum.ana),
        closeTo(1.0, 0.000001),
      );
    });

    test('converts ratti to grams with exact precision', () {
      expect(
        WeightConverter.toGrams(1, WeightUnitEnum.ratti),
        0.1215,
      );
      expect(
        WeightConverter.fromGrams(0.1215, WeightUnitEnum.ratti),
        closeTo(1.0, 0.000001),
      );
    });

    test('converts masha to grams with exact precision', () {
      expect(
        WeightConverter.toGrams(1, WeightUnitEnum.masha),
        0.972,
      );
      expect(
        WeightConverter.fromGrams(0.972, WeightUnitEnum.masha),
        closeTo(1.0, 0.000001),
      );
    });

    test('maintains accuracy with 5-decimal fractional inputs', () {
      // 0.72875 Ana + 0.12150 Ratti + 0.00005 Gram
      final double total = WeightConverter.totalGrams(
        ana: 0.72875,
        ratti: 0.1215,
        gram: 0.00005,
      );
      final double expected = (0.72875 * 0.72875) + (0.1215 * 0.1215) + 0.00005;
      expect(total, closeTo(expected, 1e-9));
    });

    test('maintains accuracy on large scale numbers (millions)', () {
      final double total = WeightConverter.totalGrams(
        tola: 1000000,
        gram: 500000,
      );
      // 1,000,000 tola = 11,660,000 grams + 500,000 = 12,160,000 grams
      expect(total, 12160000.0);
    });
  });

  group('ZakatCalculator', () {
    test('computes pure grams using karat fraction', () {
      final item = GoldItemModel(
        id: '1',
        weight: 24,
        unit: WeightUnitEnum.gram,
        purity: PurityEnum.karat22,
      );
      // 24g * 22/24 = 22g pure
      expect(ZakatCalculator.pureGramsForItem(item), closeTo(22, 0.0001));
    });

    test('always applies 2.5% with no nisab gate', () {
      final items = [
        GoldItemModel(
          id: '1',
          weight: 10,
          unit: WeightUnitEnum.gram,
          purity: PurityEnum.karat24,
        ),
      ];
      // 10g pure * 1000/g = 10,000 value → zakat 250
      final summary = ZakatCalculator.calculate(
        items: items,
        rate: 1000,
        rateUnit: UnitEnum.oneGram,
      );

      expect(summary.totalPureGrams, closeTo(10, 0.0001));
      expect(summary.totalValue, closeTo(10000, 0.01));
      expect(summary.zakatDue, closeTo(250, 0.01));
      expect(summary.zakatDue, closeTo(10000 * ZakatConstants.zakatRate, 0.01));
      expect(summary.hasGoldRate, isTrue);
    });

    test('returns value/zakat null when rate missing', () {
      final items = [
        GoldItemModel(
          id: '1',
          weight: 5,
          unit: WeightUnitEnum.gram,
          purity: PurityEnum.karat24,
        ),
      ];
      final summary = ZakatCalculator.calculate(
        items: items,
        rate: 0,
        rateUnit: UnitEnum.oneGram,
      );

      expect(summary.totalPureGrams, closeTo(5, 0.0001));
      expect(summary.totalValue, isNull);
      expect(summary.zakatDue, isNull);
      expect(summary.hasGoldRate, isFalse);
    });

    test('supports custom karat', () {
      final item = GoldItemModel(
        id: '1',
        weight: 24,
        unit: WeightUnitEnum.gram,
        purity: PurityEnum.custom,
        customKarat: 12,
      );
      expect(ZakatCalculator.pureGramsForItem(item), closeTo(12, 0.0001));
    });
  });
}
