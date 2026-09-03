// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class AppLocalizationsFil extends AppLocalizations {
  AppLocalizationsFil([String locale = 'fil']) : super(locale);

  @override
  String get appTitle => 'Gold Weight Converter';

  @override
  String get validationValidNumber => 'Mangyaring maglagay ng wastong numero';

  @override
  String get validationPositiveNumber =>
      'Mangyaring maglagay ng positibong numero';

  @override
  String get tolaLabel => 'Tola';

  @override
  String get tolaInfo => '1 Tola = 11.66 gramo = 12 Masha = 16 Ana = 96 Ratti';

  @override
  String get tolaHint => 'hal. 2.5';

  @override
  String get tolaSemanticLabel => 'Input field para sa bigat ng Tola';

  @override
  String get mashaLabel => 'Masha';

  @override
  String get mashaInfo => '1 Masha = 0.972 gramo = 1.333 Ana = 8 Ratti';

  @override
  String get mashaHint => 'hal. 12.5';

  @override
  String get mashaSemanticLabel => 'Input field para sa bigat ng Masha';

  @override
  String get anaLabel => 'Ana';

  @override
  String get anaInfo => '1 Ana = 0.72875 gramo = 6 Ratti';

  @override
  String get anaHint => 'hal. 16.25';

  @override
  String get anaSemanticLabel => 'Input field para sa bigat ng Ana';

  @override
  String get rattiLabel => 'Ratti';

  @override
  String get rattiInfo => '1 Ratti = 0.1215 gramo';

  @override
  String get rattiHint => 'hal. 96.75';

  @override
  String get rattiSemanticLabel => 'Input field para sa bigat ng Ratti';

  @override
  String get lalLabel => 'Lal';

  @override
  String get lalInfo => '1 Lal = 0.1166 grams = 0.01 Tola (100 Lal = 1 Tola)';

  @override
  String get lalHint => 'e.g. 25';

  @override
  String get lalSemanticLabel => 'Lal weight input field';

  @override
  String get gramLabel => 'Gramo';

  @override
  String get gramInfo => 'Direktang input ng gramo';

  @override
  String get gramHint => 'hal. 11.66';

  @override
  String get gramSemanticLabel => 'Input field para sa bigat ng Gramo';

  @override
  String get goldRateLabel => 'Presyo ng Ginto';

  @override
  String get goldRateInfo => 'Kasalukuyang presyo sa merkado bawat yunit';

  @override
  String get goldRateHint => 'hal. 150,000';

  @override
  String get goldRateSemanticLabel => 'Input field para sa presyo ng ginto';

  @override
  String get calculateButton => 'Kalkulahin';

  @override
  String get calculateSemanticLabel =>
      'Kalkulahin ang conversion ng bigat ng ginto';

  @override
  String get clearAllButton => 'I-clear Lahat';

  @override
  String get clearAllSemanticLabel => 'I-clear ang lahat ng input field';

  @override
  String get conversionDetails => 'Mga Detalye ng Conversion';

  @override
  String tolaConversion(String value, String factor, String result) {
    return 'Tola: $value × $factor = $result gramo';
  }

  @override
  String mashaConversion(String value, String factor, String result) {
    return 'Masha: $value × $factor = $result gramo';
  }

  @override
  String anaConversion(String value, String factor, String result) {
    return 'Ana: $value × $factor = $result gramo';
  }

  @override
  String rattiConversion(String value, String factor, String result) {
    return 'Ratti: $value × $factor = $result gramo';
  }

  @override
  String lalConversion(String value, String factor, String result) {
    return 'Lal: $value × $factor = $result grams';
  }

  @override
  String gramConversion(String value) {
    return 'Gramo: $value gramo';
  }

  @override
  String totalWeight(String value) {
    return 'Kabuuang Bigat: $value gramo';
  }

  @override
  String get convertedTo => 'Na-convert sa:';

  @override
  String tolaResult(String value) {
    return 'Tola: $value';
  }

  @override
  String lalResult(String value) {
    return 'Lal: $value';
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
    return 'Presyo ng Ginto: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(Presyo: $rate bawat $unit)';
  }

  @override
  String get unitTola => 'Tola';

  @override
  String get unitLal => 'Lal';

  @override
  String get unitTenGram => '10 Gramo';

  @override
  String get unitOneGram => '1 Gramo';

  @override
  String enterValueHint(String label) {
    return 'Ilagay ang halaga ng $label';
  }

  @override
  String inputFieldSemantic(String label) {
    return 'Input field ng $label';
  }

  @override
  String unitSelectorSemantic(String label) {
    return 'Tagapili ng yunit ng $label';
  }

  @override
  String get converterTabLabel => 'Converter';

  @override
  String get settingsTabLabel => 'Mga Setting';

  @override
  String get settingsTitle => 'Mga Setting';

  @override
  String get settingsThemeLabel => 'Tema';

  @override
  String get themeLight => 'Maliwanag';

  @override
  String get themeDark => 'Madilim';

  @override
  String get darkModeLabel => 'Dark Mode';

  @override
  String get darkModeSubtitle =>
      'Lumipat sa pagitan ng madilim at maliwanag na tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get settingsLanguageLabel => 'Wika';

  @override
  String get settingsCurrencyLabel => 'Pera';

  @override
  String get currencySelectionPrompt => 'Piliin ang iyong pera';

  @override
  String get currencySearchHint =>
      'Maghanap gamit ang code, pangalan, o simbolo';

  @override
  String get currencySearchEmpty => 'Walang tugmang pera';

  @override
  String get languageSelectionPrompt => 'Mangyaring piliin ang iyong wika';

  @override
  String get languageEnglish => 'Ingles';

  @override
  String get languageUrdu => 'Urdu';

  @override
  String get languageArabic => 'Arabe';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languageTurkish => 'Turkish';

  @override
  String get languageNote => 'Parating na ang iba pang mga wika';

  @override
  String get settingsAboutLabel => 'Tungkol';

  @override
  String get aboutVersion => 'Bersyon';

  @override
  String get aboutDescription =>
      'Ang Gold Weight Converter ay isang simple at mabisang tool para sa pag-convert sa pagitan ng iba\'t ibang tradisyonal na yunit ng bigat ng ginto at mga gramo.';

  @override
  String get unknownLabel => 'Hindi kilala';

  @override
  String get zakatMenuLabel => 'Zakat sa Ginto';

  @override
  String get zakatScreenTitle => 'Zakat sa Ginto';

  @override
  String get zakatDisclaimer =>
      'Tulong lamang para sa mga gamit na ginto — hindi isang kumpletong pagtatasa ng zakat o relihiyosong hatol. Ang ibang ari-arian at nisab ay iyong responsibilidad; kumonsulta sa isang lokal na iskolar.';

  @override
  String get zakatRateInfo =>
      'Presyo sa merkado para sa 24K / purong ginto bawat yunit';

  @override
  String get zakatItemsTitle => 'Ang iyong mga gintong bagay';

  @override
  String get zakatAddItem => 'Magdagdag ng bagay';

  @override
  String get zakatEditItem => 'I-edit ang bagay';

  @override
  String get zakatEmptyItems =>
      'Wala pang mga gintong bagay. Magdagdag ng alahas o gold bar upang kalkulahin ang zakat.';

  @override
  String get zakatItemNameLabel => 'Pangalan (opsyonal)';

  @override
  String get zakatItemNameHint => 'hal. Singsing sa kasal';

  @override
  String get zakatWeightLabel => 'Bigat';

  @override
  String get zakatWeightHint => 'hal. 10';

  @override
  String get zakatWeightUnitLabel => 'Yunit';

  @override
  String get zakatPurityLabel => 'Kadalisayan';

  @override
  String get zakatCustomKaratLabel => 'Custom karat (1–24)';

  @override
  String get zakatCustomKaratHint => 'hal. 20';

  @override
  String get zakatPurity24k => '24K (puro)';

  @override
  String get zakatPurity22k => '22K';

  @override
  String get zakatPurity21k => '21K';

  @override
  String get zakatPurity18k => '18K';

  @override
  String get zakatPurityCustom => 'Custom';

  @override
  String get zakatSaveItem => 'I-save';

  @override
  String get zakatDeleteItem => 'Tanggalin';

  @override
  String get zakatDeleteConfirmTitle => 'Tanggalin ang gintong bagay?';

  @override
  String zakatDeleteConfirmMessage(String name) {
    return 'Aalisin nito ang \"$name\" sa iyong listahan ng zakat.';
  }

  @override
  String get zakatCancel => 'Kanselahin';

  @override
  String get zakatUntitledItem => 'Gintong bagay';

  @override
  String get zakatSummaryTitle => 'Buod ng Zakat';

  @override
  String get zakatTotalPureGold => 'Kabuuang purong ginto';

  @override
  String zakatPureGoldValue(String grams, String tola) {
    return '$grams g ($tola tola)';
  }

  @override
  String get zakatTotalValue => 'Tinatayang halaga';

  @override
  String get zakatDueLabel => 'Zakat sa mga bagay na ito (2.5%)';

  @override
  String get zakatEnterRatePrompt =>
      'Ilagay ang presyo ng ginto upang matantya ang halaga at zakat';

  @override
  String get zakatCalculateButton => 'Kalkulahin ang zakat';

  @override
  String zakatItemDetail(String weight, String unit, String purity) {
    return '$weight $unit · $purity';
  }

  @override
  String get zakatValidationWeight => 'Maglagay ng bigat na mas mataas sa zero';

  @override
  String get zakatValidationKarat => 'Maglagay ng karat sa pagitan ng 1 at 24';

  @override
  String get copyResults => 'Kopyahin';

  @override
  String get shareResults => 'Ibahagi';

  @override
  String get resultsCopied => 'Nakopya sa clipboard';

  @override
  String get privacyPolicyLabel => 'Patakaran sa Pagkapribado';

  @override
  String get rateAppLabel => 'I-rate ang app';

  @override
  String get moreAppsLabel => 'Higit pang mga app';

  @override
  String get shareAppLabel => 'Ibahagi ang app';

  @override
  String shareAppMessage(String url) {
    return 'Subukan ang Gold Weight Converter: $url';
  }

  @override
  String get openLinkFailed => 'Hindi mabuksan ang link';

  @override
  String get appUpdateReady =>
      'Na-download na ang update. I-restart upang mai-install.';

  @override
  String get appUpdateRestart => 'I-restart';
}
