// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Pushto Pashto (`ps`).
class AppLocalizationsPs extends AppLocalizations {
  AppLocalizationsPs([String locale = 'ps']) : super(locale);

  @override
  String get appTitle => 'د سونې وزن بدلونکی';

  @override
  String get validationValidNumber => 'براہ کرم یو درست عدد دخل کړئ';

  @override
  String get validationPositiveNumber => 'براہ کرم یو مثبت عدد دخل کړئ';

  @override
  String get tolaLabel => 'تولہ';

  @override
  String get tolaInfo => '1 تولہ = 11.66 ګرام = 12 ماشہ = 16 آنہ = 96 رتی';

  @override
  String get tolaHint => 'د بیلګې د لپاره 2.5';

  @override
  String get tolaSemanticLabel => 'تولہ وزن دخل کوونکی ځای';

  @override
  String get mashaLabel => 'ماشہ';

  @override
  String get mashaInfo => '1 ماشہ = 0.972 ګرام = 1.333 آنہ = 8 رتی';

  @override
  String get mashaHint => 'د بیلګې د لپاره 12.5';

  @override
  String get mashaSemanticLabel => 'ماشہ وزن دخل کوونکی ځای';

  @override
  String get anaLabel => 'آنہ';

  @override
  String get anaInfo => '1 آنہ = 0.72875 ګرام = 6 رتی';

  @override
  String get anaHint => 'د بیلګې د لپاره 16.25';

  @override
  String get anaSemanticLabel => 'آنہ وزن دخل کوونکی ځای';

  @override
  String get rattiLabel => 'رتی';

  @override
  String get rattiInfo => '1 رتی = 0.1215 ګرام';

  @override
  String get rattiHint => 'د بیلګې د لپاره 96.75';

  @override
  String get rattiSemanticLabel => 'رتی وزن دخل کوونکی ځای';

  @override
  String get gramLabel => 'ګرام';

  @override
  String get gramInfo => 'مستقیم ګرام دخل کړئ';

  @override
  String get gramHint => 'د بیلګې د لپاره 11.66';

  @override
  String get gramSemanticLabel => 'ګرام وزن دخل کوونکی ځای';

  @override
  String get goldRateLabel => 'د سونې نرخ';

  @override
  String get goldRateInfo => 'اوسنی بازار نرخ فی واحد';

  @override
  String get goldRateHint => 'د بیلګې د لپاره 150,000';

  @override
  String get goldRateSemanticLabel => 'د سونې نرخ دخل کوونکی ځای';

  @override
  String get calculateButton => 'حساب کړئ';

  @override
  String get calculateSemanticLabel => 'د سونې وزن بدلون حساب کړئ';

  @override
  String get clearAllButton => 'ټول پاک کړئ';

  @override
  String get clearAllSemanticLabel => 'ټول دخل کوونکی ځایونه پاک کړئ';

  @override
  String get conversionDetails => 'د بدلون جزئیات';

  @override
  String tolaConversion(String value, String factor, String result) {
    return 'تولہ: $value × $factor = $result ګرام';
  }

  @override
  String mashaConversion(String value, String factor, String result) {
    return 'ماشہ: $value × $factor = $result ګرام';
  }

  @override
  String anaConversion(String value, String factor, String result) {
    return 'آنہ: $value × $factor = $result ګرام';
  }

  @override
  String rattiConversion(String value, String factor, String result) {
    return 'رتی: $value × $factor = $result ګرام';
  }

  @override
  String gramConversion(String value) {
    return 'ګرام: $value ګرام';
  }

  @override
  String totalWeight(String value) {
    return 'ټول وزن: $value ګرام';
  }

  @override
  String get convertedTo => 'بدل شوی:';

  @override
  String tolaResult(String value) {
    return 'تولہ: $value';
  }

  @override
  String mashaResult(String value) {
    return 'ماشہ: $value';
  }

  @override
  String anaResult(String value) {
    return 'آنہ: $value';
  }

  @override
  String rattiResult(String value) {
    return 'رتی: $value';
  }

  @override
  String goldPrice(String price) {
    return 'د سونې قیمت: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(نرخ: $rate فی $unit)';
  }

  @override
  String get unitTola => 'تولہ';

  @override
  String get unitTenGram => '10 ګرام';

  @override
  String get unitOneGram => '1 ګرام';

  @override
  String enterValueHint(String label) {
    return '$label ارزښت دخل کړئ';
  }

  @override
  String inputFieldSemantic(String label) {
    return '$label دخل کوونکی ځای';
  }

  @override
  String unitSelectorSemantic(String label) {
    return '$label واحد انتخابونکی';
  }

  @override
  String get converterTabLabel => 'بدلونکی';

  @override
  String get settingsTabLabel => 'ترتیبات';

  @override
  String get settingsTitle => 'ترتیبات';

  @override
  String get settingsThemeLabel => 'موضوع';

  @override
  String get themeLight => 'روښنه';

  @override
  String get themeDark => 'تیاره';

  @override
  String get darkModeLabel => 'تیاره موڈ';

  @override
  String get darkModeSubtitle => 'د تیاره او روښنې موضوع تر مینځ بدل کړئ';

  @override
  String get themeSystem => 'سیسٹم';

  @override
  String get settingsLanguageLabel => 'ژبه';

  @override
  String get languageSelectionPrompt => 'براہ کرم خپل ژبه انتخاب کړئ';

  @override
  String get languageEnglish => 'انګلیسی';

  @override
  String get languageUrdu => 'اردو';

  @override
  String get languageArabic => 'عربی';

  @override
  String get languageHindi => 'هندی';

  @override
  String get languageTurkish => 'ترکی';

  @override
  String get languageNote => 'نور ژبې ژر راتلونکی دی';

  @override
  String get settingsAboutLabel => 'په اړه';

  @override
  String get aboutVersion => 'نسخه';

  @override
  String get aboutDescription =>
      'د سونې وزن بدلونکی مختلف دودیز سونې وزن واحدونو او ګرام تر مینځ بدلون لپاره یو ساده او موثر وسیله ده.';

  @override
  String get unknownLabel => 'نامعلوم';
}
