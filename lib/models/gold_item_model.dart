import 'package:gold_weight_converter/constants/purity_enum.dart';
import 'package:gold_weight_converter/constants/weight_unit_enum.dart';

/// A single gold holding used for zakat calculation.
class GoldItemModel {
  final String id;
  final String? name;
  final double weight;
  final WeightUnitEnum unit;
  final PurityEnum purity;
  /// Used when [purity] is [PurityEnum.custom] (1–24).
  final int? customKarat;

  const GoldItemModel({
    required this.id,
    this.name,
    required this.weight,
    required this.unit,
    required this.purity,
    this.customKarat,
  });

  /// Effective karat used for pure-gold math.
  int get effectiveKarat {
    if (purity == PurityEnum.custom) {
      final int karat = customKarat ?? 22;
      return karat.clamp(1, 24);
    }
    return purity.karat;
  }

  /// Trimmed name, or null when empty (UI supplies a localized fallback).
  String? get displayName {
    final String? trimmed = name?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    return trimmed;
  }

  GoldItemModel copyWith({
    String? id,
    String? name,
    double? weight,
    WeightUnitEnum? unit,
    PurityEnum? purity,
    int? customKarat,
    bool clearName = false,
    bool clearCustomKarat = false,
  }) {
    return GoldItemModel(
      id: id ?? this.id,
      name: clearName ? null : (name ?? this.name),
      weight: weight ?? this.weight,
      unit: unit ?? this.unit,
      purity: purity ?? this.purity,
      customKarat: clearCustomKarat ? null : (customKarat ?? this.customKarat),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'unit': unit.storageKey,
      'purity': purity.name,
      'customKarat': customKarat,
    };
  }

  factory GoldItemModel.fromJson(Map<String, dynamic> json) {
    return GoldItemModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String?,
      weight: (json['weight'] as num?)?.toDouble() ?? 0,
      unit: WeightUnitEnum.fromStorageKey(json['unit'] as String?),
      purity: PurityEnum.fromName(json['purity'] as String?),
      customKarat: (json['customKarat'] as num?)?.toInt(),
    );
  }
}
