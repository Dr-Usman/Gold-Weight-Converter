import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gold_weight_converter/models/gold_result_model.dart';

final goldResultNotifierProvider =
    NotifierProvider<GoldResultNotifier, GoldResultModel>(() {
      return GoldResultNotifier();
    });

class GoldResultNotifier extends Notifier<GoldResultModel> {
  @override
  GoldResultModel build() {
    return GoldResultModel(); // Initial state with null values
  }

  void setGoldWeights(
    String? weights, {
    double? totalGrams,
    double? totalTola,
  }) {
    state = state.copyWith(
      weightsText: weights,
      totalGrams: totalGrams,
      totalTola: totalTola,
    );
  }

  void setGoldPrice(String? price) {
    state = state.copyWith(priceText: price);
  }

  void clearResults() {
    state = GoldResultModel(); // Reset to initial state
  }
}
