// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appTitle => 'ရွှေအလေးချိန် တွက်ချက်စက်';

  @override
  String get validationValidNumber =>
      'ကျေးဇူးပြု၍ မှန်ကန်သော ကိန်းဂဏန်း ထည့်ပါ';

  @override
  String get validationPositiveNumber => 'ကျေးဇူးပြု၍ အပေါင်းကိန်း ထည့်ပါ';

  @override
  String get tolaLabel => 'တိုလာ';

  @override
  String get tolaInfo => '၁ တိုလာ = ၁၁.၆၆ ဂရမ် = ၁၂ မာရှာ = ၁၆ အာနာ = ၉၆ ရတ်တီ';

  @override
  String get tolaHint => 'ဥပမာ ၂.၅';

  @override
  String get tolaSemanticLabel => 'တိုလာ အလေးချိန် ထည့်သွင်းရန် အကွက်';

  @override
  String get mashaLabel => 'မာရှာ';

  @override
  String get mashaInfo => '၁ မာရှာ = ၀.၉၇၂ ဂရမ် = ၁.၃၃၃ အာနာ = ၈ ရတ်တီ';

  @override
  String get mashaHint => 'ဥပမာ ၁၂.၅';

  @override
  String get mashaSemanticLabel => 'မာရှာ အလေးချိန် ထည့်သွင်းရန် အကွက်';

  @override
  String get anaLabel => 'အာနာ';

  @override
  String get anaInfo => '၁ အာနာ = ၀.၇၂၈၇၅ ဂရမ် = ၆ ရတ်တီ';

  @override
  String get anaHint => 'ဥပမာ ၁၆.၂၅';

  @override
  String get anaSemanticLabel => 'အာနာ အလေးချိန် ထည့်သွင်းရန် အကွက်';

  @override
  String get rattiLabel => 'ရတ်တီ';

  @override
  String get rattiInfo => '၁ ရတ်တီ = ၀.၁၂၁၅ ဂရမ်';

  @override
  String get rattiHint => 'ဥပမာ ၉၆.၇၅';

  @override
  String get rattiSemanticLabel => 'ရတ်တီ အလေးချိန် ထည့်သွင်းရန် အကွက်';

  @override
  String get lalLabel => 'Lal';

  @override
  String get lalInfo => '1 Lal = 0.1166 grams = 0.01 Tola (100 Lal = 1 Tola)';

  @override
  String get lalHint => 'e.g. 25';

  @override
  String get lalSemanticLabel => 'Lal weight input field';

  @override
  String get gramLabel => 'ဂရမ်';

  @override
  String get gramInfo => 'ဂရမ်ဖြင့် တိုက်ရိုက် ထည့်သွင်းခြင်း';

  @override
  String get gramHint => 'ဥပမာ ၁၁.၆၆';

  @override
  String get gramSemanticLabel => 'ဂရမ် အလေးချိန် ထည့်သွင်းရန် အကွက်';

  @override
  String get goldRateLabel => 'ရွှေစျေးနှုန်း';

  @override
  String get goldRateInfo => 'တစ်ယူနစ်လျှင် လက်ရှိ ပေါက်စျေး';

  @override
  String get goldRateHint => 'ဥပမာ ၁၅၀,၀၀၀';

  @override
  String get goldRateSemanticLabel => 'ရွှေစျေးနှုန်း ထည့်သွင်းရန် အကွက်';

  @override
  String get calculateButton => 'တွက်ချက်မည်';

  @override
  String get calculateSemanticLabel => 'ရွှေအလေးချိန်ကို တွက်ချက်မည်';

  @override
  String get clearAllButton => 'အားလုံးရှင်းမည်';

  @override
  String get clearAllSemanticLabel =>
      'ထည့်သွင်းထားသော အချက်အလက်များ အားလုံးရှင်းမည်';

  @override
  String get conversionDetails => 'တွက်ချက်မှု အသေးစိတ်';

  @override
  String tolaConversion(String value, String factor, String result) {
    return 'တိုလာ: $value × $factor = $result ဂရမ်';
  }

  @override
  String mashaConversion(String value, String factor, String result) {
    return 'မာရှာ: $value × $factor = $result ဂရမ်';
  }

  @override
  String anaConversion(String value, String factor, String result) {
    return 'အာနာ: $value × $factor = $result ဂရမ်';
  }

  @override
  String rattiConversion(String value, String factor, String result) {
    return 'ရတ်တီ: $value × $factor = $result ဂရမ်';
  }

  @override
  String lalConversion(String value, String factor, String result) {
    return 'Lal: $value × $factor = $result grams';
  }

  @override
  String gramConversion(String value) {
    return 'ဂရမ်: $value ဂရမ်';
  }

  @override
  String totalWeight(String value) {
    return 'စုစုပေါင်း အလေးချိန်: $value ဂရမ်';
  }

  @override
  String get convertedTo => 'ပြောင်းလဲရရှိသော အလေးချိန်:';

  @override
  String tolaResult(String value) {
    return 'တိုလာ: $value';
  }

  @override
  String lalResult(String value) {
    return 'Lal: $value';
  }

  @override
  String mashaResult(String value) {
    return 'မာရှာ: $value';
  }

  @override
  String anaResult(String value) {
    return 'အာနာ: $value';
  }

  @override
  String rattiResult(String value) {
    return 'ရတ်တီ: $value';
  }

  @override
  String goldPrice(String price) {
    return 'ရွှေတန်ဖိုး: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(စျေးနှုန်း: တစ် $unit လျှင် $rate)';
  }

  @override
  String get unitTola => 'တိုလာ';

  @override
  String get unitLal => 'Lal';

  @override
  String get unitTenGram => '၁၀ ဂရမ်';

  @override
  String get unitOneGram => '၁ ဂရမ်';

  @override
  String enterValueHint(String label) {
    return '$label တန်ဖိုး ထည့်ပါ';
  }

  @override
  String inputFieldSemantic(String label) {
    return '$label ထည့်သွင်းရန် အကွက်';
  }

  @override
  String unitSelectorSemantic(String label) {
    return '$label ယူနစ် ရွေးချယ်စရာ';
  }

  @override
  String get converterTabLabel => 'တွက်ချက်စက်';

  @override
  String get settingsTabLabel => 'ဆက်တင်များ';

  @override
  String get settingsTitle => 'ဆက်တင်များ';

  @override
  String get settingsThemeLabel => 'အပြင်အဆင်';

  @override
  String get themeLight => 'အလင်း';

  @override
  String get themeDark => 'အမှောင်';

  @override
  String get darkModeLabel => 'အမှောင် မုဒ်';

  @override
  String get darkModeSubtitle => 'အလင်းနှင့် အမှောင် အပြင်အဆင် ပြောင်းလဲရန်';

  @override
  String get themeSystem => 'စနစ်အတိုင်း';

  @override
  String get settingsLanguageLabel => 'ဘာသာစကား';

  @override
  String get settingsCurrencyLabel => 'ငွေကြေး';

  @override
  String get currencySelectionPrompt => 'သင့်ငွေကြေးကို ရွေးချယ်ပါ';

  @override
  String get currencySearchHint => 'ကုဒ်၊ အမည် သို့မဟုတ် သင်္ကေတဖြင့် ရှာပါ';

  @override
  String get currencySearchEmpty => 'ကိုက်ညီသော ငွေကြေး မရှိပါ';

  @override
  String get languageSelectionPrompt => 'ကျေးဇူးပြု၍ ဘာသာစကား ရွေးချယ်ပါ';

  @override
  String get languageEnglish => 'အင်္ဂလိပ်';

  @override
  String get languageUrdu => 'အူရဒူ';

  @override
  String get languageArabic => 'အာရဗီ';

  @override
  String get languageHindi => 'ဟိန္ဒီ';

  @override
  String get languageTurkish => 'တူရကီ';

  @override
  String get languageNote => 'နောက်ထပ် ဘာသာစကားများ မကြာမီ လာမည်';

  @override
  String get settingsAboutLabel => 'အကြောင်းအရာ';

  @override
  String get aboutVersion => 'ဗားရှင်း';

  @override
  String get aboutDescription =>
      'ရွှေအလေးချိန် တွက်ချက်စက်သည် ရိုးရာ ရွှေအလေးချိန် ယူနစ်များနှင့် ဂရမ်ကြား အလွယ်တကူ တွက်ချက်ပေးသော ကိရိယာ ဖြစ်သည်။';

  @override
  String get unknownLabel => 'မသိရှိပါ';

  @override
  String get zakatMenuLabel => 'ရွှေ ဇကားသ်';

  @override
  String get zakatScreenTitle => 'ရွှေ ဇကားသ်';

  @override
  String get zakatDisclaimer =>
      'ရွှေပစ္စည်းများအတွက်သာ အထောက်အကူပြု ကိရိယာ ဖြစ်သည် — ပြည့်စုံသော ဇကားသ် သတ်မှတ်ချက် သို့မဟုတ် ဘာသာရေး ဆုံးဖြတ်ချက် မဟုတ်ပါ။ အခြားပိုင်ဆိုင်မှုများနှင့် နေဆာဗ်အတွက် သက်ဆိုင်ရာ ပညာရှင်နှင့် တိုင်ပင်ပါ။';

  @override
  String get zakatRateInfo => '၂၄ ကာရတ် / ရွှေစင်၏ တစ်ယူနစ် ပေါက်စျေး';

  @override
  String get zakatItemsTitle => 'သင့် ရွှေထည်ပစ္စည်းများ';

  @override
  String get zakatAddItem => 'ပစ္စည်း ထည့်မည်';

  @override
  String get zakatEditItem => 'ပစ္စည်း ပြင်ဆင်မည်';

  @override
  String get zakatEmptyItems =>
      'ရွှေထည်ပစ္စည်း မရှိသေးပါ။ ဇကားသ် တွက်ချက်ရန် လက်ဝတ်ရတနာ သို့မဟုတ် ရွှေချောင်းများ ထည့်ပါ။';

  @override
  String get zakatItemNameLabel => 'အမည် (စိတ်ကြိုက်)';

  @override
  String get zakatItemNameHint => 'ဥပမာ မင်္ဂလာလက်စွပ်';

  @override
  String get zakatWeightLabel => 'အလေးချိန်';

  @override
  String get zakatWeightHint => 'ဥပမာ ၁၀';

  @override
  String get zakatWeightUnitLabel => 'ယူနစ်';

  @override
  String get zakatPurityLabel => 'ရွှေရည်';

  @override
  String get zakatCustomKaratLabel => 'စိတ်ကြိုက် ကာရတ် (၁–၂၄)';

  @override
  String get zakatCustomKaratHint => 'ဥပမာ ၂၀';

  @override
  String get zakatPurity24k => '၂၄ ကာရတ် (ရွှေစင်)';

  @override
  String get zakatPurity22k => '၂၂ ကာရတ်';

  @override
  String get zakatPurity21k => '၂၁ ကာရတ်';

  @override
  String get zakatPurity18k => '၁၈ ကာရတ်';

  @override
  String get zakatPurityCustom => 'စိတ်ကြိုက်';

  @override
  String get zakatSaveItem => 'သိမ်းဆည်းမည်';

  @override
  String get zakatDeleteItem => 'ဖျက်မည်';

  @override
  String get zakatDeleteConfirmTitle => 'ရွှေထည်ပစ္စည်းကို ဖျက်မလား?';

  @override
  String zakatDeleteConfirmMessage(String name) {
    return 'ဇကားသ် စာရင်းမှ \"$name\" ကို ဖယ်ရှားပါမည်။';
  }

  @override
  String get zakatCancel => 'ပယ်ဖျက်မည်';

  @override
  String get zakatUntitledItem => 'ရွှေထည်ပစ္စည်း';

  @override
  String get zakatSummaryTitle => 'ဇကားသ် အကျဉ်းချုပ်';

  @override
  String get zakatTotalPureGold => 'စုစုပေါင်း ရွှေစင်';

  @override
  String zakatPureGoldValue(String grams, String tola) {
    return '$grams ဂရမ် ($tola တိုလာ)';
  }

  @override
  String get zakatTotalValue => 'ခန့်မှန်း တန်ဖိုး';

  @override
  String get zakatDueLabel => 'ပေးဆောင်ရမည့် ဇကားသ် (၂.၅%)';

  @override
  String get zakatEnterRatePrompt =>
      'တန်ဖိုးနှင့် ဇကားသ် တွက်ချက်ရန် ရွှေစျေးနှုန်း ထည့်ပါ';

  @override
  String get zakatCalculateButton => 'ဇကားသ် တွက်ချက်မည်';

  @override
  String zakatItemDetail(String weight, String unit, String purity) {
    return '$weight $unit · $purity';
  }

  @override
  String get zakatValidationWeight => 'သုညထက် ကြီးသော အလေးချိန် ထည့်ပါ';

  @override
  String get zakatValidationKarat => '၁ မှ ၂၄ ကြား ကာရတ် ထည့်ပါ';

  @override
  String get copyResults => 'ကူးယူမည်';

  @override
  String get shareResults => 'မျှဝေမည်';

  @override
  String get resultsCopied => 'ကူးယူပြီးပါပြီ';

  @override
  String get privacyPolicyLabel => 'ကိုယ်ရေးကိုယ်တာ မူဝါဒ';

  @override
  String get rateAppLabel => 'အဆင့်သတ်မှတ်မည်';

  @override
  String get moreAppsLabel => 'နောက်ထပ် အက်ပ်များ';

  @override
  String get shareAppLabel => 'အက်ပ်ကို မျှဝေမည်';

  @override
  String shareAppMessage(String url) {
    return 'ရွှေအလေးချိန် တွက်ချက်စက်ကို အသုံးပြုကြည့်ပါ: $url';
  }

  @override
  String get openLinkFailed => 'လင့်ခ်ကို ဖွင့်၍မရပါ';

  @override
  String get appUpdateReady =>
      'အပ်ဒိတ် ဒေါင်းလုဒ်ပြီးပါပြီ။ ထည့်သွင်းရန် အက်ပ်ကို ပြန်လည်စတင်ပါ။';

  @override
  String get appUpdateRestart => 'ပြန်လည်စတင်မည်';
}
