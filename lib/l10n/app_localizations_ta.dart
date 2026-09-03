// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appTitle => 'தங்க எடை மாற்றி';

  @override
  String get validationValidNumber => 'சரியான எண்ணை உள்ளிடவும்';

  @override
  String get validationPositiveNumber => 'நேர்மறை எண்ணை உள்ளிடவும்';

  @override
  String get tolaLabel => 'தோலா';

  @override
  String get tolaInfo => '1 தோலா = 11.66 கிராம் = 12 மாஷா = 16 ஆனா = 96 ரத்தி';

  @override
  String get tolaHint => 'எ.கா. 2.5';

  @override
  String get tolaSemanticLabel => 'தோலா எடை உள்ளீட்டு புலம்';

  @override
  String get mashaLabel => 'மாஷா';

  @override
  String get mashaInfo => '1 மாஷா = 0.972 கிராம் = 1.333 ஆனா = 8 ரத்தி';

  @override
  String get mashaHint => 'எ.கா. 12.5';

  @override
  String get mashaSemanticLabel => 'மாஷா எடை உள்ளீட்டு புலம்';

  @override
  String get anaLabel => 'ஆனா';

  @override
  String get anaInfo => '1 ஆனா = 0.72875 கிராம் = 6 ரத்தி';

  @override
  String get anaHint => 'எ.கா. 16.25';

  @override
  String get anaSemanticLabel => 'ஆனா எடை உள்ளீட்டு புலம்';

  @override
  String get rattiLabel => 'ரத்தி';

  @override
  String get rattiInfo => '1 ரத்தி = 0.1215 கிராம்';

  @override
  String get rattiHint => 'எ.கா. 96.75';

  @override
  String get rattiSemanticLabel => 'ரத்தி எடை உள்ளீட்டு புலம்';

  @override
  String get lalLabel => 'Lal';

  @override
  String get lalInfo => '1 Lal = 0.1166 grams = 0.01 Tola (100 Lal = 1 Tola)';

  @override
  String get lalHint => 'e.g. 25';

  @override
  String get lalSemanticLabel => 'Lal weight input field';

  @override
  String get gramLabel => 'கிராம்';

  @override
  String get gramInfo => 'நேரடி கிராம் உள்ளீடு';

  @override
  String get gramHint => 'எ.கா. 11.66';

  @override
  String get gramSemanticLabel => 'கிராம் எடை உள்ளீட்டு புலம்';

  @override
  String get goldRateLabel => 'தங்க விலை';

  @override
  String get goldRateInfo => 'ஒரு யூனிட்டுக்கான தற்போதைய சந்தை விலை';

  @override
  String get goldRateHint => 'எ.கா. 150,000';

  @override
  String get goldRateSemanticLabel => 'தங்க விலை உள்ளீட்டு புலம்';

  @override
  String get calculateButton => 'கணக்கிடு';

  @override
  String get calculateSemanticLabel => 'தங்க எடை மாற்றத்தை கணக்கிடு';

  @override
  String get clearAllButton => 'அனைத்தையும் அழி';

  @override
  String get clearAllSemanticLabel => 'அனைத்து உள்ளீட்டு புலங்களையும் அழி';

  @override
  String get conversionDetails => 'மாற்ற விவரங்கள்';

  @override
  String tolaConversion(String value, String factor, String result) {
    return 'தோலா: $value × $factor = $result கிராம்';
  }

  @override
  String mashaConversion(String value, String factor, String result) {
    return 'மாஷா: $value × $factor = $result கிராம்';
  }

  @override
  String anaConversion(String value, String factor, String result) {
    return 'ஆனா: $value × $factor = $result கிராம்';
  }

  @override
  String rattiConversion(String value, String factor, String result) {
    return 'ரத்தி: $value × $factor = $result கிராம்';
  }

  @override
  String lalConversion(String value, String factor, String result) {
    return 'Lal: $value × $factor = $result grams';
  }

  @override
  String gramConversion(String value) {
    return 'கிராம்: $value கிராம்';
  }

  @override
  String totalWeight(String value) {
    return 'மொத்த எடை: $value கிராம்';
  }

  @override
  String get convertedTo => 'மாற்றப்பட்டது:';

  @override
  String tolaResult(String value) {
    return 'தோலா: $value';
  }

  @override
  String lalResult(String value) {
    return 'Lal: $value';
  }

  @override
  String mashaResult(String value) {
    return 'மாஷா: $value';
  }

  @override
  String anaResult(String value) {
    return 'ஆனா: $value';
  }

  @override
  String rattiResult(String value) {
    return 'ரத்தி: $value';
  }

  @override
  String goldPrice(String price) {
    return 'தங்கத்தின் மதிப்பு: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(விலை: $unitக்கு $rate)';
  }

  @override
  String get unitTola => 'தோலா';

  @override
  String get unitLal => 'Lal';

  @override
  String get unitTenGram => '10 கிராம்';

  @override
  String get unitOneGram => '1 கிராம்';

  @override
  String enterValueHint(String label) {
    return '$label மதிப்பை உள்ளிடவும்';
  }

  @override
  String inputFieldSemantic(String label) {
    return '$label உள்ளீட்டு புலம்';
  }

  @override
  String unitSelectorSemantic(String label) {
    return '$label யூனிட் தேர்வு';
  }

  @override
  String get converterTabLabel => 'மாற்றி';

  @override
  String get settingsTabLabel => 'அமைப்புகள்';

  @override
  String get settingsTitle => 'அமைப்புகள்';

  @override
  String get settingsThemeLabel => 'தீம்';

  @override
  String get themeLight => 'வெளிச்சம்';

  @override
  String get themeDark => 'இருள்';

  @override
  String get darkModeLabel => 'டார்க் மோட்';

  @override
  String get darkModeSubtitle =>
      'டார்க் மற்றும் லைட் தீம்களுக்கு இடையில் மாறவும்';

  @override
  String get themeSystem => 'அமைப்பு';

  @override
  String get settingsLanguageLabel => 'மொழி';

  @override
  String get settingsCurrencyLabel => 'நாணயம்';

  @override
  String get currencySelectionPrompt => 'உங்கள் நாணயத்தைத் தேர்ந்தெடுக்கவும்';

  @override
  String get currencySearchHint =>
      'குறியீடு, பெயர் அல்லது சின்னம் மூலம் தேடவும்';

  @override
  String get currencySearchEmpty => 'பொருந்தும் நாணயம் எதுவும் இல்லை';

  @override
  String get languageSelectionPrompt => 'உங்கள் மொழியைத் தேர்ந்தெடுக்கவும்';

  @override
  String get languageEnglish => 'ஆங்கிலம்';

  @override
  String get languageUrdu => 'உருது';

  @override
  String get languageArabic => 'அரபு';

  @override
  String get languageHindi => 'இந்தி';

  @override
  String get languageTurkish => 'துருக்கிய';

  @override
  String get languageNote => 'மேலும் மொழிகள் விரைவில் வரவுள்ளன';

  @override
  String get settingsAboutLabel => 'பற்றி';

  @override
  String get aboutVersion => 'பதிப்பு';

  @override
  String get aboutDescription =>
      'தங்க எடை மாற்றி என்பது பாரம்பரிய தங்க எடை அலகுகள் மற்றும் கிராம்களுக்கு இடையில் எளிதாக மாற்றுவதற்கான ஒரு எளிய கருவியாகும்.';

  @override
  String get unknownLabel => 'தெரியாதது';

  @override
  String get zakatMenuLabel => 'தங்க ஜகாத்';

  @override
  String get zakatScreenTitle => 'தங்க ஜகாத்';

  @override
  String get zakatDisclaimer =>
      'தங்கப் பொருட்களுக்கு மட்டுமேயான வழிகாட்டி — முழுமையான ஜகாத் மதிப்பீடு அல்லது மார்க்க தீர்ப்பு அல்ல. பிற சொத்துக்கள் மற்றும் நிஸாப் உங்கள் பொறுப்பு; ஒரு மார்க்க அறிஞரிடம் ஆலோசிக்கவும்.';

  @override
  String get zakatRateInfo => '24K / தூய தங்கத்திற்கான சந்தை விலை';

  @override
  String get zakatItemsTitle => 'உங்கள் தங்கப் பொருட்கள்';

  @override
  String get zakatAddItem => 'பொருளைச் சேர்';

  @override
  String get zakatEditItem => 'பொருளைத் திருத்து';

  @override
  String get zakatEmptyItems =>
      'தங்கப் பொருட்கள் எதுவும் இல்லை. ஜகாத் கணக்கிட நகைகள் அல்லது தங்கக் கட்டிகளைச் சேர்க்கவும்.';

  @override
  String get zakatItemNameLabel => 'பெயர் (விருப்பமானது)';

  @override
  String get zakatItemNameHint => 'எ.கா. திருமண மோதிரம்';

  @override
  String get zakatWeightLabel => 'எடை';

  @override
  String get zakatWeightHint => 'எ.கா. 10';

  @override
  String get zakatWeightUnitLabel => 'அலகு';

  @override
  String get zakatPurityLabel => 'தூய்மை (கேரட்)';

  @override
  String get zakatCustomKaratLabel => 'தனிப்பயன் கேரட் (1–24)';

  @override
  String get zakatCustomKaratHint => 'எ.கா. 20';

  @override
  String get zakatPurity24k => '24K (தூய)';

  @override
  String get zakatPurity22k => '22K';

  @override
  String get zakatPurity21k => '21K';

  @override
  String get zakatPurity18k => '18K';

  @override
  String get zakatPurityCustom => 'தனிப்பயன்';

  @override
  String get zakatSaveItem => 'சேமி';

  @override
  String get zakatDeleteItem => 'நீக்கு';

  @override
  String get zakatDeleteConfirmTitle => 'தங்கப் பொருளை நீக்கவா?';

  @override
  String zakatDeleteConfirmMessage(String name) {
    return 'இது உங்கள் ஜகாத் பட்டியலிலிருந்து \"$name\" ஐ நீக்கும்.';
  }

  @override
  String get zakatCancel => 'ரத்துசெய்';

  @override
  String get zakatUntitledItem => 'தங்கப் பொருள்';

  @override
  String get zakatSummaryTitle => 'ஜகாத் சுருக்கம்';

  @override
  String get zakatTotalPureGold => 'மொத்த தூய தங்கம்';

  @override
  String zakatPureGoldValue(String grams, String tola) {
    return '$grams g ($tola தோலா)';
  }

  @override
  String get zakatTotalValue => 'மதிப்பிடப்பட்ட மதிப்பு';

  @override
  String get zakatDueLabel => 'செலுத்த வேண்டிய ஜகாத் (2.5%)';

  @override
  String get zakatEnterRatePrompt =>
      'மதிப்பு மற்றும் ஜகாத்தை மதிப்பிட தங்க விலையை உள்ளிடவும்';

  @override
  String get zakatCalculateButton => 'ஜகாத்தை கணக்கிடு';

  @override
  String zakatItemDetail(String weight, String unit, String purity) {
    return '$weight $unit · $purity';
  }

  @override
  String get zakatValidationWeight =>
      'பூஜ்ஜியத்தை விட அதிகமான எடையை உள்ளிடவும்';

  @override
  String get zakatValidationKarat => '1 முதல் 24 வரை கேரட்டை உள்ளிடவும்';

  @override
  String get copyResults => 'நகலெடு';

  @override
  String get shareResults => 'பகிர்';

  @override
  String get resultsCopied => 'கிளிப்போர்டுக்கு நகலெடுக்கப்பட்டது';

  @override
  String get privacyPolicyLabel => 'தனியுரிமைக் கொள்கை';

  @override
  String get rateAppLabel => 'பயன்பாட்டை மதிப்பிடவும்';

  @override
  String get moreAppsLabel => 'மேலும் பயன்பாடுகள்';

  @override
  String get shareAppLabel => 'பயன்பாட்டைப் பகிரவும்';

  @override
  String shareAppMessage(String url) {
    return 'தங்க எடை மாற்றியைப் பயன்படுத்தவும்: $url';
  }

  @override
  String get openLinkFailed => 'இணைப்பைத் திறக்க முடியவில்லை';

  @override
  String get appUpdateReady =>
      'புதுப்பிப்பு பதிவிறக்கம் செய்யப்பட்டது. நிறுவ மீண்டும் தொடங்கவும்.';

  @override
  String get appUpdateRestart => 'மீண்டும் தொடங்கு';
}
