// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'محول وزن الذهب';

  @override
  String get validationValidNumber => 'يرجى إدخال رقم صحيح';

  @override
  String get validationPositiveNumber => 'يرجى إدخال رقم موجب';

  @override
  String get tolaLabel => 'تولة';

  @override
  String get tolaInfo => '1 تولة = 11.66 جرام = 12 ماشة = 16 آنة = 96 راتي';

  @override
  String get tolaHint => 'على سبيل المثال 2.5';

  @override
  String get tolaSemanticLabel => 'حقل إدخال وزن التولة';

  @override
  String get mashaLabel => 'ماشة';

  @override
  String get mashaInfo => '1 ماشة = 0.972 جرام = 1.333 آنة = 8 راتي';

  @override
  String get mashaHint => 'على سبيل المثال 12.5';

  @override
  String get mashaSemanticLabel => 'حقل إدخال وزن الماشة';

  @override
  String get anaLabel => 'آنة';

  @override
  String get anaInfo => '1 آنة = 0.72875 جرام = 6 راتي';

  @override
  String get anaHint => 'على سبيل المثال 16.25';

  @override
  String get anaSemanticLabel => 'حقل إدخال وزن الآنة';

  @override
  String get rattiLabel => 'راتي';

  @override
  String get rattiInfo => '1 راتي = 0.1215 جرام';

  @override
  String get rattiHint => 'على سبيل المثال 96.75';

  @override
  String get rattiSemanticLabel => 'حقل إدخال وزن الراتي';

  @override
  String get gramLabel => 'جرام';

  @override
  String get gramInfo => 'إدخال مباشر بالجرام';

  @override
  String get gramHint => 'على سبيل المثال 11.66';

  @override
  String get gramSemanticLabel => 'حقل إدخال وزن الجرام';

  @override
  String get goldRateLabel => 'سعر الذهب';

  @override
  String get goldRateInfo => 'سعر السوق الحالي لكل وحدة';

  @override
  String get goldRateHint => 'على سبيل المثال 150,000';

  @override
  String get goldRateSemanticLabel => 'حقل إدخال سعر الذهب';

  @override
  String get calculateButton => 'احسب';

  @override
  String get calculateSemanticLabel => 'احسب تحويل وزن الذهب';

  @override
  String get clearAllButton => 'امسح الكل';

  @override
  String get clearAllSemanticLabel => 'امسح جميع حقول الإدخال';

  @override
  String get conversionDetails => 'تفاصيل التحويل';

  @override
  String tolaConversion(String value, String factor, String result) {
    return 'التولة: $value × $factor = $result جرام';
  }

  @override
  String mashaConversion(String value, String factor, String result) {
    return 'الماشة: $value × $factor = $result جرام';
  }

  @override
  String anaConversion(String value, String factor, String result) {
    return 'الآنة: $value × $factor = $result جرام';
  }

  @override
  String rattiConversion(String value, String factor, String result) {
    return 'الراتي: $value × $factor = $result جرام';
  }

  @override
  String gramConversion(String value) {
    return 'الجرام: $value جرام';
  }

  @override
  String totalWeight(String value) {
    return 'الوزن الإجمالي: $value جرام';
  }

  @override
  String get convertedTo => 'محول إلى:';

  @override
  String tolaResult(String value) {
    return 'التولة: $value';
  }

  @override
  String mashaResult(String value) {
    return 'الماشة: $value';
  }

  @override
  String anaResult(String value) {
    return 'الآنة: $value';
  }

  @override
  String rattiResult(String value) {
    return 'الراتي: $value';
  }

  @override
  String goldPrice(String price) {
    return 'سعر الذهب: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(السعر: $rate لكل $unit)';
  }

  @override
  String get unitTola => 'تولة';

  @override
  String get unitTenGram => '10 جرام';

  @override
  String get unitOneGram => '1 جرام';

  @override
  String enterValueHint(String label) {
    return 'أدخل قيمة $label';
  }

  @override
  String inputFieldSemantic(String label) {
    return 'حقل إدخال $label';
  }

  @override
  String unitSelectorSemantic(String label) {
    return 'منتقي وحدة $label';
  }

  @override
  String get converterTabLabel => 'محول';

  @override
  String get settingsTabLabel => 'الإعدادات';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsThemeLabel => 'المظهر';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get darkModeLabel => 'الوضع الداكن';

  @override
  String get darkModeSubtitle => 'التبديل بين المظهر الداكن والفاتح';

  @override
  String get themeSystem => 'النظام';

  @override
  String get settingsLanguageLabel => 'اللغة';

  @override
  String get settingsCurrencyLabel => 'العملة';

  @override
  String get currencySelectionPrompt => 'اختر عملتك';

  @override
  String get currencySearchHint => 'ابحث بالرمز أو الاسم أو العلامة';

  @override
  String get currencySearchEmpty => 'لا توجد عملات مطابقة';

  @override
  String get languageSelectionPrompt => 'يرجى تحديد اللغة الخاصة بك';

  @override
  String get languageEnglish => 'الإنجليزية';

  @override
  String get languageUrdu => 'الأردية';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageHindi => 'الهندية';

  @override
  String get languageTurkish => 'التركية';

  @override
  String get languageNote => 'لغات أخرى قريبة';

  @override
  String get settingsAboutLabel => 'حول';

  @override
  String get aboutVersion => 'الإصدار';

  @override
  String get aboutDescription =>
      'محول وزن الذهب هو أداة بسيطة وفعالة للتحويل بين وحدات وزن الذهب التقليدية المختلفة والجرام.';

  @override
  String get unknownLabel => 'غير معروف';

  @override
  String get zakatMenuLabel => 'زكاة الذهب';

  @override
  String get zakatScreenTitle => 'زكاة الذهب';

  @override
  String get zakatDisclaimer =>
      'مساعد لعناصر الذهب فقط — ليس تقييم زكاة كاملًا ولا فتوى. الأصول الأخرى والنصاب مسؤوليتك؛ راجع عالمًا محليًا.';

  @override
  String get zakatRateInfo => 'سعر السوق للذهب عيار 24 / الخالص لكل وحدة';

  @override
  String get zakatItemsTitle => 'قطع الذهب لديك';

  @override
  String get zakatAddItem => 'إضافة قطعة';

  @override
  String get zakatEditItem => 'تعديل القطعة';

  @override
  String get zakatEmptyItems =>
      'لا توجد قطع ذهب بعد. أضف مجوهرات أو سبائك لحساب الزكاة.';

  @override
  String get zakatItemNameLabel => 'الاسم (اختياري)';

  @override
  String get zakatItemNameHint => 'مثل خاتم الزواج';

  @override
  String get zakatWeightLabel => 'الوزن';

  @override
  String get zakatWeightHint => 'مثل 10';

  @override
  String get zakatWeightUnitLabel => 'الوحدة';

  @override
  String get zakatPurityLabel => 'النقاء';

  @override
  String get zakatCustomKaratLabel => 'عيار مخصص (1–24)';

  @override
  String get zakatCustomKaratHint => 'مثل 20';

  @override
  String get zakatPurity24k => '24 قيراط (خالص)';

  @override
  String get zakatPurity22k => '22 قيراط';

  @override
  String get zakatPurity21k => '21 قيراط';

  @override
  String get zakatPurity18k => '18 قيراط';

  @override
  String get zakatPurityCustom => 'مخصص';

  @override
  String get zakatSaveItem => 'حفظ';

  @override
  String get zakatDeleteItem => 'حذف';

  @override
  String get zakatDeleteConfirmTitle => 'حذف قطعة الذهب؟';

  @override
  String zakatDeleteConfirmMessage(String name) {
    return 'سيؤدي هذا إلى إزالة \"$name\" من قائمة الزكاة.';
  }

  @override
  String get zakatCancel => 'إلغاء';

  @override
  String get zakatUntitledItem => 'قطعة ذهب';

  @override
  String get zakatSummaryTitle => 'ملخص الزكاة';

  @override
  String get zakatTotalPureGold => 'إجمالي الذهب الخالص';

  @override
  String zakatPureGoldValue(String grams, String tola) {
    return '$grams غ ($tola تولة)';
  }

  @override
  String get zakatTotalValue => 'القيمة التقديرية';

  @override
  String get zakatDueLabel => 'الزكاة على هذه القطع (2.5%)';

  @override
  String get zakatEnterRatePrompt => 'أدخل سعر الذهب لتقدير القيمة والزكاة';

  @override
  String get zakatCalculateButton => 'احسب الزكاة';

  @override
  String zakatItemDetail(String weight, String unit, String purity) {
    return '$weight $unit · $purity';
  }

  @override
  String get zakatValidationWeight => 'أدخل وزنًا أكبر من صفر';

  @override
  String get zakatValidationKarat => 'أدخل عيارًا بين 1 و 24';
}
