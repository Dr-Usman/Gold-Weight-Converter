// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'سونے کے وزن کا کنورٹر';

  @override
  String get validationValidNumber => 'براہ کرم ایک درست نمبر درج کریں';

  @override
  String get validationPositiveNumber => 'براہ کرم ایک مثبت نمبر درج کریں';

  @override
  String get tolaLabel => 'تولہ';

  @override
  String get tolaInfo => '1 تولہ = 11.66 گرام = 12 ماشہ = 16 آنہ = 96 رتی';

  @override
  String get tolaHint => 'مثال کے طور پر 2.5';

  @override
  String get tolaSemanticLabel => 'تولہ وزن درج کنے والا فیلڈ';

  @override
  String get mashaLabel => 'ماشہ';

  @override
  String get mashaInfo => '1 ماشہ = 0.972 گرام = 1.333 آنہ = 8 رتی';

  @override
  String get mashaHint => 'مثال کے طور پر 12.5';

  @override
  String get mashaSemanticLabel => 'ماشہ وزن درج کنے والا فیلڈ';

  @override
  String get anaLabel => 'آنہ';

  @override
  String get anaInfo => '1 آنہ = 0.72875 گرام = 6 رتی';

  @override
  String get anaHint => 'مثال کے طور پر 16.25';

  @override
  String get anaSemanticLabel => 'آنہ وزن درج کنے والا فیلڈ';

  @override
  String get rattiLabel => 'رتی';

  @override
  String get rattiInfo => '1 رتی = 0.1215 گرام';

  @override
  String get rattiHint => 'مثال کے طور پر 96.75';

  @override
  String get rattiSemanticLabel => 'رتی وزن درج کنے والا فیلڈ';

  @override
  String get gramLabel => 'گرام';

  @override
  String get gramInfo => 'براہ راست گرام درج کریں';

  @override
  String get gramHint => 'مثال کے طور پر 11.66';

  @override
  String get gramSemanticLabel => 'گرام وزن درج کنے والا فیلڈ';

  @override
  String get goldRateLabel => 'سونے کی شرح';

  @override
  String get goldRateInfo => 'موجودہ مارکیٹ شرح فی یونٹ';

  @override
  String get goldRateHint => 'مثال کے طور پر 150,000';

  @override
  String get goldRateSemanticLabel => 'سونے کی شرح درج کنے والا فیلڈ';

  @override
  String get calculateButton => 'حساب لگائیں';

  @override
  String get calculateSemanticLabel => 'سونے کے وزن کی تبدیلی کا حساب لگائیں';

  @override
  String get clearAllButton => 'تمام صاف کریں';

  @override
  String get clearAllSemanticLabel => 'تمام درج کنے والے فیلڈز صاف کریں';

  @override
  String get conversionDetails => 'تبدیلی کی تفصیلات';

  @override
  String tolaConversion(String value, String factor, String result) {
    return 'تولہ: $value × $factor = $result گرام';
  }

  @override
  String mashaConversion(String value, String factor, String result) {
    return 'ماشہ: $value × $factor = $result گرام';
  }

  @override
  String anaConversion(String value, String factor, String result) {
    return 'آنہ: $value × $factor = $result گرام';
  }

  @override
  String rattiConversion(String value, String factor, String result) {
    return 'رتی: $value × $factor = $result گرام';
  }

  @override
  String gramConversion(String value) {
    return 'گرام: $value گرام';
  }

  @override
  String totalWeight(String value) {
    return 'کل وزن: $value گرام';
  }

  @override
  String get convertedTo => 'تبدیل کیا گیا:';

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
    return 'سونے کی قیمت: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(شرح: $rate فی $unit)';
  }

  @override
  String get unitTola => 'تولہ';

  @override
  String get unitTenGram => '10 گرام';

  @override
  String get unitOneGram => '1 گرام';

  @override
  String enterValueHint(String label) {
    return '$label کی قدر درج کریں';
  }

  @override
  String inputFieldSemantic(String label) {
    return '$label درج کنے والا فیلڈ';
  }

  @override
  String unitSelectorSemantic(String label) {
    return '$label یونٹ سلیکٹر';
  }

  @override
  String get converterTabLabel => 'تبدیل کنی والا';

  @override
  String get settingsTabLabel => 'ترتیبات';

  @override
  String get settingsTitle => 'ترتیبات';

  @override
  String get settingsThemeLabel => 'تھیم';

  @override
  String get themeLight => 'روشن';

  @override
  String get themeDark => 'تاریک';

  @override
  String get darkModeLabel => 'تاریک موڈ';

  @override
  String get darkModeSubtitle => 'تاریک اور روشن تھیمز کے درمیان تبدیلی کریں';

  @override
  String get themeSystem => 'نظام';

  @override
  String get settingsLanguageLabel => 'زبان';

  @override
  String get languageSelectionPrompt => 'براہ کرم اپنی زبان منتخب کریں';

  @override
  String get languageEnglish => 'انگریزی';

  @override
  String get languageUrdu => 'اردو';

  @override
  String get languageArabic => 'عربی';

  @override
  String get languageHindi => 'ہندی';

  @override
  String get languageTurkish => 'ترکی';

  @override
  String get languageNote => 'مزید زبانیں جلد آنے والی ہیں';

  @override
  String get settingsAboutLabel => 'متعلقہ';

  @override
  String get aboutVersion => 'ورژن';

  @override
  String get aboutDescription =>
      'سونے کا وزن تبدیل کنے والا روایتی سونے کی وزن کی اکائیوں اور گرام کے درمیان تبدیلی کے لیے ایک سادہ اور موثر ٹول ہے۔';

  @override
  String get unknownLabel => 'نامعلوم';
}

