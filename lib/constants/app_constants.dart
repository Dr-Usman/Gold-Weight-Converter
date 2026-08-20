import 'package:intl/intl.dart';

class AppConstants {
  static const double tolaToGram = 11.66; // 1 tola = 11.66 grams
  static const double mashaToGram = 0.972; // 1 masha = 0.972 grams
  static const double anaToGram = 0.72875; // 1 ana = 0.72875 grams
  static const double rattiToGram = 0.1215; // 1 ratti = 0.1215 grams

  static const String privacyPolicyUrl =
      'https://dr-usman.github.io/Gold-Weight-Converter/privacy-policy.html';
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.avenzor.gold_weight_converter';

  static final NumberFormat thousandNumberFormat = NumberFormat('#,##0.####');
}
