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

  @override
  String get zakatMenuLabel => 'سونے کی زکوٰۃ';

  @override
  String get zakatScreenTitle => 'سونے کی زکوٰۃ';

  @override
  String get zakatDisclaimer =>
      'صرف سونے کی اشیاء کے لیے مددگار — مکمل زکوٰۃ کا حساب یا فتویٰ نہیں۔ دیگر اثاثے اور نصاب آپ کی ذمہ داری ہیں؛ مقامی عالم سے رجوع کریں۔';

  @override
  String get zakatRateInfo => '24K / خالص سونے کی مارکیٹ شرح فی یونٹ';

  @override
  String get zakatItemsTitle => 'آپ کی سونے کی اشیاء';

  @override
  String get zakatAddItem => 'آئٹم شامل کریں';

  @override
  String get zakatEditItem => 'آئٹم میں ترمیم';

  @override
  String get zakatEmptyItems =>
      'ابھی کوئی سونے کی شے نہیں۔ زکوٰۃ کے لیے زیورات یا بار شامل کریں۔';

  @override
  String get zakatItemNameLabel => 'نام (اختیاری)';

  @override
  String get zakatItemNameHint => 'مثلاً شادی کی انگوٹھی';

  @override
  String get zakatWeightLabel => 'وزن';

  @override
  String get zakatWeightHint => 'مثلاً 10';

  @override
  String get zakatWeightUnitLabel => 'یونٹ';

  @override
  String get zakatPurityLabel => 'خالصیت';

  @override
  String get zakatCustomKaratLabel => 'حسبِ ضرورت قیراط (1–24)';

  @override
  String get zakatCustomKaratHint => 'مثلاً 20';

  @override
  String get zakatPurity24k => '24K (خالص)';

  @override
  String get zakatPurity22k => '22K';

  @override
  String get zakatPurity21k => '21K';

  @override
  String get zakatPurity18k => '18K';

  @override
  String get zakatPurityCustom => 'حسبِ ضرورت';

  @override
  String get zakatSaveItem => 'محفوظ کریں';

  @override
  String get zakatDeleteItem => 'حذف کریں';

  @override
  String get zakatDeleteConfirmTitle => 'سونے کی شے حذف کریں؟';

  @override
  String zakatDeleteConfirmMessage(String name) {
    return 'اس سے آپ کی زکوٰۃ فہرست سے \"$name\" ہٹ جائے گی۔';
  }

  @override
  String get zakatCancel => 'منسوخ';

  @override
  String get zakatUntitledItem => 'سونے کی شے';

  @override
  String get zakatSummaryTitle => 'زکوٰۃ کا خلاصہ';

  @override
  String get zakatTotalPureGold => 'کل خالص سونا';

  @override
  String zakatPureGoldValue(String grams, String tola) {
    return '$grams گرام ($tola تولہ)';
  }

  @override
  String get zakatTotalValue => 'تخمینی قیمت';

  @override
  String get zakatDueLabel => 'ان اشیاء پر زکوٰۃ (2.5%)';

  @override
  String get zakatEnterRatePrompt =>
      'قیمت اور زکوٰۃ کے لیے سونے کی شرح درج کریں';

  @override
  String get zakatCalculateButton => 'زکوٰۃ حساب کریں';

  @override
  String zakatItemDetail(String weight, String unit, String purity) {
    return '$weight $unit · $purity';
  }

  @override
  String get zakatValidationWeight => 'صفر سے زیادہ وزن درج کریں';

  @override
  String get zakatValidationKarat => '1 سے 24 کے درمیان قیراط درج کریں';
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

  @override
  String get zakatMenuLabel => 'Sone ki Zakat';

  @override
  String get zakatScreenTitle => 'Sone ki Zakat';

  @override
  String get zakatDisclaimer =>
      'Sirf sone ki ashyā ke liye madadgār — mukammal zakat ka hisāb ya fatwa nahi. Digar asāsē aur nisab āp ki zimmedāri hain; maqāmi ālim se mashwara karein.';

  @override
  String get zakatRateInfo => '24K / khālis sone ki market rate fi unit';

  @override
  String get zakatItemsTitle => 'Āp ki sone ki ashyā';

  @override
  String get zakatAddItem => 'Item shāmil karein';

  @override
  String get zakatEditItem => 'Item edit karein';

  @override
  String get zakatEmptyItems =>
      'Abhi koi sone ki shai nahi. Zakat ke liye zewarāt ya bar shāmil karein.';

  @override
  String get zakatItemNameLabel => 'Naam (ikhtiyāri)';

  @override
  String get zakatItemNameHint => 'maslan shādi ki angūthi';

  @override
  String get zakatWeightLabel => 'Wazan';

  @override
  String get zakatWeightHint => 'maslan 10';

  @override
  String get zakatWeightUnitLabel => 'Unit';

  @override
  String get zakatPurityLabel => 'Khālisiyat';

  @override
  String get zakatCustomKaratLabel => 'Custom qirāt (1–24)';

  @override
  String get zakatCustomKaratHint => 'maslan 20';

  @override
  String get zakatPurity24k => '24K (khālis)';

  @override
  String get zakatPurity22k => '22K';

  @override
  String get zakatPurity21k => '21K';

  @override
  String get zakatPurity18k => '18K';

  @override
  String get zakatPurityCustom => 'Custom';

  @override
  String get zakatSaveItem => 'Mehfooz karein';

  @override
  String get zakatDeleteItem => 'Delete';

  @override
  String get zakatDeleteConfirmTitle => 'Sone ki shai delete karein?';

  @override
  String zakatDeleteConfirmMessage(String name) {
    return 'Is se āp ki zakat list se \"$name\" hat jāegi.';
  }

  @override
  String get zakatCancel => 'Cancel';

  @override
  String get zakatUntitledItem => 'Sone ki shai';

  @override
  String get zakatSummaryTitle => 'Zakat ka khulāsa';

  @override
  String get zakatTotalPureGold => 'Kul khālis sona';

  @override
  String zakatPureGoldValue(String grams, String tola) {
    return '$grams gram ($tola tola)';
  }

  @override
  String get zakatTotalValue => 'Takhmini qeemat';

  @override
  String get zakatDueLabel => 'In ashyā par zakat (2.5%)';

  @override
  String get zakatEnterRatePrompt =>
      'Qeemat aur zakat ke liye sone ki rate darj karein';

  @override
  String get zakatCalculateButton => 'Zakat hisāb karein';

  @override
  String zakatItemDetail(String weight, String unit, String purity) {
    return '$weight $unit · $purity';
  }

  @override
  String get zakatValidationWeight => 'Sifr se zyāda wazan darj karein';

  @override
  String get zakatValidationKarat => '1 se 24 ke darmiyān qirāt darj karein';
}
