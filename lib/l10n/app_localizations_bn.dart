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

  @override
  String get zakatMenuLabel => 'স্বর্ণের যাকাত';

  @override
  String get zakatScreenTitle => 'স্বর্ণের যাকাত';

  @override
  String get zakatDisclaimer =>
      'শুধু স্বর্ণের জিনিসের জন্য সহায়ক — পূর্ণ যাকাত হিসাব বা ধর্মীয় ফতোয়া নয়। অন্য সম্পদ ও নিসাব আপনার দায়িত্ব; স্থানীয় আলেমের পরামর্শ নিন।';

  @override
  String get zakatRateInfo =>
      '২৪ ক্যারেট / বিশুদ্ধ স্বর্ণের বাজারদর প্রতি এককে';

  @override
  String get zakatItemsTitle => 'আপনার স্বর্ণের জিনিস';

  @override
  String get zakatAddItem => 'জিনিস যোগ করুন';

  @override
  String get zakatEditItem => 'জিনিস সম্পাদনা';

  @override
  String get zakatEmptyItems =>
      'এখনো কোনো স্বর্ণের জিনিস নেই। যাকাত হিসাবের জন্য গহনা বা বার যোগ করুন।';

  @override
  String get zakatItemNameLabel => 'নাম (ঐচ্ছিক)';

  @override
  String get zakatItemNameHint => 'যেমন বিয়ের আংটি';

  @override
  String get zakatWeightLabel => 'ওজন';

  @override
  String get zakatWeightHint => 'যেমন 10';

  @override
  String get zakatWeightUnitLabel => 'একক';

  @override
  String get zakatPurityLabel => 'বিশুদ্ধতা';

  @override
  String get zakatCustomKaratLabel => 'কাস্টম ক্যারেট (1–24)';

  @override
  String get zakatCustomKaratHint => 'যেমন 20';

  @override
  String get zakatPurity24k => '২৪K (বিশুদ্ধ)';

  @override
  String get zakatPurity22k => '২২K';

  @override
  String get zakatPurity21k => '২১K';

  @override
  String get zakatPurity18k => '১৮K';

  @override
  String get zakatPurityCustom => 'কাস্টম';

  @override
  String get zakatSaveItem => 'সংরক্ষণ';

  @override
  String get zakatDeleteItem => 'মুছুন';

  @override
  String get zakatDeleteConfirmTitle => 'স্বর্ণের জিনিস মুছবেন?';

  @override
  String zakatDeleteConfirmMessage(String name) {
    return 'এতে আপনার যাকাত তালিকা থেকে \"$name\" সরানো হবে।';
  }

  @override
  String get zakatCancel => 'বাতিল';

  @override
  String get zakatUntitledItem => 'স্বর্ণের জিনিস';

  @override
  String get zakatSummaryTitle => 'যাকাত সারাংশ';

  @override
  String get zakatTotalPureGold => 'মোট বিশুদ্ধ স্বর্ণ';

  @override
  String zakatPureGoldValue(String grams, String tola) {
    return '$grams গ্রাম ($tola তোলা)';
  }

  @override
  String get zakatTotalValue => 'আনুমানিক মূল্য';

  @override
  String get zakatDueLabel => 'এই জিনিসগুলোর যাকাত (২.৫%)';

  @override
  String get zakatEnterRatePrompt =>
      'মূল্য ও যাকাত অনুমান করতে স্বর্ণের দর লিখুন';

  @override
  String get zakatCalculateButton => 'যাকাত হিসাব করুন';

  @override
  String zakatItemDetail(String weight, String unit, String purity) {
    return '$weight $unit · $purity';
  }

  @override
  String get zakatValidationWeight => 'শূন্যের বেশি ওজন লিখুন';

  @override
  String get zakatValidationKarat => '১ থেকে ২৪ এর মধ্যে ক্যারেট লিখুন';
}
