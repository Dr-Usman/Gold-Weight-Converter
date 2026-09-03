import 'package:intl/intl.dart';

class AppConstants {
  static const double tolaToGram = 11.66; // 1 tola = 11.66 grams
  static const double lalToGram =
      0.1166; // 1 lal = 0.1166 grams (100 lal = 1 tola)
  static const double mashaToGram = 0.972; // 1 masha = 0.972 grams
  static const double anaToGram = 0.72875; // 1 ana = 0.72875 grams (6.25 lal)
  static const double rattiToGram = 0.1215; // 1 ratti = 0.1215 grams

  static const String privacyPolicyUrl =
      'https://dr-usman.github.io/Gold-Weight-Converter/privacy-policy.html';
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.avenzor.gold_weight_converter';
  static const String developerPlayStoreUrl =
      'https://play.google.com/store/apps/dev?id=5809108425817759974';

  static final NumberFormat thousandNumberFormat = NumberFormat('#,##0.####');
}
