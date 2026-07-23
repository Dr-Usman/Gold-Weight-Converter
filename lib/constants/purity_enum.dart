/// Common gold purity presets used for zakat calculations.
enum PurityEnum {
  karat24(24, '24K'),
  karat22(22, '22K'),
  karat21(21, '21K'),
  karat18(18, '18K'),
  custom(0, 'Custom');

  final int karat;
  final String label;

  const PurityEnum(this.karat, this.label);

  /// Fraction of pure gold (0–1) for a given karat value.
  static double fractionForKarat(int karat) {
    if (karat <= 0) return 0;
    return karat / 24.0;
  }

  double get fraction => fractionForKarat(karat);

  static PurityEnum fromName(String? value) {
    return PurityEnum.values.firstWhere(
      (e) => e.name == value,
      orElse: () => PurityEnum.karat22,
    );
  }
}
