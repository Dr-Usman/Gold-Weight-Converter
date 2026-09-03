import 'package:gold_weight_converter/constants/app_constants.dart';
import 'package:gold_weight_converter/constants/unit_enum.dart';
import 'package:gold_weight_converter/constants/weight_unit_enum.dart';

/// Shared weight conversion helpers used by converter and zakat screens.
class WeightConverter {
  WeightConverter._();

  /// Converts a single weight value in [unit] to grams.
  static double toGrams(double value, WeightUnitEnum unit) {
    if (value <= 0) return 0;
    return value * unit.gramsPerUnit;
  }

  /// Sums mixed traditional + metric weight inputs into total grams.
  static double totalGrams({
    double tola = 0,
    double lal = 0,
    double masha = 0,
    double ana = 0,
    double ratti = 0,
    double gram = 0,
  }) {
    return (tola * AppConstants.tolaToGram) +
        (lal * AppConstants.lalToGram) +
        (masha * AppConstants.mashaToGram) +
        (ana * AppConstants.anaToGram) +
        (ratti * AppConstants.rattiToGram) +
        gram;
  }

  /// Converts total grams into [unit].
  static double fromGrams(double grams, WeightUnitEnum unit) {
    if (grams <= 0) return 0;
    return grams / unit.gramsPerUnit;
  }

  /// Converts total grams into tola.
  static double gramsToTola(double grams) {
    return fromGrams(grams, WeightUnitEnum.tola);
  }

  /// Converts a market rate quoted per [rateUnit] into rate per gram.
  static double ratePerGram(double rate, UnitEnum rateUnit) {
    if (rate <= 0) return 0;
    return switch (rateUnit) {
      UnitEnum.tola => rate / AppConstants.tolaToGram,
      UnitEnum.tenGram => rate / 10,
      UnitEnum.oneGram => rate,
    };
  }
}
