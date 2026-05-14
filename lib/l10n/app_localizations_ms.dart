// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appTitle => 'Penukar Berat Emas';

  @override
  String get validationValidNumber => 'Sila masukkan nombor yang sah';

  @override
  String get validationPositiveNumber => 'Sila masukkan nombor positif';

  @override
  String get tolaLabel => 'Tola';

  @override
  String get tolaInfo => '1 Tola = 11.66 gram = 12 Masha = 16 Ana = 96 Ratti';

  @override
  String get tolaHint => 'Contohnya 2.5';

  @override
  String get tolaSemanticLabel => 'Bidang input berat Tola';

  @override
  String get mashaLabel => 'Masha';

  @override
  String get mashaInfo => '1 Masha = 0.972 gram = 1.333 Ana = 8 Ratti';

  @override
  String get mashaHint => 'Contohnya 12.5';

  @override
  String get mashaSemanticLabel => 'Bidang input berat Masha';

  @override
  String get anaLabel => 'Ana';

  @override
  String get anaInfo => '1 Ana = 0.72875 gram = 6 Ratti';

  @override
  String get anaHint => 'Contohnya 16.25';

  @override
  String get anaSemanticLabel => 'Bidang input berat Ana';

  @override
  String get rattiLabel => 'Ratti';

  @override
  String get rattiInfo => '1 Ratti = 0.1215 gram';

  @override
  String get rattiHint => 'Contohnya 96.75';

  @override
  String get rattiSemanticLabel => 'Bidang input berat Ratti';

  @override
  String get gramLabel => 'Gram';

  @override
  String get gramInfo => 'Input gram secara langsung';

  @override
  String get gramHint => 'Contohnya 11.66';

  @override
  String get gramSemanticLabel => 'Bidang input berat Gram';

  @override
  String get goldRateLabel => 'Harga Emas';

  @override
  String get goldRateInfo => 'Harga pasaran semasa bagi setiap unit';

  @override
  String get goldRateHint => 'Contohnya 150,000';

  @override
  String get goldRateSemanticLabel => 'Bidang input harga emas';

  @override
  String get calculateButton => 'Kira';

  @override
  String get calculateSemanticLabel => 'Kira penukaran berat emas';

  @override
  String get clearAllButton => 'Padam Semua';

  @override
  String get clearAllSemanticLabel => 'Padamkan semua bidang input';

  @override
  String get conversionDetails => 'Butiran Penukaran';

  @override
  String tolaConversion(String value, String factor, String result) {
    return 'Tola: $value × $factor = $result gram';
  }

  @override
  String mashaConversion(String value, String factor, String result) {
    return 'Masha: $value × $factor = $result gram';
  }

  @override
  String anaConversion(String value, String factor, String result) {
    return 'Ana: $value × $factor = $result gram';
  }

  @override
  String rattiConversion(String value, String factor, String result) {
    return 'Ratti: $value × $factor = $result gram';
  }

  @override
  String gramConversion(String value) {
    return 'Gram: $value gram';
  }

  @override
  String totalWeight(String value) {
    return 'Jumlah Berat: $value gram';
  }

  @override
  String get convertedTo => 'Ditukar kepada:';

  @override
  String tolaResult(String value) {
    return 'Tola: $value';
  }

  @override
  String mashaResult(String value) {
    return 'Masha: $value';
  }

  @override
  String anaResult(String value) {
    return 'Ana: $value';
  }

  @override
  String rattiResult(String value) {
    return 'Ratti: $value';
  }

  @override
  String goldPrice(String price) {
    return 'Harga Emas: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(Harga: $rate bagi $unit)';
  }

  @override
  String get unitTola => 'Tola';

  @override
  String get unitTenGram => '10 Gram';

  @override
  String get unitOneGram => '1 Gram';

  @override
  String enterValueHint(String label) {
    return 'Masukkan nilai $label';
  }

  @override
  String inputFieldSemantic(String label) {
    return 'Bidang input $label';
  }

  @override
  String unitSelectorSemantic(String label) {
    return 'Pemilih unit $label';
  }

  @override
  String get converterTabLabel => 'Penukar';

  @override
  String get settingsTabLabel => 'Tetapan';

  @override
  String get settingsTitle => 'Tetapan';

  @override
  String get settingsThemeLabel => 'Tema';

  @override
  String get themeLight => 'Terang';

  @override
  String get themeDark => 'Gelap';

  @override
  String get darkModeLabel => 'Mod Gelap';

  @override
  String get darkModeSubtitle => 'Tukar antara tema gelap dan terang';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get settingsLanguageLabel => 'Bahasa';

  @override
  String get languageSelectionPrompt => 'Sila pilih bahasa anda';

  @override
  String get languageEnglish => 'Bahasa Inggeris';

  @override
  String get languageUrdu => 'Urdu';

  @override
  String get languageArabic => 'Arab';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languageTurkish => 'Turki';

  @override
  String get languageNote => 'Lebih banyak bahasa akan datang';

  @override
  String get settingsAboutLabel => 'Tentang';

  @override
  String get aboutVersion => 'Versi';

  @override
  String get aboutDescription =>
      'Penukar Berat Emas adalah alat yang mudah dan cekap untuk menukar antara pelbagai unit berat emas tradisional dan gram.';

  @override
  String get unknownLabel => 'Tidak diketahui';
}
