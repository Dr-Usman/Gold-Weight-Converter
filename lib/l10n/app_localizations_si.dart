// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Sinhala Sinhalese (`si`).
class AppLocalizationsSi extends AppLocalizations {
  AppLocalizationsSi([String locale = 'si']) : super(locale);

  @override
  String get appTitle => 'රන් බර පරිවර්තකය';

  @override
  String get validationValidNumber => 'කරුණාකර වලංගු අංකයක් ඇතුළත් කරන්න';

  @override
  String get validationPositiveNumber => 'කරුණාකර ධන අංකයක් ඇතුළත් කරන්න';

  @override
  String get tolaLabel => 'තෝලා';

  @override
  String get tolaInfo => '1 තෝලා = ග්‍රෑම් 11.66 = මාෂා 12 = ආනා 16 = රත්ති 96';

  @override
  String get tolaHint => 'උදා: 2.5';

  @override
  String get tolaSemanticLabel => 'තෝලා බර ඇතුළත් කිරීමේ ක්ෂේත්‍රය';

  @override
  String get mashaLabel => 'මාෂා';

  @override
  String get mashaInfo => '1 මාෂා = ග්‍රෑම් 0.972 = ආනා 1.333 = රත්ති 8';

  @override
  String get mashaHint => 'උදා: 12.5';

  @override
  String get mashaSemanticLabel => 'මාෂා බර ඇතුළත් කිරීමේ ක්ෂේත්‍රය';

  @override
  String get anaLabel => 'ආනා';

  @override
  String get anaInfo => '1 ආනා = ග්‍රෑම් 0.72875 = රත්ති 6';

  @override
  String get anaHint => 'උදා: 16.25';

  @override
  String get anaSemanticLabel => 'ආනා බර ඇතුළත් කිරීමේ ක්ෂේත්‍රය';

  @override
  String get rattiLabel => 'රත්ති';

  @override
  String get rattiInfo => '1 රත්ති = ග්‍රෑම් 0.1215';

  @override
  String get rattiHint => 'උදා: 96.75';

  @override
  String get rattiSemanticLabel => 'රත්ති බර ඇතුළත් කිරීමේ ක්ෂේත්‍රය';

  @override
  String get lalLabel => 'Lal';

  @override
  String get lalInfo => '1 Lal = 0.1166 grams = 0.01 Tola (100 Lal = 1 Tola)';

  @override
  String get lalHint => 'e.g. 25';

  @override
  String get lalSemanticLabel => 'Lal weight input field';

  @override
  String get gramLabel => 'ග්‍රෑම්';

  @override
  String get gramInfo => 'සෘජු ග්‍රෑම් ආදානය';

  @override
  String get gramHint => 'උදා: 11.66';

  @override
  String get gramSemanticLabel => 'ග්‍රෑම් බර ඇතුළත් කිරීමේ ක්ෂේත්‍රය';

  @override
  String get goldRateLabel => 'රන් මිල';

  @override
  String get goldRateInfo => 'ඒකකයකට වත්මන් වෙළඳපල මිල';

  @override
  String get goldRateHint => 'උදා: 150,000';

  @override
  String get goldRateSemanticLabel => 'රන් මිල ඇතුළත් කිරීමේ ක්ෂේත්‍රය';

  @override
  String get calculateButton => 'ගණනය කරන්න';

  @override
  String get calculateSemanticLabel => 'රන් බර පරිවර්තනය ගණනය කරන්න';

  @override
  String get clearAllButton => 'සියල්ල හිස් කරන්න';

  @override
  String get clearAllSemanticLabel => 'සියලු ආදාන ක්ෂේත්‍ර හිස් කරන්න';

  @override
  String get conversionDetails => 'පරිවර්තන විස්තර';

  @override
  String tolaConversion(String value, String factor, String result) {
    return 'තෝලා: $value × $factor = $result ග්‍රෑම්';
  }

  @override
  String mashaConversion(String value, String factor, String result) {
    return 'මාෂා: $value × $factor = $result ග්‍රෑම්';
  }

  @override
  String anaConversion(String value, String factor, String result) {
    return 'ආනා: $value × $factor = $result ග්‍රෑම්';
  }

  @override
  String rattiConversion(String value, String factor, String result) {
    return 'රත්ති: $value × $factor = $result ග්‍රෑම්';
  }

  @override
  String lalConversion(String value, String factor, String result) {
    return 'Lal: $value × $factor = $result grams';
  }

