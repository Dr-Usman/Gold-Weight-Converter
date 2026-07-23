import 'package:gold_weight_converter/constants/app_constants.dart';

/// Weight units used when entering gold item mass.
enum WeightUnitEnum {
  tola('tola'),
  masha('masha'),
  ana('ana'),
  ratti('ratti'),
  gram('gram');

  final String storageKey;

  const WeightUnitEnum(this.storageKey);

  double get gramsPerUnit => switch (this) {
    WeightUnitEnum.tola => AppConstants.tolaToGram,
    WeightUnitEnum.masha => AppConstants.mashaToGram,
    WeightUnitEnum.ana => AppConstants.anaToGram,
    WeightUnitEnum.ratti => AppConstants.rattiToGram,
    WeightUnitEnum.gram => 1.0,
  };

  static WeightUnitEnum fromStorageKey(String? value) {
    return WeightUnitEnum.values.firstWhere(
      (e) => e.storageKey == value || e.name == value,
      orElse: () => WeightUnitEnum.gram,
    );
  }
}
