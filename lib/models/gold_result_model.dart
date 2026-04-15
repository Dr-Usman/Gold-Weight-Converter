class GoldResultModel {
  final String? weightsText;
  final String? priceText;
  GoldResultModel({this.weightsText, this.priceText});

  GoldResultModel copyWith({String? weightsText, String? priceText}) {
    return GoldResultModel(
      weightsText: weightsText ?? this.weightsText,
      priceText: priceText ?? this.priceText,
    );
  }
}
