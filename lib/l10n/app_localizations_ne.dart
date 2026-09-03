// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Nepali (`ne`).
class AppLocalizationsNe extends AppLocalizations {
  AppLocalizationsNe([String locale = 'ne']) : super(locale);

  @override
  String get appTitle => 'सुनको तौल रूपान्तरक';

  @override
  String get validationValidNumber => 'कृपया मान्य सङ्ख्या प्रविष्ट गर्नुहोस्';

  @override
  String get validationPositiveNumber =>
      'कृपया सकारात्मक सङ्ख्या प्रविष्ट गर्नुहोस्';

  @override
  String get tolaLabel => 'तोला';

  @override
  String get tolaInfo => '१ तोला = ११.६६ ग्राम = १६ आना = १०० लाल';

  @override
  String get tolaHint => 'जस्तै २.५';

  @override
  String get tolaSemanticLabel => 'तोला तौल इनपुट फिल्ड';

  @override
  String get mashaLabel => 'मासा';

  @override
  String get mashaInfo => '१ मासा = ०.९७२ ग्राम = १.३३३ आना = ८ रत्ती';

  @override
  String get mashaHint => 'जस्तै १२.५';

  @override
  String get mashaSemanticLabel => 'मासा तौल इनपुट फिल्ड';

  @override
  String get anaLabel => 'आना';

  @override
  String get anaInfo => '१ आना = ०.७२९ ग्राम = ६.२५ लाल';

  @override
  String get anaHint => 'जस्तै १६.२५';

  @override
  String get anaSemanticLabel => 'आना तौल इनपुट फिल्ड';

  @override
  String get rattiLabel => 'रत्ती';

  @override
  String get rattiInfo => '१ रत्ती = ०.१२१५ ग्राम';

  @override
  String get rattiHint => 'जस्तै ९६.७५';

  @override
  String get rattiSemanticLabel => 'रत्ती तौल इनपुट फिल्ड';

  @override
  String get lalLabel => 'लाल';

  @override
  String get lalInfo => '१ लाल = ०.११६६ ग्राम = ०.०१ तोला';

  @override
  String get lalHint => 'जस्तै २५';

  @override
  String get lalSemanticLabel => 'लाल तौल इनपुट फिल्ड';

  @override
  String get gramLabel => 'ग्राम';

  @override
  String get gramInfo => 'प्रत्यक्ष ग्राम इनपुट';

  @override
  String get gramHint => 'जस्तै ११.६६';

  @override
  String get gramSemanticLabel => 'ग्राम तौल इनपुट फिल्ड';

  @override
  String get goldRateLabel => 'सुनको दर';

  @override
  String get goldRateInfo => 'प्रति एकाइ हालको बजार दर';

  @override
  String get goldRateHint => 'जस्तै १५०,०००';

  @override
  String get goldRateSemanticLabel => 'सुनको दर इनपुट फिल्ड';

  @override
  String get calculateButton => 'गणना गर्नुहोस्';

  @override
  String get calculateSemanticLabel => 'सुनको तौल रूपान्तरण गर्नुहोस्';

  @override
  String get clearAllButton => 'सबै खाली गर्नुहोस्';

  @override
  String get clearAllSemanticLabel => 'सबै इनपुट फिल्डहरू खाली गर्नुहोस्';

  @override
  String get conversionDetails => 'रूपान्तरण विवरण';

  @override
  String tolaConversion(String value, String factor, String result) {
    return 'तोला: $value × $factor = $result ग्राम';
  }

