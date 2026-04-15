import 'package:flutter_riverpod/legacy.dart';
import 'package:gold_weight_converter/constants/unit_enum.dart';

// ## Simple Single State Provider
// final rateUnitProvider = StateProvider<String>((ref) => 'Tola'); // OR
final rateUnitProvider = StateProvider<UnitEnum>((ref) {
  return UnitEnum.tola;
});

/*
// ## New NotifierProvider approach
final rateUnitNotifierProvider = NotifierProvider<RateUnitNotifier, String>(() {
  return RateUnitNotifier();
});

class RateUnitNotifier extends Notifier<String> {
  // Initial Value
  @override
  String build() {
    return 'Tola';
  }

  void setRateUnit(String unit) {
    state = unit;
  }
}
// ## ------------------------------

// ## Legacy approach with StateNotifierProvider
final rateUnitStateNotifierProvider =
    StateNotifierProvider<RateUnitStateNotifier, String>((ref) {
      return RateUnitStateNotifier();
    });

class RateUnitStateNotifier extends StateNotifier<String> {
  RateUnitStateNotifier() : super('Tola');

  void setRateUnit(String unit) {
    state = unit;
  }
}
 */
