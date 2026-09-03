// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class AppLocalizationsAm extends AppLocalizations {
  AppLocalizationsAm([String locale = 'am']) : super(locale);

  @override
  String get appTitle => 'የወርቅ ክብደት መለወጫ';

  @override
  String get validationValidNumber => 'እባክዎ ትክክለኛ ቁጥር ያስገቡ';

  @override
  String get validationPositiveNumber => 'እባክዎ አዎንታዊ ቁጥር ያስገቡ';

  @override
  String get tolaLabel => 'ቶላ';

  @override
  String get tolaInfo => '1 ቶላ = 11.66 ግራም = 12 ማሻ = 16 አና = 96 ራቲ';

  @override
  String get tolaHint => 'ለምሳሌ 2.5';

  @override
  String get tolaSemanticLabel => 'የቶላ ክብደት ማስገቢያ መስክ';

  @override
  String get mashaLabel => 'ማሻ';

  @override
  String get mashaInfo => '1 ማሻ = 0.972 ግራም = 1.333 አና = 8 ራቲ';

  @override
  String get mashaHint => 'ለምሳሌ 12.5';

  @override
  String get mashaSemanticLabel => 'የማሻ ክብደት ማስገቢያ መስክ';

  @override
  String get anaLabel => 'አና';

  @override
  String get anaInfo => '1 አና = 0.72875 ግራም = 6 ራቲ';

  @override
  String get anaHint => 'ለምሳሌ 16.25';

  @override
  String get anaSemanticLabel => 'የአና ክብደት ማስገቢያ መስክ';

  @override
  String get rattiLabel => 'ራቲ';

  @override
  String get rattiInfo => '1 ራቲ = 0.1215 ግራም';

  @override
  String get rattiHint => 'ለምሳሌ 96.75';

  @override
  String get rattiSemanticLabel => 'የራቲ ክብደት ማስገቢያ መስክ';

  @override
  String get lalLabel => 'Lal';

  @override
  String get lalInfo => '1 Lal = 0.1166 grams = 0.01 Tola (100 Lal = 1 Tola)';

  @override
  String get lalHint => 'e.g. 25';

  @override
  String get lalSemanticLabel => 'Lal weight input field';

  @override
  String get gramLabel => 'ግራም';

  @override
  String get gramInfo => 'ቀጥተኛ የክብደት ማስገቢያ በግራም';

  @override
  String get gramHint => 'ለምሳሌ 11.66';

  @override
  String get gramSemanticLabel => 'የግራም ክብደት ማስገቢያ መስክ';

  @override
  String get goldRateLabel => 'የወርቅ ዋጋ';

  @override
  String get goldRateInfo => 'ወቅታዊ የገበያ ዋጋ በአንድ ክፍል';

  @override
  String get goldRateHint => 'ለምሳሌ 150,000';

  @override
  String get goldRateSemanticLabel => 'የወርቅ ዋጋ ማስገቢያ መስክ';

  @override
  String get calculateButton => 'አስላ';

  @override
  String get calculateSemanticLabel => 'የወርቅ ክብደት ለውጥን አስላ';

  @override
  String get clearAllButton => 'ሁሉንም አጽዳ';

  @override
  String get clearAllSemanticLabel => 'ሁሉንም የመረጃ መስኮች አጽዳ';

  @override
  String get conversionDetails => 'የለውጡ ዝርዝር';

  @override
  String tolaConversion(String value, String factor, String result) {
    return 'ቶላ: $value × $factor = $result ግራም';
  }

  @override
  String mashaConversion(String value, String factor, String result) {
    return 'ማሻ: $value × $factor = $result ግራም';
  }

  @override
  String anaConversion(String value, String factor, String result) {
    return 'አና: $value × $factor = $result ግራም';
  }

  @override
  String rattiConversion(String value, String factor, String result) {
    return 'ራቲ: $value × $factor = $result ግራም';
  }

  @override
  String lalConversion(String value, String factor, String result) {
    return 'Lal: $value × $factor = $result grams';
  }

  @override
  String gramConversion(String value) {
    return 'ግራም: $value ግራም';
  }

  @override
  String totalWeight(String value) {
    return 'ጠቅላላ ክብደት: $value ግራም';
  }

  @override
  String get convertedTo => 'የተለወጠው ወደ:';

  @override
  String tolaResult(String value) {
    return 'ቶላ: $value';
  }

  @override
  String lalResult(String value) {
    return 'Lal: $value';
  }

  @override
  String mashaResult(String value) {
    return 'ማሻ: $value';
  }

  @override
  String anaResult(String value) {
    return 'አና: $value';
  }

  @override
  String rattiResult(String value) {
    return 'ራቲ: $value';
  }

  @override
  String goldPrice(String price) {
    return 'የወርቅ ዋጋ: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(ዋጋ: $rate በ $unit)';
  }

  @override
  String get unitTola => 'ቶላ';

  @override
  String get unitLal => 'Lal';

  @override
  String get unitTenGram => '10 ግራም';

  @override
  String get unitOneGram => '1 ግራም';

  @override
  String enterValueHint(String label) {
    return 'የ$label ዋጋ ያስገቡ';
  }

  @override
  String inputFieldSemantic(String label) {
    return 'የ$label ማስገቢያ መስክ';
  }

  @override
  String unitSelectorSemantic(String label) {
    return 'የ$label መለኪያ መምረጫ';
  }

  @override
  String get converterTabLabel => 'መለወጫ';

  @override
  String get settingsTabLabel => 'ቅንብሮች';

  @override
  String get settingsTitle => 'ቅንብሮች';

  @override
  String get settingsThemeLabel => 'ገጽታ';

  @override
  String get themeLight => 'ብርሃን';

  @override
  String get themeDark => 'ጨለማ';

  @override
  String get darkModeLabel => 'ጨለማ ሁነታ';

  @override
  String get darkModeSubtitle => 'በጨለማ እና በብርሃን ገጽታዎች መካከል ይቀያይሩ';

  @override
  String get themeSystem => 'የስርዓቱ';

  @override
  String get settingsLanguageLabel => 'ቋንቋ';

  @override
  String get settingsCurrencyLabel => 'የገንዘብ ምንዛሬ';

  @override
  String get currencySelectionPrompt => 'የገንዘብ ምንዛሬዎን ይምረጡ';

  @override
  String get currencySearchHint => 'በኮድ፣ በስም ወይም በምልክት ይፈልጉ';

  @override
  String get currencySearchEmpty => 'ከፍለጋዎ ጋር የሚዛመድ ምንዛሬ አልተገኘም';

  @override
  String get languageSelectionPrompt => 'እባክዎ ቋንቋዎን ይምረጡ';

  @override
  String get languageEnglish => 'እንግሊዝኛ';

  @override
  String get languageUrdu => 'ኡርዱ';

  @override
  String get languageArabic => 'አረብኛ';

  @override
  String get languageHindi => 'ሂንዲ';

  @override
  String get languageTurkish => 'ቱርክኛ';

  @override
  String get languageNote => 'ተጨማሪ ቋንቋዎች በቅርቡ ይመጣሉ';

  @override
  String get settingsAboutLabel => 'ስለ መተግበሪያው';

  @override
  String get aboutVersion => 'ስሪት';

  @override
  String get aboutDescription =>
      'የወርቅ ክብደት መለወጫ በባህላዊ የወርቅ መለኪያ ክፍሎች እና በግራም መካከል ለመለወጥ የሚያስችል ቀላል እና ቀልጣፋ መተግበሪያ ነው።';

  @override
  String get unknownLabel => 'ያልታወቀ';

  @override
  String get zakatMenuLabel => 'የወርቅ ዘካ';

  @override
  String get zakatScreenTitle => 'የወርቅ ዘካ';

  @override
  String get zakatDisclaimer =>
      'ለወርቅ ዕቃዎች ብቻ የሚረዳ መሣሪያ — ሙሉ የዘካ ውሳኔ ወይም ሃይማኖታዊ ፈትዋ አይደለም። ሌሎች ንብረቶች እና ኒሳብ የእርስዎ ኃላፊነት ናቸው፤ የሃይማኖት አዋቂን ያማክሩ።';

  @override
  String get zakatRateInfo => 'የ24 ካራት / ንጹህ ወርቅ ወቅታዊ የገበያ ዋጋ';

  @override
  String get zakatItemsTitle => 'የወርቅ ዕቃዎችዎ';

  @override
  String get zakatAddItem => 'ዕቃ ያክሉ';

  @override
  String get zakatEditItem => 'ዕቃ ያርትዑ';

  @override
  String get zakatEmptyItems =>
      'እስካሁን ምንም የወርቅ ዕቃ የለም። ዘካ ለማስላት ጌጣጌጥ ወይም የወርቅ ሰሌዳዎችን ያክሉ።';

  @override
  String get zakatItemNameLabel => 'ስም (አማራጭ)';

  @override
  String get zakatItemNameHint => 'ለምሳሌ የሠርግ ቀለበት';

  @override
  String get zakatWeightLabel => 'ክብደት';

  @override
  String get zakatWeightHint => 'ለምሳሌ 10';

  @override
  String get zakatWeightUnitLabel => 'መለኪያ';

  @override
  String get zakatPurityLabel => 'ጥራት';

  @override
  String get zakatCustomKaratLabel => 'ብጁ ካራት (1–24)';

  @override
  String get zakatCustomKaratHint => 'ለምሳሌ 20';

  @override
  String get zakatPurity24k => '24 ካራት (ንጹህ)';

  @override
  String get zakatPurity22k => '22 ካራት';

  @override
  String get zakatPurity21k => '21 ካራት';

  @override
  String get zakatPurity18k => '18 ካራት';

  @override
  String get zakatPurityCustom => 'ብጁ';

  @override
  String get zakatSaveItem => 'አስቀምጥ';

  @override
  String get zakatDeleteItem => 'ሰርዝ';

  @override
  String get zakatDeleteConfirmTitle => 'የወርቅ ዕቃውን ይሰርዙ?';

  @override
  String zakatDeleteConfirmMessage(String name) {
    return 'ይህ \"$name\"ን ከዘካ ዝርዝርዎ ውስጥ ያስወግደዋል።';
  }

  @override
  String get zakatCancel => 'ይቅር';

  @override
  String get zakatUntitledItem => 'የወርቅ ዕቃ';

  @override
  String get zakatSummaryTitle => 'የዘካ ማጠቃለያ';

  @override
  String get zakatTotalPureGold => 'ጠቅላላ ንጹህ ወርቅ';

  @override
  String zakatPureGoldValue(String grams, String tola) {
    return '$grams ግራም ($tola ቶላ)';
  }

  @override
  String get zakatTotalValue => 'የተገመተ ዋጋ';

  @override
  String get zakatDueLabel => 'ለእነዚህ ዕቃዎች የሚከፈል ዘካ (2.5%)';

  @override
  String get zakatEnterRatePrompt => 'ዋጋን እና ዘካን ለመገመት የወርቅ ዋጋ ያስገቡ';

  @override
  String get zakatCalculateButton => 'ዘካ አስላ';

  @override
  String zakatItemDetail(String weight, String unit, String purity) {
    return '$weight $unit · $purity';
  }

  @override
  String get zakatValidationWeight => 'ከዜሮ በላይ የሆነ ክብደት ያስገቡ';

  @override
  String get zakatValidationKarat => 'በ1 እና 24 መካከል ያለ ካራት ያስገቡ';

  @override
  String get copyResults => 'ገልብጥ';

  @override
  String get shareResults => 'አጋራ';

  @override
  String get resultsCopied => 'ወደ ቅንጥብ ሰሌዳ ተገልብጧል';

  @override
  String get privacyPolicyLabel => 'የግላዊነት ፖሊሲ';

  @override
  String get rateAppLabel => 'መተግበሪያውን ደረጃ ይስጡ';

  @override
  String get moreAppsLabel => 'ተጨማሪ መተግበሪያዎች';

  @override
  String get shareAppLabel => 'መተግበሪያውን ያጋሩ';

  @override
  String shareAppMessage(String url) {
    return 'የወርቅ ክብደት መለወጫን ይሞክሩ: $url';
  }

  @override
  String get openLinkFailed => 'ሊንኩን መክፈት አልተቻለም';

  @override
  String get appUpdateReady => 'ዝመናው ወርዷል። ለመጫን መተግበሪያውን እንደገና ያስጀምሩ።';

  @override
  String get appUpdateRestart => 'እንደገና አስጀምር';
}