  @override
  String mashaConversion(String value, String factor, String result) {
    return 'मासा: $value × $factor = $result ग्राम';
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
  String lalConversion(String value, String factor, String result) {
    return 'लाल: $value × $factor = $result ग्राम';
  }

  @override
  String gramConversion(String value) {
    return 'ग्राम: $value ग्राम';
  }

  @override
  String totalWeight(String value) {
    return 'कुल तौल: $value ग्राम';
  }

  @override
  String get convertedTo => 'रूपान्तरित:';

  @override
  String tolaResult(String value) {
    return 'तोला: $value';
  }

  @override
  String lalResult(String value) {
    return 'लाल: $value';
  }

  @override
  String mashaResult(String value) {
    return 'मासा: $value';
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
    return 'सुनको मूल्य: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(दर: प्रति $unit $rate)';
  }

  @override
  String get unitTola => 'तोला';

  @override
  String get unitLal => 'लाल';

  @override
  String get unitTenGram => '१० ग्राम';

  @override
  String get unitOneGram => '१ ग्राम';

  @override
  String enterValueHint(String label) {
    return '$label मान प्रविष्ट गर्नुहोस्';
  }

  @override
  String inputFieldSemantic(String label) {
    return '$label इनपुट फिल्ड';
  }

  @override
  String unitSelectorSemantic(String label) {
    return '$label एकाइ चयनकर्ता';
  }

  @override
  String get converterTabLabel => 'रूपान्तरक';

  @override
  String get settingsTabLabel => 'सेटिङहरू';

  @override
  String get settingsTitle => 'सेटिङहरू';

  @override
  String get settingsThemeLabel => 'थिम';

  @override
  String get themeLight => 'हल्का';

  @override
  String get themeDark => 'गाढा';

  @override
  String get darkModeLabel => 'डार्क मोड';

  @override
  String get darkModeSubtitle => 'गाढा र हल्का थिम बीच स्विच गर्नुहोस्';

  @override
  String get themeSystem => 'प्रणाली';

  @override
  String get settingsLanguageLabel => 'भाषा';

  @override
  String get settingsCurrencyLabel => 'मुद्रा';

  @override
  String get currencySelectionPrompt => 'आफ्नो मुद्रा चयन गर्नुहोस्';

  @override
  String get currencySearchHint => 'कोड, नाम वा प्रतीकबाट खोज्नुहोस्';

  @override
  String get currencySearchEmpty => 'कुनै मुद्रा फेला परेन';

  @override
  String get languageSelectionPrompt => 'कृपया आफ्नो भाषा चयन गर्नुहोस्';

  @override
  String get languageEnglish => 'अंग्रेजी';

  @override
  String get languageUrdu => 'उर्दु';

  @override
  String get languageArabic => 'अरबी';

  @override
  String get languageHindi => 'हिन्दी';

  @override
  String get languageTurkish => 'टर्किस';

  @override
  String get languageNote => 'थप भाषाहरू चाँडै आउँदैछन्';

  @override
  String get settingsAboutLabel => 'बारेमा';

  @override
  String get aboutVersion => 'संस्करण';

  @override
  String get aboutDescription =>
      'सुनको तौल रूपान्तरक विभिन्न परम्परागत सुनको तौल एकाइहरू र ग्राम बीच रूपान्तरण गर्नका लागि एक सरल र प्रभावकारी उपकरण हो।';

  @override
  String get unknownLabel => 'अज्ञात';

  @override
  String get zakatMenuLabel => 'सुनको जकात';

  @override
  String get zakatScreenTitle => 'सुनको जकात';

  @override
  String get zakatDisclaimer =>
      'केवल सुनका वस्तुहरूका लागि सहयोगी — पूर्ण जकात मूल्याङ्कन वा धार्मिक फतवा होइन। अन्य सम्पत्ति र निसाब तपाईंको आफ्नै जिम्मेवारी हो; स्थानीय विद्वानसँग सल्लाह लिनुहोस्।';

  @override
  String get zakatRateInfo => '२४ क्यारेट / शुद्ध सुनको प्रति एकाइ बजार दर';

  @override
  String get zakatItemsTitle => 'तपाईंका सुनका वस्तुहरू';

  @override
  String get zakatAddItem => 'वस्तु थप्नुहोस्';

  @override
  String get zakatEditItem => 'वस्तु सम्पादन गर्नुहोस्';

  @override
  String get zakatEmptyItems =>
      'अहिलेसम्म कुनै सुनको वस्तु छैन। जकात गणना गर्न गहना वा सुनको टुक्रा थप्नुहोस्।';

  @override
  String get zakatItemNameLabel => 'नाम (वैकल्पिक)';

  @override
  String get zakatItemNameHint => 'जस्तै विवाहको औंठी';

  @override
  String get zakatWeightLabel => 'तौल';

  @override
  String get zakatWeightHint => 'जस्तै १०';

  @override
  String get zakatWeightUnitLabel => 'एकाइ';

  @override
  String get zakatPurityLabel => 'शुद्धता';

  @override
  String get zakatCustomKaratLabel => 'कस्टम क्यारेट (१–२४)';

  @override
  String get zakatCustomKaratHint => 'जस्तै २०';

  @override
  String get zakatPurity24k => '२४ क्यारेट (शुद्ध)';

  @override
  String get zakatPurity22k => '२२ क्यारेट';

  @override
  String get zakatPurity21k => '२१ क्यारेट';

  @override
  String get zakatPurity18k => '१८ क्यारेट';

  @override
  String get zakatPurityCustom => 'कस्टम';

  @override
  String get zakatSaveItem => 'बचत गर्नुहोस्';

  @override
  String get zakatDeleteItem => 'मेटाउनुहोस्';

  @override
  String get zakatDeleteConfirmTitle => 'सुनको वस्तु मेटाउने?';

  @override
  String zakatDeleteConfirmMessage(String name) {
    return 'यसले तपाईंको जकात सूचीबाट \"$name\" हटाउनेछ।';
  }

  @override
  String get zakatCancel => 'रद्द गर्नुहोस्';

  @override
  String get zakatUntitledItem => 'सुनको वस्तु';

  @override
  String get zakatSummaryTitle => 'जकात सारांश';

  @override
  String get zakatTotalPureGold => 'कुल शुद्ध सुन';

  @override
  String zakatPureGoldValue(String grams, String tola) {
    return '$grams ग्राम ($tola तोला)';
  }

  @override
  String get zakatTotalValue => 'अनुमानित मूल्य';

  @override
  String get zakatDueLabel => 'यी वस्तुहरूमा जकात (२.५%)';

  @override
  String get zakatEnterRatePrompt =>
      'मूल्य र जकात अनुमान गर्न सुनको दर प्रविष्ट गर्नुहोस्';

  @override
  String get zakatCalculateButton => 'जकात गणना गर्नुहोस्';

  @override
  String zakatItemDetail(String weight, String unit, String purity) {
    return '$weight $unit · $purity';
  }

  @override
  String get zakatValidationWeight => 'शून्यभन्दा बढी तौल प्रविष्ट गर्नुहोस्';

  @override
  String get zakatValidationKarat =>
      '१ देखि २४ बीचको क्यारेट प्रविष्ट गर्नुहोस्';

  @override
  String get copyResults => 'प्रतिलिपि गर्नुहोस्';

  @override
  String get shareResults => 'साझेदारी गर्नुहोस्';

  @override
  String get resultsCopied => 'क्लिपबोर्डमा प्रतिलिपि गरियो';

  @override
  String get privacyPolicyLabel => 'गोपनीयता नीति';

  @override
  String get rateAppLabel => 'एप मूल्याङ्कन गर्नुहोस्';

  @override
  String get moreAppsLabel => 'थप एपहरू';

  @override
  String get shareAppLabel => 'एप साझा गर्नुहोस्';

  @override
  String shareAppMessage(String url) {
    return 'सुनको तौल रूपान्तरक प्रयोग गर्नुहोस्: $url';
  }

  @override
  String get openLinkFailed => 'लिङ्क खोल्न सकिएन';

  @override
  String get appUpdateReady =>
      'अपडेट डाउनलोड भयो। स्थापना गर्न पुन: सुरु गर्नुहोस्।';

  @override
  String get appUpdateRestart => 'पुन: सुरु गर्नुहोस्';
}
