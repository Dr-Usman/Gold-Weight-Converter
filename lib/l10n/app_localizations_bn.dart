// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'সোনার ওজন রূপান্তরকারী';

  @override
  String get validationValidNumber => 'অনুগ্রহ করে একটি বৈধ সংখ্যা প্রবেশ করুন';

  @override
  String get validationPositiveNumber =>
      'অনুগ্রহ করে একটি ইতিবাচক সংখ্যা প্রবেশ করুন';

  @override
  String get tolaLabel => 'তোলা';

  @override
  String get tolaInfo => '1 তোলা = 11.66 গ্রাম = 12 মাশা = 16 আনা = 96 রত্তি';

  @override
  String get tolaHint => 'উদাহরণস্বরূপ 2.5';

  @override
  String get tolaSemanticLabel => 'তোলা ওজন ইনপুট ক্ষেত্র';

  @override
  String get mashaLabel => 'মাশা';

  @override
  String get mashaInfo => '1 মাশা = 0.972 গ্রাম = 1.333 আনা = 8 রত্তি';

  @override
  String get mashaHint => 'উদাহরণস্বরূপ 12.5';

  @override
  String get mashaSemanticLabel => 'মাশা ওজন ইনপুট ক্ষেত্র';

  @override
  String get anaLabel => 'আনা';

  @override
  String get anaInfo => '1 আনা = 0.72875 গ্রাম = 6 রত্তি';

  @override
  String get anaHint => 'উদাহরণস্বরূপ 16.25';

  @override
  String get anaSemanticLabel => 'আনা ওজন ইনপুট ক্ষেত্র';

  @override
  String get rattiLabel => 'রত্তি';

  @override
  String get rattiInfo => '1 রত্তি = 0.1215 গ্রাম';

  @override
  String get rattiHint => 'উদাহরণস্বরূপ 96.75';

  @override
  String get rattiSemanticLabel => 'রত্তি ওজন ইনপুট ক্ষেত্র';

  @override
  String get gramLabel => 'গ্রাম';

  @override
  String get gramInfo => 'সরাসরি গ্রাম প্রবেশ করুন';

  @override
  String get gramHint => 'উদাহরণস্বরূপ 11.66';

  @override
  String get gramSemanticLabel => 'গ্রাম ওজন ইনপুট ক্ষেত্র';

  @override
  String get goldRateLabel => 'সোনার হার';

  @override
  String get goldRateInfo => 'বর্তমান বাজার হার প্রতি ইউনিট';

  @override
  String get goldRateHint => 'উদাহরণস্বরূপ 150,000';

  @override
  String get goldRateSemanticLabel => 'সোনার হার ইনপুট ক্ষেত্র';

  @override
  String get calculateButton => 'হিসাব করুন';

  @override
  String get calculateSemanticLabel => 'সোনার ওজন রূপান্তর গণনা করুন';

  @override
  String get clearAllButton => 'সব সাফ করুন';

  @override
  String get clearAllSemanticLabel => 'সমস্ত ইনপুট ক্ষেত্র সাফ করুন';

  @override
  String get conversionDetails => 'রূপান্তর বিবরণ';

  @override
  String tolaConversion(String value, String factor, String result) {
    return 'তোলা: $value × $factor = $result গ্রাম';
  }

  @override
  String mashaConversion(String value, String factor, String result) {
    return 'মাশা: $value × $factor = $result গ্রাম';
  }

  @override
  String anaConversion(String value, String factor, String result) {
    return 'আনা: $value × $factor = $result গ্রাম';
  }

  @override
  String rattiConversion(String value, String factor, String result) {
    return 'রত্তি: $value × $factor = $result গ্রাম';
  }

  @override
  String gramConversion(String value) {
    return 'গ্রাম: $value গ্রাম';
  }

  @override
  String totalWeight(String value) {
    return 'মোট ওজন: $value গ্রাম';
  }

  @override
  String get convertedTo => 'এতে রূপান্তরিত:';

  @override
  String tolaResult(String value) {
    return 'তোলা: $value';
  }

  @override
  String mashaResult(String value) {
    return 'মাশা: $value';
  }

  @override
  String anaResult(String value) {
    return 'আনা: $value';
  }

  @override
  String rattiResult(String value) {
    return 'রত্তি: $value';
  }

  @override
  String goldPrice(String price) {
    return 'সোনার মূল্য: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(হার: $rate প্রতি $unit)';
  }

  @override
  String get unitTola => 'তোলা';

  @override
  String get unitTenGram => '10 গ্রাম';

  @override
  String get unitOneGram => '1 গ্রাম';

  @override
  String enterValueHint(String label) {
    return '$label মান প্রবেশ করুন';
  }

  @override
  String inputFieldSemantic(String label) {
    return '$label ইনপুট ক্ষেত্র';
  }

  @override
  String unitSelectorSemantic(String label) {
    return '$label ইউনিট নির্বাচক';
  }

  @override
  String get converterTabLabel => 'রূপান্তরকারী';

  @override
  String get settingsTabLabel => 'সেটিংস';

  @override
  String get settingsTitle => 'সেটিংস';

  @override
  String get settingsThemeLabel => 'থিম';

  @override
  String get themeLight => 'হালকা';

  @override
  String get themeDark => 'গাঢ়';

  @override
  String get darkModeLabel => 'ডার্ক মোড';

  @override
  String get darkModeSubtitle => 'গাঢ় এবং হালকা থিমের মধ্যে স্যুইচ করুন';

  @override
  String get themeSystem => 'সিস্টেম';

  @override
  String get settingsLanguageLabel => 'ভাষা';

  @override
  String get languageSelectionPrompt => 'অনুগ্রহ করে আপনার ভাষা নির্বাচন করুন';

  @override
  String get languageEnglish => 'ইংরেজি';

  @override
  String get languageUrdu => 'উর্দু';

  @override
  String get languageArabic => 'আরবি';

  @override
  String get languageHindi => 'হিন্দি';

  @override
  String get languageTurkish => 'তুর্কি';

  @override
  String get languageNote => 'আরও ভাষা শীঘ্রই আসছে';

  @override
  String get settingsAboutLabel => 'সম্পর্কে';

  @override
  String get aboutVersion => 'সংস্করণ';

  @override
  String get aboutDescription =>
      'সোনার ওজন রূপান্তরকারী বিভিন্ন ঐতিহ্যবাহী সোনার ওজন ইউনিট এবং গ্রামের মধ্যে রূপান্তরের জন্য একটি সহজ এবং দক্ষ সরঞ্জাম।';

  @override
  String get unknownLabel => 'অজানা';
}
