// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Sindhi (`sd`).
class AppLocalizationsSd extends AppLocalizations {
  AppLocalizationsSd([String locale = 'sd']) : super(locale);

  @override
  String get appTitle => 'سونءِ جو وزن بدلڻ والو';

  @override
  String get validationValidNumber => 'براہ ڪرم هڪ درست نمبر درج ڪريو';

  @override
  String get validationPositiveNumber => 'براہ ڪرم هڪ مثبت نمبر درج ڪريو';

  @override
  String get tolaLabel => 'تولا';

  @override
  String get tolaInfo => '1 تولا = 11.66 ڳرام = 12 ماشو = 16 آنو = 96 رتي';

  @override
  String get tolaHint => 'نمونو طور تي 2.5';

  @override
  String get tolaSemanticLabel => 'تولا جو وزن درج ڪرڻ والو شعبو';

  @override
  String get mashaLabel => 'ماشو';

  @override
  String get mashaInfo => '1 ماشو = 0.972 ڳرام = 1.333 آنو = 8 رتي';

  @override
  String get mashaHint => 'نمونو طور تي 12.5';

  @override
  String get mashaSemanticLabel => 'ماشو جو وزن درج ڪرڻ والو شعبو';

  @override
  String get anaLabel => 'آنو';

  @override
  String get anaInfo => '1 آنو = 0.72875 ڳرام = 6 رتي';

  @override
  String get anaHint => 'نمونو طور تي 16.25';

  @override
  String get anaSemanticLabel => 'آنو جو وزن درج ڪرڻ والو شعبو';

  @override
  String get rattiLabel => 'رتي';

  @override
  String get rattiInfo => '1 رتي = 0.1215 ڳرام';

  @override
  String get rattiHint => 'نمونو طور تي 96.75';

  @override
  String get rattiSemanticLabel => 'رتي جو وزن درج ڪرڻ والو شعبو';

  @override
  String get gramLabel => 'ڳرام';

  @override
  String get gramInfo => 'سڌو ڳرام درج ڪريو';

  @override
  String get gramHint => 'نمونو طور تي 11.66';

  @override
  String get gramSemanticLabel => 'ڳرام جو وزن درج ڪرڻ والو شعبو';

  @override
  String get goldRateLabel => 'سونءِ جو ڏيڻو';

  @override
  String get goldRateInfo => 'موجوده بازار جو ڏيڻو في يونٹ';

  @override
  String get goldRateHint => 'نمونو طور تي 150,000';

  @override
  String get goldRateSemanticLabel => 'سونءِ جو ڏيڻو درج ڪرڻ والو شعبو';

  @override
  String get calculateButton => 'حساب ڪريو';

  @override
  String get calculateSemanticLabel => 'سونءِ جو وزن بدلڻ جو حساب ڪريو';

  @override
  String get clearAllButton => 'سڀ صاف ڪريو';

  @override
  String get clearAllSemanticLabel => 'سڀ درج ڪرڻ والا شعبا صاف ڪريو';

  @override
  String get conversionDetails => 'بدلڻ جي تفصيل';

  @override
  String tolaConversion(String value, String factor, String result) {
    return 'تولا: $value × $factor = $result ڳرام';
  }

  @override
  String mashaConversion(String value, String factor, String result) {
    return 'ماشو: $value × $factor = $result ڳرام';
  }

  @override
  String anaConversion(String value, String factor, String result) {
    return 'آنو: $value × $factor = $result ڳرام';
  }

  @override
  String rattiConversion(String value, String factor, String result) {
    return 'رتي: $value × $factor = $result ڳرام';
  }

  @override
  String gramConversion(String value) {
    return 'ڳرام: $value ڳرام';
  }

  @override
  String totalWeight(String value) {
    return 'ڪل وزن: $value ڳرام';
  }

  @override
  String get convertedTo => 'هن ۾ بدل ڪيو ويو:';

  @override
  String tolaResult(String value) {
    return 'تولا: $value';
  }

  @override
  String mashaResult(String value) {
    return 'ماشو: $value';
  }

  @override
  String anaResult(String value) {
    return 'آنو: $value';
  }

  @override
  String rattiResult(String value) {
    return 'رتي: $value';
  }

  @override
  String goldPrice(String price) {
    return 'سونءِ جي قيمت: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(ڏيڻو: $rate في $unit)';
  }

  @override
  String get unitTola => 'تولا';

  @override
  String get unitTenGram => '10 ڳرام';

  @override
  String get unitOneGram => '1 ڳرام';

  @override
  String enterValueHint(String label) {
    return '$label جي قيمت درج ڪريو';
  }

  @override
  String inputFieldSemantic(String label) {
    return '$label درج ڪرڻ والو شعبو';
  }

  @override
  String unitSelectorSemantic(String label) {
    return '$label يونٹ چننڪار';
  }

  @override
  String get converterTabLabel => 'بدلڻ والو';

  @override
  String get settingsTabLabel => 'سيٽنگز';

  @override
  String get settingsTitle => 'سيٽنگز';

  @override
  String get settingsThemeLabel => 'ٿيم';

  @override
  String get themeLight => 'روشن';

  @override
  String get themeDark => 'اونداهي';

