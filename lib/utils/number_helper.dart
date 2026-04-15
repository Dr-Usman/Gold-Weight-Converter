import 'package:gold_weight_converter/constants/app_constants.dart';

class NumberHelper {
  /// Formats a number with thousand separators
  static String formatNumber(double number) {
    return AppConstants.thousandNumberFormat.format(number);
  }

  /// Removes formatting and returns clean number string
  static String cleanNumber(String formattedNumber) {
    return formattedNumber.replaceAll(',', '');
  }

  /// Parses a formatted number string to double
  static double? parseFormattedNumber(String formattedNumber) {
    String clean = cleanNumber(formattedNumber);
    return double.tryParse(clean);
  }
}
