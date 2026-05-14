// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tavringer Romani (`rmu`).
class AppLocalizationsRmu extends AppLocalizations {
  AppLocalizationsRmu([String locale = 'rmu']) : super(locale);

  @override
  String get appTitle => 'Soney Ka Wazan Tabdeel Karne Wala';

  @override
  String get validationValidNumber => 'Meherbani se ek sahi number darj Karen';

  @override
  String get validationPositiveNumber =>
      'Meherbani se ek mithbaatt number darj Karen';

  @override
  String get tolaLabel => 'Tola';

  @override
  String get tolaInfo => '1 Tola = 11.66 gram = 12 Masha = 16 Ana = 96 Ratti';

  @override
  String get tolaHint => 'Masaal k tor par 2.5';

  @override
  String get tolaSemanticLabel => 'Tola wazan darj karne wala field';

  @override
  String get mashaLabel => 'Masha';

  @override
  String get mashaInfo => '1 Masha = 0.972 gram = 1.333 Ana = 8 Ratti';

  @override
  String get mashaHint => 'Masaal k tor par 12.5';

  @override
  String get mashaSemanticLabel => 'Masha wazan darj karne wala field';

  @override
  String get anaLabel => 'Ana';

  @override
  String get anaInfo => '1 Ana = 0.72875 gram = 6 Ratti';

  @override
  String get anaHint => 'Masaal k tor par 16.25';

  @override
  String get anaSemanticLabel => 'Ana wazan darj karne wala field';

  @override
  String get rattiLabel => 'Ratti';

  @override
  String get rattiInfo => '1 Ratti = 0.1215 gram';

  @override
  String get rattiHint => 'Masaal k tor par 96.75';

  @override
  String get rattiSemanticLabel => 'Ratti wazan darj karne wala field';

  @override
  String get gramLabel => 'Gram';

  @override
  String get gramInfo => 'Buraah raast gram darj Karen';

  @override
  String get gramHint => 'Masaal k tor par 11.66';

  @override
  String get gramSemanticLabel => 'Gram wazan darj karne wala field';

  @override
  String get goldRateLabel => 'Soney Ki Shurah';

  @override
  String get goldRateInfo => 'Mojoda market shurah fai unit';

  @override
  String get goldRateHint => 'Masaal k tor par 150,000';

  @override
  String get goldRateSemanticLabel => 'Soney ki shurah darj karne wala field';

  @override
  String get calculateButton => 'Hisaab Lagain';

  @override
  String get calculateSemanticLabel =>
      'Soney k wazan ki tabdeeli ka hisaab lagain';

  @override
  String get clearAllButton => 'Sab Saaf Karen';

  @override
  String get clearAllSemanticLabel => 'Sab darj karne wale field saaf Karen';

  @override
  String get conversionDetails => 'Tabdeeli Ki Tafseelat';

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
    return 'Kul Wazan: $value gram';
  }

  @override
  String get convertedTo => 'Tabdeel Kiya Gaya:';

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
    return 'Soney Ki Qeemat: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(Shurah: $rate fai $unit)';
  }

  @override
  String get unitTola => 'Tola';

  @override
  String get unitTenGram => '10 Gram';

  @override
  String get unitOneGram => '1 Gram';

  @override
  String enterValueHint(String label) {
    return '$label ki qeemat darj Karen';
  }

  @override
  String inputFieldSemantic(String label) {
    return '$label darj karne wala field';
  }

  @override
  String unitSelectorSemantic(String label) {
    return '$label unit selector';
  }

  @override
  String get converterTabLabel => 'Tabdeel Karne Wala';

  @override
  String get settingsTabLabel => 'Tartibaat';

  @override
  String get settingsTitle => 'Tartibaat';

  @override
  String get settingsThemeLabel => 'Theme';

  @override
  String get themeLight => 'Ujala';

  @override
  String get themeDark => 'Tera';

  @override
  String get darkModeLabel => 'Tera Mode';

  @override
  String get darkModeSubtitle => 'Tera aur ujala theme k driyan tabdeeli Karen';

  @override
  String get themeSystem => 'Nizam';

  @override
  String get settingsLanguageLabel => 'Zuban';

  @override
  String get languageSelectionPrompt =>
      'Meherbani se apni zuban munktakhib Karen';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageUrdu => 'Urdu';

  @override
  String get languageArabic => 'Arabic';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languageTurkish => 'Turkish';

  @override
  String get languageNote => 'Aur zubanen jald aane wali hain';

  @override
  String get settingsAboutLabel => 'Mutallaq';

  @override
  String get aboutVersion => 'Version';

  @override
  String get aboutDescription =>
      'Soney ka wazan tabdeel karne wala rothai soney ki wazan ki units aur gram k driyan tabdeeli k liye ek saada aur moassir tool hai';

  @override
  String get unknownLabel => 'Maloom Nahi';
}