  @override
  String get darkModeLabel => 'اونداهي موڊ';

  @override
  String get darkModeSubtitle => 'اونداهي ۽ روشن ٿيمن جے درميان تبديل ڪريو';

  @override
  String get themeSystem => 'نظام';

  @override
  String get settingsLanguageLabel => 'ٻولي';

  @override
  String get settingsCurrencyLabel => 'ڪرنسي';

  @override
  String get currencySelectionPrompt => 'پنهنجي ڪرنسي چونڊيو';

  @override
  String get currencySearchHint => 'ڪوڊ، نالو يا علامت سان ڳوليو';

  @override
  String get currencySearchEmpty => 'ڪا ڪرنسي نه ملي';

  @override
  String get languageSelectionPrompt => 'براہ ڪرم پنهنجي ٻولي چنڊيو';

  @override
  String get languageEnglish => 'انگريزي';

  @override
  String get languageUrdu => 'اردو';

  @override
  String get languageArabic => 'عربي';

  @override
  String get languageHindi => 'هندي';

  @override
  String get languageTurkish => 'ترڪي';

  @override
  String get languageNote => 'وڌيڪ ٻوليون جلد اچڻ وارا آهن';

  @override
  String get settingsAboutLabel => 'بابت';

  @override
  String get aboutVersion => 'نسخو';

  @override
  String get aboutDescription =>
      'سونءِ جو وزن بدلڻ والو مختلف روايتي سونءِ جي وزن جي يونٹس ۽ ڳرام جے درميان بدلڻ لاء هڪ سادو ۽ موثر اوزار آهي.';

  @override
  String get unknownLabel => 'نامعلوم';

  @override
  String get zakatMenuLabel => 'سوني جي زڪوات';

  @override
  String get zakatScreenTitle => 'سوني جي زڪوات';

  @override
  String get zakatDisclaimer =>
      'صرف سوني جي شين لاءِ مددگار — مڪمل زڪوات جو حساب يا فتويٰ نه آهي. ٻيون ملڪيتون ۽ نصاب توهان جي ذميواري آهي؛ مقامي عالم سان صلاح ڪريو.';

  @override
  String get zakatRateInfo => '24K / خالص سوني جي مارڪيٽ شرح في يونٽ';

  @override
  String get zakatItemsTitle => 'توهان جون سوني جون شيون';

  @override
  String get zakatAddItem => 'شيءِ شامل ڪريو';

  @override
  String get zakatEditItem => 'شيءِ ۾ ترميم';

  @override
  String get zakatEmptyItems =>
      'اڃا ڪا سوني جي شيءِ ناهي. زڪوات لاءِ زيور يا بار شامل ڪريو.';

  @override
  String get zakatItemNameLabel => 'نالو (اختياري)';

  @override
  String get zakatItemNameHint => 'مثال طور شادي جي آڱوٺي';

  @override
  String get zakatWeightLabel => 'وزن';

  @override
  String get zakatWeightHint => 'مثال طور 10';

  @override
  String get zakatWeightUnitLabel => 'يونٽ';

  @override
  String get zakatPurityLabel => 'پاڪائي';

  @override
  String get zakatCustomKaratLabel => 'ڪسٽم قيراط (1–24)';

  @override
  String get zakatCustomKaratHint => 'مثال طور 20';

  @override
  String get zakatPurity24k => '24K (خالص)';

  @override
  String get zakatPurity22k => '22K';

  @override
  String get zakatPurity21k => '21K';

  @override
  String get zakatPurity18k => '18K';

  @override
  String get zakatPurityCustom => 'ڪسٽم';

  @override
  String get zakatSaveItem => 'محفوظ ڪريو';

  @override
  String get zakatDeleteItem => 'ڊاهيو';

  @override
  String get zakatDeleteConfirmTitle => 'سوني جي شيءِ ختم ڪجي؟';

  @override
  String zakatDeleteConfirmMessage(String name) {
    return 'هي توهان جي زڪوات جي فهرست مان \"$name\" هٽائي ڇڏيندو.';
  }

  @override
  String get zakatCancel => 'منسوخ';

  @override
  String get zakatUntitledItem => 'سوني جي شيءِ';

  @override
  String get zakatSummaryTitle => 'زڪوات جو خلاصو';

  @override
  String get zakatTotalPureGold => 'ڪل خالص سونو';

  @override
  String zakatPureGoldValue(String grams, String tola) {
    return '$grams گرام ($tola تولو)';
  }

  @override
  String get zakatTotalValue => 'اندازي مطابق قيمت';

  @override
  String get zakatDueLabel => 'هن شين تي زڪوات (2.5%)';

  @override
  String get zakatEnterRatePrompt => 'قيمت ۽ زڪوات لاءِ سوني جي شرح داخل ڪريو';

  @override
  String get zakatCalculateButton => 'زڪوات حساب ڪريو';

  @override
  String zakatItemDetail(String weight, String unit, String purity) {
    return '$weight $unit · $purity';
  }

  @override
  String get zakatValidationWeight => 'صفر کان وڌيڪ وزن داخل ڪريو';

  @override
  String get zakatValidationKarat => '1 ۽ 24 جي وچ ۾ قيراط داخل ڪريو';
}