  @override
  String gramConversion(String value) {
    return 'ග්‍රෑම්: $value ග්‍රෑම්';
  }

  @override
  String totalWeight(String value) {
    return 'මුළු බර: $value ග්‍රෑම්';
  }

  @override
  String get convertedTo => 'පරිවර්තනය කරන ලදි:';

  @override
  String tolaResult(String value) {
    return 'තෝලා: $value';
  }

  @override
  String lalResult(String value) {
    return 'Lal: $value';
  }

  @override
  String mashaResult(String value) {
    return 'මාෂා: $value';
  }

  @override
  String anaResult(String value) {
    return 'ආනා: $value';
  }

  @override
  String rattiResult(String value) {
    return 'රත්ති: $value';
  }

  @override
  String goldPrice(String price) {
    return 'රන් වටිනාකම: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(මිල: $unitකට $rate)';
  }

  @override
  String get unitTola => 'තෝලා';

  @override
  String get unitLal => 'Lal';

  @override
  String get unitTenGram => 'ග්‍රෑම් 10';

  @override
  String get unitOneGram => 'ග්‍රෑම් 1';

  @override
  String enterValueHint(String label) {
    return '$label අගය ඇතුළත් කරන්න';
  }

  @override
  String inputFieldSemantic(String label) {
    return '$label ආදාන ක්ෂේත්‍රය';
  }

  @override
  String unitSelectorSemantic(String label) {
    return '$label ඒකක තේරීම';
  }

  @override
  String get converterTabLabel => 'පරිවර්තකය';

  @override
  String get settingsTabLabel => 'සැකසුම්';

  @override
  String get settingsTitle => 'සැකසුම්';

  @override
  String get settingsThemeLabel => 'තේමාව';

  @override
  String get themeLight => 'ලා පැහැති';

  @override
  String get themeDark => 'අඳුරු';

  @override
  String get darkModeLabel => 'අඳුරු ප්‍රකාරය';

  @override
  String get darkModeSubtitle => 'අඳුරු සහ ලා තේමාවන් අතර මාරු වන්න';

  @override
  String get themeSystem => 'පද්ධතිය';

  @override
  String get settingsLanguageLabel => 'භාෂාව';

  @override
  String get settingsCurrencyLabel => 'මුදල් ඒකකය';

  @override
  String get currencySelectionPrompt => 'ඔබේ මුදල් ඒකකය තෝරන්න';

  @override
  String get currencySearchHint => 'කේතය, නම හෝ සංකේතය මගින් සොයන්න';

  @override
  String get currencySearchEmpty => 'ගැළපෙන මුදල් ඒකකයක් හමු නොවීය';

  @override
  String get languageSelectionPrompt => 'කරුණාකර ඔබේ භාෂාව තෝරන්න';

  @override
  String get languageEnglish => 'ඉංග්‍රීසි';

  @override
  String get languageUrdu => 'උර්දු';

  @override
  String get languageArabic => 'අරාබි';

  @override
  String get languageHindi => 'හින්දි';

  @override
  String get languageTurkish => 'තුර්කි';

  @override
  String get languageNote => 'තවත් භාෂා ළඟදීම පැමිණේ';

  @override
  String get settingsAboutLabel => 'යෙදුම ගැන';

  @override
  String get aboutVersion => 'අනුවාදය';

  @override
  String get aboutDescription =>
      'රන් බර පරිවර්තකය යනු සම්ප්‍රදායික රන් බර මිනුම් ඒකක සහ ග්‍රෑම් අතර පරිවර්තනය සඳහා සරල හා කාර්යක්ෂම මෙවලමකි.';

  @override
  String get unknownLabel => 'නොදනී';

  @override
  String get zakatMenuLabel => 'රන් සකාත්';

  @override
  String get zakatScreenTitle => 'රන් සකාත්';

  @override
  String get zakatDisclaimer =>
      'රන් භාණ්ඩ සඳහා පමණක් සහායකයෙකි — සම්පූර්ණ සකාත් තක්සේරුවක් හෝ ආගමික තීන්දුවක් නොවේ. වෙනත් වත්කම් සහ නිසාබ් ඔබේ වගකීමකි; දේශීය විද්වතෙකුගෙන් උපදෙස් ලබා ගන්න.';

  @override
  String get zakatRateInfo => '24K / පිරිසිදු රන් ඒකකයක වත්මන් වෙළඳපල මිල';

