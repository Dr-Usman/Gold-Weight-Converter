enum UnitEnum {
  tola('Tola'),
  tenGram('10 Gram'),
  oneGram('1 Gram');

  // Define a final field to hold the string value
  final String name;

  // Define a constant constructor
  const UnitEnum(this.name);

  static UnitEnum fromString(String? value) {
    return UnitEnum.values.firstWhere(
      (e) => e.name == value,
      orElse: () => UnitEnum.tola, // Default to tola if no match found
      // orElse: () => throw ArgumentError('Invalid unit: $value'),
    );
  }
}