/// The translations for Urdu, as used in Romania (`ur_RO`).
class AppLocalizationsUrRo extends AppLocalizationsUr {
  AppLocalizationsUrRo() : super('ur_RO');

  @override
  String get appTitle => 'Sone Ka Wazan Tabdeel Karne Wala';

  @override
  String get validationValidNumber => 'Meherbani se ek sahi number darj karen';

  @override
  String get validationPositiveNumber =>
      'Meherbani se ek musbat number darj karen';

  @override
  String get tolaLabel => 'Tola';

  @override
  String get tolaInfo => '1 Tola = 11.66 gram = 12 Masha = 16 Ana = 96 Ratti';

  @override
  String get tolaHint => 'Misal k tor par 2.5';

  @override
  String get tolaSemanticLabel => 'Tola wazan darj karne wala field';

  @override
  String get mashaLabel => 'Masha';

  @override
  String get mashaInfo => '1 Masha = 0.972 gram = 1.333 Ana = 8 Ratti';

  @override
  String get mashaHint => 'Misal k tor par 12.5';

  @override
  String get mashaSemanticLabel => 'Masha wazan darj karne wala field';

  @override
  String get anaLabel => 'Ana';

  @override
  String get anaInfo => '1 Ana = 0.72875 gram = 6 Ratti';

  @override
  String get anaHint => 'Misal k tor par 16.25';

  @override
  String get anaSemanticLabel => 'Ana wazan darj karne wala field';

  @override
  String get rattiLabel => 'Ratti';

  @override
  String get rattiInfo => '1 Ratti = 0.1215 gram';

  @override
  String get rattiHint => 'Misal k tor par 96.75';

  @override
  String get rattiSemanticLabel => 'Ratti wazan darj karne wala field';

  @override
  String get gramLabel => 'Gram';

  @override
  String get gramInfo => 'Barah-e-rast gram darj karen';

  @override
  String get gramHint => 'Misal k tor par 11.66';

  @override
  String get gramSemanticLabel => 'Gram wazan darj karne wala field';

  @override
  String get goldRateLabel => 'Sone Ki Sharah';

  @override
  String get goldRateInfo => 'Mojoda market sharah fi unit';

  @override
  String get goldRateHint => 'Misal k tor par 150,000';

  @override
  String get goldRateSemanticLabel => 'Sone ki sharah darj karne wala field';

  @override
  String get calculateButton => 'Hisaab Lagain';

  @override
  String get calculateSemanticLabel =>
      'Sone k wazan ki tabdeeli ka hisaab lagain';

  @override
  String get clearAllButton => 'Sab Saaf Karen';

  @override
  String get clearAllSemanticLabel => 'Sab darj karne wale fields saaf karen';

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
    return 'Sone Ki Qeemat: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(Sharah: $rate fi $unit)';
  }

  @override
  String get unitTola => 'Tola';

  @override
  String get unitTenGram => '10 Gram';

  @override
  String get unitOneGram => '1 Gram';

  @override
  String enterValueHint(String label) {
    return '$label ki qeemat darj karen';
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
  String get themeDark => 'Tareek';

  @override
  String get darkModeLabel => 'Dark Mode';

  @override
  String get darkModeSubtitle =>
      'Dark aur light theme k darmiyan tabdeeli karen';

  @override
  String get themeSystem => 'Nizam';

  @override
  String get settingsLanguageLabel => 'Zuban';

  @override
  String get languageSelectionPrompt =>
      'Meherbani se apni zuban muntakhib karen';

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
  String get languageNote => 'Mazeed zubanen jald aane wali hain';

  @override
  String get settingsAboutLabel => 'Mutallaq';

  @override
  String get aboutVersion => 'Version';

  @override
  String get aboutDescription =>
      'Sone ka wazan tabdeel karne wala app sone ki wazan ki units aur gram k darmiyan tabdeeli k liye ek saada aur moassir tool hai';

  @override
  String get unknownLabel => 'Na-maloom';
}