  @override
  String get zakatItemsTitle => 'ඔබේ රන් භාණ්ඩ';

  @override
  String get zakatAddItem => 'භාණ්ඩයක් එක් කරන්න';

  @override
  String get zakatEditItem => 'භාණ්ඩය සංස්කරණය කරන්න';

  @override
  String get zakatEmptyItems =>
      'තවමත් රන් භාණ්ඩ නොමැත. සකාත් ගණනය කිරීමට ආභරණ එක් කරන්න.';

  @override
  String get zakatItemNameLabel => 'නම (විකල්ප)';

  @override
  String get zakatItemNameHint => 'උදා: විවාහ මුදුව';

  @override
  String get zakatWeightLabel => 'බර';

  @override
  String get zakatWeightHint => 'උදා: 10';

  @override
  String get zakatWeightUnitLabel => 'ඒකකය';

  @override
  String get zakatPurityLabel => 'පාරිශුද්ධතාවය';

  @override
  String get zakatCustomKaratLabel => 'අභිරුචි කැරට් (1–24)';

  @override
  String get zakatCustomKaratHint => 'උදා: 20';

  @override
  String get zakatPurity24k => '24K (පිරිසිදු)';

  @override
  String get zakatPurity22k => '22K';

  @override
  String get zakatPurity21k => '21K';

  @override
  String get zakatPurity18k => '18K';

  @override
  String get zakatPurityCustom => 'අභිරුචි';

  @override
  String get zakatSaveItem => 'සුරකින්න';

  @override
  String get zakatDeleteItem => 'මකන්න';

  @override
  String get zakatDeleteConfirmTitle => 'රන් භාණ්ඩය මකන්නද?';

  @override
  String zakatDeleteConfirmMessage(String name) {
    return 'මෙය ඔබේ සකාත් ලැයිස්තුවෙන් \"$name\" ඉවත් කරනු ඇත.';
  }

  @override
  String get zakatCancel => 'අවලංගු කරන්න';

  @override
  String get zakatUntitledItem => 'රන් භාණ්ඩය';

  @override
  String get zakatSummaryTitle => 'සකාත් සාරාංශය';

  @override
  String get zakatTotalPureGold => 'මුළු පිරිසිදු රත්‍රන්';

  @override
  String zakatPureGoldValue(String grams, String tola) {
    return '$grams g ($tola තෝලා)';
  }

  @override
  String get zakatTotalValue => 'ඇස්තමේන්තුගත වටිනාකම';

  @override
  String get zakatDueLabel => 'මේ සඳහා අයවිය යුතු සකාත් (2.5%)';

  @override
  String get zakatEnterRatePrompt =>
      'වටිනාකම සහ සකාත් ඇස්තමේන්තු කිරීමට රන් මිල ඇතුළත් කරන්න';

  @override
  String get zakatCalculateButton => 'සකාත් ගණනය කරන්න';

  @override
  String zakatItemDetail(String weight, String unit, String purity) {
    return '$weight $unit · $purity';
  }

  @override
  String get zakatValidationWeight => 'ශුන්‍යයට වඩා වැඩි බරක් ඇතුළත් කරන්න';

  @override
  String get zakatValidationKarat => '1 සිට 24 දක්වා කැරට් අගයක් ඇතුළත් කරන්න';

  @override
  String get copyResults => 'පිටපත් කරන්න';

  @override
  String get shareResults => 'බෙදාගන්න';

  @override
  String get resultsCopied => 'පසුරු පුවරුවට පිටපත් කරන ලදි';

  @override
  String get privacyPolicyLabel => 'පෞද්ගලිකත්ව ප්‍රතිපත්තිය';

  @override
  String get rateAppLabel => 'යෙදුම ශ්‍රේණිගත කරන්න';

  @override
  String get moreAppsLabel => 'තවත් යෙදුම්';

  @override
  String get shareAppLabel => 'යෙදුම බෙදාගන්න';

  @override
  String shareAppMessage(String url) {
    return 'රන් බර පරිවර්තකය භාවිතා කර බලන්න: $url';
  }

  @override
  String get openLinkFailed => 'සබැඳිය විවෘත කිරීමට නොහැකි විය';

  @override
  String get appUpdateReady =>
      'යාවත්කාලීන කිරීම බාගන්නා ලදි. ස්ථාපනය කිරීමට නැවත ආරම්භ කරන්න.';

  @override
  String get appUpdateRestart => 'නැවත ආරම්භ කරන්න';
}
