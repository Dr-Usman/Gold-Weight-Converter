class ConversionHistoryItem {
  final String id;
  final DateTime timestamp;
  final Map<String, double> inputs;
  final double? goldRate;
  final String? rateUnit;
  final String? currencyCode;
  final double totalGrams;
  final double totalTola;
  final String? priceFormatted;
  final String? resultText;
  final bool isNepaliSystem;

  const ConversionHistoryItem({
    required this.id,
    required this.timestamp,
    required this.inputs,
    this.goldRate,
    this.rateUnit,
    this.currencyCode,
    required this.totalGrams,
    required this.totalTola,
    this.priceFormatted,
    this.resultText,
    this.isNepaliSystem = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'inputs': inputs,
      if (goldRate != null) 'gold_rate': goldRate,
      if (rateUnit != null) 'rate_unit': rateUnit,
      if (currencyCode != null) 'currency_code': currencyCode,
      'total_grams': totalGrams,
      'total_tola': totalTola,
      if (priceFormatted != null) 'price_formatted': priceFormatted,
      if (resultText != null) 'result_text': resultText,
      'is_nepali_system': isNepaliSystem,
    };
  }

  factory ConversionHistoryItem.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> rawInputs = Map<String, dynamic>.from(
      json['inputs'] as Map? ?? const {},
    );
    final Map<String, double> parsedInputs = rawInputs.map(
      (key, value) => MapEntry(key, (value as num).toDouble()),
    );

    return ConversionHistoryItem(
      id: json['id'] as String? ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'] as String) ?? DateTime.now()
          : DateTime.now(),
      inputs: parsedInputs,
      goldRate: (json['gold_rate'] as num?)?.toDouble(),
      rateUnit: json['rate_unit'] as String?,
      currencyCode: json['currency_code'] as String?,
      totalGrams: (json['total_grams'] as num?)?.toDouble() ?? 0.0,
      totalTola: (json['total_tola'] as num?)?.toDouble() ?? 0.0,
      priceFormatted: json['price_formatted'] as String?,
      resultText: json['result_text'] as String?,
      isNepaliSystem: json['is_nepali_system'] as bool? ?? false,
    );
  }
}
