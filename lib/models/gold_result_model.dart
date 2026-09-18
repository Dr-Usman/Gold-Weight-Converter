class GoldResultModel {
  final String? weightsText;
  final String? priceText;
  final double? totalGrams;
  final double? totalTola;

  GoldResultModel({
    this.weightsText,
    this.priceText,
    this.totalGrams,
    this.totalTola,
  });

  GoldResultModel copyWith({
    String? weightsText,
    String? priceText,
    double? totalGrams,
    double? totalTola,
  }) {
    return GoldResultModel(
      weightsText: weightsText ?? this.weightsText,
      priceText: priceText ?? this.priceText,
      totalGrams: totalGrams ?? this.totalGrams,
      totalTola: totalTola ?? this.totalTola,
    );
  }
}
