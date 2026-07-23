// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'सोने का वजन कनवर्टर';

  @override
  String get validationValidNumber => 'कृपया एक मान्य संख्या दर्ज करें';

  @override
  String get validationPositiveNumber => 'कृपया एक सकारात्मक संख्या दर्ज करें';

  @override
  String get tolaLabel => 'तोला';

  @override
  String get tolaInfo => '1 तोला = 11.66 ग्राम = 12 माशा = 16 आना = 96 रत्ती';

  @override
  String get tolaHint => 'उदाहरण के लिए 2.5';

  @override
  String get tolaSemanticLabel => 'तोला वजन इनपुट फील्ड';

  @override
  String get mashaLabel => 'माशा';

  @override
  String get mashaInfo => '1 माशा = 0.972 ग्राम = 1.333 आना = 8 रत्ती';

  @override
  String get mashaHint => 'उदाहरण के लिए 12.5';

  @override
  String get mashaSemanticLabel => 'माशा वजन इनपुट फील्ड';

  @override
  String get anaLabel => 'आना';

  @override
  String get anaInfo => '1 आना = 0.72875 ग्राम = 6 रत्ती';

  @override
  String get anaHint => 'उदाहरण के लिए 16.25';

  @override
  String get anaSemanticLabel => 'आना वजन इनपुट फील्ड';

  @override
  String get rattiLabel => 'रत्ती';

  @override
  String get rattiInfo => '1 रत्ती = 0.1215 ग्राम';

  @override
  String get rattiHint => 'उदाहरण के लिए 96.75';

  @override
  String get rattiSemanticLabel => 'रत्ती वजन इनपुट फील्ड';

  @override
  String get gramLabel => 'ग्राम';

  @override
  String get gramInfo => 'सीधे ग्राम दर्ज करें';

  @override
  String get gramHint => 'उदाहरण के लिए 11.66';

  @override
  String get gramSemanticLabel => 'ग्राम वजन इनपुट फील्ड';

  @override
  String get goldRateLabel => 'सोने की दर';

  @override
  String get goldRateInfo => 'वर्तमान बाजार दर प्रति इकाई';

  @override
  String get goldRateHint => 'उदाहरण के लिए 150,000';

  @override
  String get goldRateSemanticLabel => 'सोने की दर इनपुट फील्ड';

  @override
  String get calculateButton => 'गणना करें';

  @override
  String get calculateSemanticLabel => 'सोने के वजन को कनवर्ट करें';

  @override
  String get clearAllButton => 'सभी साफ़ करें';

  @override
  String get clearAllSemanticLabel => 'सभी इनपुट फील्ड साफ़ करें';

  @override
  String get conversionDetails => 'रूपांतरण विवरण';

  @override
  String tolaConversion(String value, String factor, String result) {
    return 'तोला: $value × $factor = $result ग्राम';
  }

  @override
  String mashaConversion(String value, String factor, String result) {
    return 'माशा: $value × $factor = $result ग्राम';
  }

  @override
  String anaConversion(String value, String factor, String result) {
    return 'आना: $value × $factor = $result ग्राम';
  }

  @override
  String rattiConversion(String value, String factor, String result) {
    return 'रत्ती: $value × $factor = $result ग्राम';
  }

  @override
  String gramConversion(String value) {
    return 'ग्राम: $value ग्राम';
  }

  @override
  String totalWeight(String value) {
    return 'कुल वजन: $value ग्राम';
  }

  @override
  String get convertedTo => 'में रूपांतरित:';

  @override
  String tolaResult(String value) {
    return 'तोला: $value';
  }

  @override
  String mashaResult(String value) {
    return 'माशा: $value';
  }

  @override
  String anaResult(String value) {
    return 'आना: $value';
  }

  @override
  String rattiResult(String value) {
    return 'रत्ती: $value';
  }

  @override
  String goldPrice(String price) {
    return 'सोने की कीमत: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(दर: $rate प्रति $unit)';
  }

  @override
  String get unitTola => 'तोला';

  @override
  String get unitTenGram => '10 ग्राम';

  @override
  String get unitOneGram => '1 ग्राम';

  @override
  String enterValueHint(String label) {
    return '$label मान दर्ज करें';
  }

  @override
  String inputFieldSemantic(String label) {
    return '$label इनपुट फील्ड';
  }

  @override
  String unitSelectorSemantic(String label) {
    return '$label यूनिट सिलेक्टर';
  }

  @override
  String get converterTabLabel => 'कनवर्टर';

  @override
  String get settingsTabLabel => 'सेटिंग्स';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get settingsThemeLabel => 'थीम';

  @override
  String get themeLight => 'हल्का';

  @override
  String get themeDark => 'गहरा';

  @override
  String get darkModeLabel => 'डार्क मोड';

  @override
  String get darkModeSubtitle => 'डार्क और लाइट थीम के बीच स्विच करें';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get settingsLanguageLabel => 'भाषा';

  @override
  String get languageSelectionPrompt => 'कृपया अपनी भाषा चुनें';

  @override
  String get languageEnglish => 'अंग्रेजी';

  @override
  String get languageUrdu => 'उर्दू';

  @override
  String get languageArabic => 'अरबी';

  @override
  String get languageHindi => 'हिंदी';

  @override
  String get languageTurkish => 'तुर्की';

  @override
  String get languageNote => 'अधिक भाषाएं जल्द आ रही हैं';

  @override
  String get settingsAboutLabel => 'परिचय';

  @override
  String get aboutVersion => 'संस्करण';

  @override
  String get aboutDescription =>
      'सोने का वजन कनवर्टर विभिन्न पारंपरिक सोने की वजन इकाइयों और ग्राम के बीच रूपांतरण के लिए एक सरल और कुशल उपकरण है।';

  @override
  String get unknownLabel => 'अज्ञात';

  @override
  String get zakatMenuLabel => 'सोने की ज़कात';

  @override
  String get zakatScreenTitle => 'सोने की ज़कात';

  @override
  String get zakatDisclaimer =>
      'केवल सोने की वस्तुओं के लिए सहायक — पूर्ण ज़कात आकलन या धार्मिक फ़तवा नहीं। अन्य संपत्ति और निसाब आपकी ज़िम्मेदारी है; स्थानीय विद्वान से सलाह लें।';

  @override
  String get zakatRateInfo => '24K / शुद्ध सोने की बाज़ार दर प्रति इकाई';

  @override
  String get zakatItemsTitle => 'आपकी सोने की वस्तुएँ';

  @override
  String get zakatAddItem => 'वस्तु जोड़ें';

  @override
  String get zakatEditItem => 'वस्तु संपादित करें';

  @override
  String get zakatEmptyItems =>
      'अभी कोई सोने की वस्तु नहीं। ज़कात गणना के लिए आभूषण या बार जोड़ें।';

  @override
  String get zakatItemNameLabel => 'नाम (वैकल्पिक)';

  @override
  String get zakatItemNameHint => 'जैसे विवाह की अंगूठी';

  @override
  String get zakatWeightLabel => 'वज़न';

  @override
  String get zakatWeightHint => 'जैसे 10';

  @override
  String get zakatWeightUnitLabel => 'इकाई';

  @override
  String get zakatPurityLabel => 'शुद्धता';

  @override
  String get zakatCustomKaratLabel => 'कस्टम कैरेट (1–24)';

  @override
  String get zakatCustomKaratHint => 'जैसे 20';

  @override
  String get zakatPurity24k => '24K (शुद्ध)';

  @override
  String get zakatPurity22k => '22K';

  @override
  String get zakatPurity21k => '21K';

  @override
  String get zakatPurity18k => '18K';

  @override
  String get zakatPurityCustom => 'कस्टम';

  @override
  String get zakatSaveItem => 'सहेजें';

  @override
  String get zakatDeleteItem => 'हटाएँ';

  @override
  String get zakatCancel => 'रद्द करें';

  @override
  String get zakatUntitledItem => 'सोने की वस्तु';

  @override
  String get zakatSummaryTitle => 'ज़कात सारांश';

  @override
  String get zakatTotalPureGold => 'कुल शुद्ध सोना';

  @override
  String zakatPureGoldValue(String grams, String tola) {
    return '$grams ग्राम ($tola तोला)';
  }

  @override
  String get zakatTotalValue => 'अनुमानित मूल्य';

  @override
  String get zakatDueLabel => 'इन वस्तुओं पर ज़कात (2.5%)';

  @override
  String get zakatEnterRatePrompt =>
      'मूल्य और ज़कात का अनुमान लगाने के लिए सोने की दर दर्ज करें';

  @override
  String get zakatCalculateButton => 'ज़कात गणना करें';

  @override
  String zakatItemDetail(String weight, String unit, String purity) {
    return '$weight $unit · $purity';
  }

  @override
  String get zakatValidationWeight => 'शून्य से अधिक वज़न दर्ज करें';

  @override
  String get zakatValidationKarat => '1 से 24 के बीच कैरेट दर्ज करें';
}
