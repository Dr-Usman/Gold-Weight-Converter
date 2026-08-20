import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gold_weight_converter/constants/unit_enum.dart';
import 'package:gold_weight_converter/services/preferences_service.dart';

final rateUnitProvider = NotifierProvider<RateUnitNotifier, UnitEnum>(
  RateUnitNotifier.new,
);

class RateUnitNotifier extends Notifier<UnitEnum> {
  @override
  UnitEnum build() {
    return ref.read(preferencesServiceProvider).getConverterRateUnit();
  }

  Future<void> setRateUnit(UnitEnum unit) async {
    if (state == unit) return;
    state = unit;
    await ref.read(preferencesServiceProvider).saveConverterRateUnit(unit);
  }
}
