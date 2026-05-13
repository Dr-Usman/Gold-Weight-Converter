// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Gold Weight Converter';

  @override
  String get validationValidNumber => 'Please enter a valid number';

  @override
  String get validationPositiveNumber => 'Please enter a positive number';

  @override
  String get tolaLabel => 'Tola';

  @override
  String get tolaInfo => '1 Tola = 11.66 grams = 12 Masha = 16 Ana = 96 Ratti';

  @override
  String get tolaHint => 'e.g. 2.5';

  @override
  String get tolaSemanticLabel => 'Tola weight input field';

  @override
  String get mashaLabel => 'Masha';

  @override
  String get mashaInfo => '1 Masha = 0.972 grams = 1.333 Ana = 8 Ratti';

  @override
  String get mashaHint => 'e.g. 12.5';

  @override
  String get mashaSemanticLabel => 'Masha weight input field';

  @override
  String get anaLabel => 'Ana';

  @override
  String get anaInfo => '1 Ana = 0.72875 grams = 6 Ratti';

  @override
  String get anaHint => 'e.g. 16.25';

  @override
  String get anaSemanticLabel => 'Ana weight input field';

  @override
  String get rattiLabel => 'Ratti';

  @override
  String get rattiInfo => '1 Ratti = 0.1215 grams';

  @override
  String get rattiHint => 'e.g. 96.75';

  @override
  String get rattiSemanticLabel => 'Ratti weight input field';

  @override
  String get gramLabel => 'Gram';

  @override
  String get gramInfo => 'Direct gram input';

  @override
  String get gramHint => 'e.g. 11.66';

  @override
  String get gramSemanticLabel => 'Gram weight input field';

  @override
  String get goldRateLabel => 'Gold Rate';

  @override
  String get goldRateInfo => 'Current market rate per unit';

  @override
  String get goldRateHint => 'e.g. 150,000';

  @override
  String get goldRateSemanticLabel => 'Gold rate input field';

  @override
  String get calculateButton => 'Calculate';

  @override
  String get calculateSemanticLabel => 'Calculate gold weight conversion';

  @override
  String get clearAllButton => 'Clear All';

  @override
  String get clearAllSemanticLabel => 'Clear all input fields';

  @override
  String get conversionDetails => 'Conversion Details';

  @override
  String tolaConversion(String value, String factor, String result) {
    return 'Tola: $value × $factor = $result grams';
  }

  @override
  String mashaConversion(String value, String factor, String result) {
    return 'Masha: $value × $factor = $result grams';
  }

  @override
  String anaConversion(String value, String factor, String result) {
    return 'Ana: $value × $factor = $result grams';
  }

  @override
  String rattiConversion(String value, String factor, String result) {
    return 'Ratti: $value × $factor = $result grams';
  }

  @override
  String gramConversion(String value) {
    return 'Gram: $value grams';
  }

  @override
  String totalWeight(String value) {
    return 'Total Weight: $value grams';
  }

  @override
  String get convertedTo => 'Converted to:';

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
    return 'Gold Price: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(Rate: $rate per $unit)';
  }

  @override
  String get unitTola => 'Tola';

  @override
  String get unitTenGram => '10 Gram';

  @override
  String get unitOneGram => '1 Gram';

  @override
  String enterValueHint(String label) {
    return 'Enter $label value';
  }

  @override
  String inputFieldSemantic(String label) {
    return '$label input field';
  }

  @override
  String unitSelectorSemantic(String label) {
    return '$label unit selector';
  }

  @override
  String get converterTabLabel => 'Converter';

  @override
  String get settingsTabLabel => 'Settings';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsThemeLabel => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get darkModeLabel => 'Dark Mode';

  @override
  String get darkModeSubtitle => 'Switch between dark and light themes';

  @override
  String get themeSystem => 'System';

  @override
  String get settingsLanguageLabel => 'Language';

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
  String get languageNote => 'More languages coming soon';

  @override
  String get settingsAboutLabel => 'About';

  @override
  String get aboutVersion => 'Version';

  @override
  String get aboutDescription =>
      'Gold Weight Converter is a simple and efficient tool for converting between various traditional gold weight units and grams.';

  @override
  String get unknownLabel => 'Unknown';
}
