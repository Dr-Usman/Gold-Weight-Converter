// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'مبدل وزن طلا';

  @override
  String get validationValidNumber => 'لطفاً یک عدد معتبر وارد کنید';

  @override
  String get validationPositiveNumber => 'لطفاً یک عدد مثبت وارد کنید';

  @override
  String get tolaLabel => 'تولہ';

  @override
  String get tolaInfo => '1 تولہ = 11.66 گرم = 12 ماشہ = 16 آنہ = 96 رتی';

  @override
  String get tolaHint => 'مثلاً 2.5';

  @override
  String get tolaSemanticLabel => 'فیلد ورودی وزن تولہ';

  @override
  String get mashaLabel => 'ماشہ';

  @override
  String get mashaInfo => '1 ماشہ = 0.972 گرم = 1.333 آنہ = 8 رتی';

  @override
  String get mashaHint => 'مثلاً 12.5';

  @override
  String get mashaSemanticLabel => 'فیلد ورودی وزن ماشہ';

  @override
  String get anaLabel => 'آنہ';

  @override
  String get anaInfo => '1 آنہ = 0.72875 گرم = 6 رتی';

  @override
  String get anaHint => 'مثلاً 16.25';

  @override
  String get anaSemanticLabel => 'فیلد ورودی وزن آنہ';

  @override
  String get rattiLabel => 'رتی';

  @override
  String get rattiInfo => '1 رتی = 0.1215 گرم';

  @override
  String get rattiHint => 'مثلاً 96.75';

  @override
  String get rattiSemanticLabel => 'فیلد ورودی وزن رتی';

  @override
  String get gramLabel => 'گرم';

  @override
  String get gramInfo => 'گرم مستقیم وارد کنید';

  @override
  String get gramHint => 'مثلاً 11.66';

  @override
  String get gramSemanticLabel => 'فیلد ورودی وزن گرم';

  @override
  String get goldRateLabel => 'نرخ طلا';

  @override
  String get goldRateInfo => 'نرخ بازار فعلی در هر واحد';

  @override
  String get goldRateHint => 'مثلاً 150,000';

  @override
  String get goldRateSemanticLabel => 'فیلد ورودی نرخ طلا';

  @override
  String get calculateButton => 'محاسبه کنید';

  @override
  String get calculateSemanticLabel => 'تبدیل وزن طلا را محاسبه کنید';

  @override
  String get clearAllButton => 'پاک کردن همه';

  @override
  String get clearAllSemanticLabel => 'تمام فیلدهای ورودی را پاک کنید';

  @override
  String get conversionDetails => 'جزئیات تبدیلی';

  @override
  String tolaConversion(String value, String factor, String result) {
    return 'تولہ: $value × $factor = $result گرم';
  }

  @override
  String mashaConversion(String value, String factor, String result) {
    return 'ماشہ: $value × $factor = $result گرم';
  }

  @override
  String anaConversion(String value, String factor, String result) {
    return 'آنہ: $value × $factor = $result گرم';
  }

  @override
  String rattiConversion(String value, String factor, String result) {
    return 'رتی: $value × $factor = $result گرم';
  }

  @override
  String gramConversion(String value) {
    return 'گرم: $value گرم';
  }

  @override
  String totalWeight(String value) {
    return 'وزن کل: $value گرم';
  }

  @override
  String get convertedTo => 'تبدیل شده به:';

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
    return 'قیمت طلا: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(نرخ: $rate در $unit)';
  }

  @override
  String get unitTola => 'تولہ';

  @override
  String get unitTenGram => '10 گرم';

  @override
  String get unitOneGram => '1 گرم';

  @override
  String enterValueHint(String label) {
    return 'مقدار $label را وارد کنید';
  }

  @override
  String inputFieldSemantic(String label) {
    return 'فیلد ورودی $label';
  }

  @override
  String unitSelectorSemantic(String label) {
    return 'انتخابگر واحد $label';
  }

  @override
  String get converterTabLabel => 'مبدل';

  @override
  String get settingsTabLabel => 'تنظیمات';

  @override
  String get settingsTitle => 'تنظیمات';

  @override
  String get settingsThemeLabel => 'تم';

  @override
  String get themeLight => 'روشن';

  @override
  String get themeDark => 'تاریک';

  @override
  String get darkModeLabel => 'حالت تاریک';

  @override
  String get darkModeSubtitle => 'بین تمهای تاریک و روشن جابجا شوید';

  @override
  String get themeSystem => 'سیستم';

  @override
  String get settingsLanguageLabel => 'زبان';

  @override
  String get settingsCurrencyLabel => 'ارز';

  @override
  String get currencySelectionPrompt => 'ارز خود را انتخاب کنید';

  @override
  String get currencySearchHint => 'جستجو با کد، نام یا نماد';

  @override
  String get currencySearchEmpty => 'ارزی یافت نشد';

  @override
  String get languageSelectionPrompt => 'لطفاً زبان خود را انتخاب کنید';

  @override
  String get languageEnglish => 'انگلیسی';

  @override
  String get languageUrdu => 'اردو';

  @override
  String get languageArabic => 'عربی';

  @override
  String get languageHindi => 'هندی';

  @override
  String get languageTurkish => 'ترکی';

  @override
  String get languageNote => 'زبان های بیشتری به زودی می آید';

  @override
  String get settingsAboutLabel => 'درباره';

  @override
  String get aboutVersion => 'نسخه';

  @override
  String get aboutDescription =>
      'مبدل وزن طلا یک ابزار ساده و کارآمد برای تبدیل بین واحدهای وزن طلای سنتی مختلف و گرم است.';

  @override
  String get unknownLabel => 'نامعلوم';

  @override
  String get zakatMenuLabel => 'زکات طلا';

  @override
  String get zakatScreenTitle => 'زکات طلا';

  @override
  String get zakatDisclaimer =>
      'فقط برای اقلام طلا — ارزیابی کامل زکات یا فتوا نیست. دارایی‌های دیگر و نصاب بر عهده شماست؛ با عالم محلی مشورت کنید.';

  @override
  String get zakatRateInfo => 'نرخ بازار طلای ۲۴ عیار / خالص برای هر واحد';

  @override
  String get zakatItemsTitle => 'اقلام طلای شما';

  @override
  String get zakatAddItem => 'افزودن قلم';

  @override
  String get zakatEditItem => 'ویرایش قلم';

  @override
  String get zakatEmptyItems =>
      'هنوز قلم طلایی نیست. برای محاسبه زکات جواهر یا شمش اضافه کنید.';

  @override
  String get zakatItemNameLabel => 'نام (اختیاری)';

  @override
  String get zakatItemNameHint => 'مثلاً حلقه ازدواج';

  @override
  String get zakatWeightLabel => 'وزن';

  @override
  String get zakatWeightHint => 'مثلاً 10';

  @override
  String get zakatWeightUnitLabel => 'واحد';

  @override
  String get zakatPurityLabel => 'عیار';

  @override
  String get zakatCustomKaratLabel => 'عیار سفارشی (1–24)';

  @override
  String get zakatCustomKaratHint => 'مثلاً 20';

  @override
  String get zakatPurity24k => '۲۴ عیار (خالص)';

  @override
  String get zakatPurity22k => '۲۲ عیار';

  @override
  String get zakatPurity21k => '۲۱ عیار';

  @override
  String get zakatPurity18k => '۱۸ عیار';

  @override
  String get zakatPurityCustom => 'سفارشی';

  @override
  String get zakatSaveItem => 'ذخیره';

  @override
  String get zakatDeleteItem => 'حذف';

  @override
  String get zakatDeleteConfirmTitle => 'قلم طلا حذف شود؟';

  @override
  String zakatDeleteConfirmMessage(String name) {
    return 'این کار \"$name\" را از فهرست زکات حذف می‌کند.';
  }

  @override
  String get zakatCancel => 'لغو';

  @override
  String get zakatUntitledItem => 'قلم طلا';

  @override
  String get zakatSummaryTitle => 'خلاصه زکات';

  @override
  String get zakatTotalPureGold => 'مجموع طلای خالص';

  @override
  String zakatPureGoldValue(String grams, String tola) {
    return '$grams گرم ($tola تولہ)';
  }

  @override
  String get zakatTotalValue => 'ارزش تقریبی';

  @override
  String get zakatDueLabel => 'زکات این اقلام (۲.۵٪)';

  @override
  String get zakatEnterRatePrompt =>
      'برای برآورد ارزش و زکات نرخ طلا را وارد کنید';

  @override
  String get zakatCalculateButton => 'محاسبه زکات';

  @override
  String zakatItemDetail(String weight, String unit, String purity) {
    return '$weight $unit · $purity';
  }

  @override
  String get zakatValidationWeight => 'وزنی بیشتر از صفر وارد کنید';

  @override
  String get zakatValidationKarat => 'عیاری بین ۱ و ۲۴ وارد کنید';

  @override
  String get copyResults => 'کپی';

  @override
  String get shareResults => 'اشتراک‌گذاری';

  @override
  String get resultsCopied => 'در کلیپ‌بورد کپی شد';

  @override
  String get privacyPolicyLabel => 'سیاست حفظ حریم خصوصی';

  @override
  String get rateAppLabel => 'امتیاز به برنامه';

  @override
  String get shareAppLabel => 'اشتراک برنامه';

  @override
  String shareAppMessage(String url) {
    return 'وزن طلا را با مبدل وزن طلا تبدیل کنید: $url';
  }

  @override
  String get openLinkFailed => 'پیوند باز نشد';

  @override
  String get appUpdateReady =>
      'به‌روزرسانی دانلود شد. برای نصب، برنامه را دوباره راه‌اندازی کنید.';

  @override
  String get appUpdateRestart => 'راه‌اندازی مجدد';
}
