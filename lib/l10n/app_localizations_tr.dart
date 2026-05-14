// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Altın Ağırlık Dönüştürücüsü';

  @override
  String get validationValidNumber => 'Lütfen geçerli bir sayı girin';

  @override
  String get validationPositiveNumber => 'Lütfen pozitif bir sayı girin';

  @override
  String get tolaLabel => 'Tola';

  @override
  String get tolaInfo => '1 Tola = 11.66 gram = 12 Masha = 16 Ana = 96 Ratti';

  @override
  String get tolaHint => 'Örneğin 2.5';

  @override
  String get tolaSemanticLabel => 'Tola ağırlık giriş alanı';

  @override
  String get mashaLabel => 'Masha';

  @override
  String get mashaInfo => '1 Masha = 0.972 gram = 1.333 Ana = 8 Ratti';

  @override
  String get mashaHint => 'Örneğin 12.5';

  @override
  String get mashaSemanticLabel => 'Masha ağırlık giriş alanı';

  @override
  String get anaLabel => 'Ana';

  @override
  String get anaInfo => '1 Ana = 0.72875 gram = 6 Ratti';

  @override
  String get anaHint => 'Örneğin 16.25';

  @override
  String get anaSemanticLabel => 'Ana ağırlık giriş alanı';

  @override
  String get rattiLabel => 'Ratti';

  @override
  String get rattiInfo => '1 Ratti = 0.1215 gram';

  @override
  String get rattiHint => 'Örneğin 96.75';

  @override
  String get rattiSemanticLabel => 'Ratti ağırlık giriş alanı';

  @override
  String get gramLabel => 'Gram';

  @override
  String get gramInfo => 'Doğrudan gram girin';

  @override
  String get gramHint => 'Örneğin 11.66';

  @override
  String get gramSemanticLabel => 'Gram ağırlık giriş alanı';

  @override
  String get goldRateLabel => 'Altın Fiyatı';

  @override
  String get goldRateInfo => 'Güncel pazar fiyatı birim başına';

  @override
  String get goldRateHint => 'Örneğin 150,000';

  @override
  String get goldRateSemanticLabel => 'Altın fiyatı giriş alanı';

  @override
  String get calculateButton => 'Hesapla';

  @override
  String get calculateSemanticLabel => 'Altın ağırlık dönüşümünü hesapla';

  @override
  String get clearAllButton => 'Tümünü Temizle';

  @override
  String get clearAllSemanticLabel => 'Tüm giriş alanlarını temizle';

  @override
  String get conversionDetails => 'Dönüşüm Detayları';

  @override
  String tolaConversion(String value, String factor, String result) {
    return 'Tola: $value × $factor = $result gram';
  }

  @override
  String mashaConversion(String value, String factor, String result) {
    return 'Masha: $value × $factor = $result gram';
  }

  @override
  String anaConversion(String value, String factor, String result) {
    return 'Ana: $value × $factor = $result gram';
  }

  @override
  String rattiConversion(String value, String factor, String result) {
    return 'Ratti: $value × $factor = $result gram';
  }

  @override
  String gramConversion(String value) {
    return 'Gram: $value gram';
  }

  @override
  String totalWeight(String value) {
    return 'Toplam Ağırlık: $value gram';
  }

  @override
  String get convertedTo => 'Dönüştürülen:';

  @override
  String tolaResult(String value) {
    return 'Tola: $value';
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
    return 'Altın Fiyatı: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(Fiyat: $rate biri başına $unit)';
  }

  @override
  String get unitTola => 'Tola';

  @override
  String get unitTenGram => '10 Gram';

  @override
  String get unitOneGram => '1 Gram';

  @override
  String enterValueHint(String label) {
    return '$label değerini girin';
  }

  @override
  String inputFieldSemantic(String label) {
    return '$label giriş alanı';
  }

  @override
  String unitSelectorSemantic(String label) {
    return '$label birim seçici';
  }

  @override
  String get converterTabLabel => 'Dönüştürücü';

  @override
  String get settingsTabLabel => 'Ayarlar';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsThemeLabel => 'Tema';

  @override
  String get themeLight => 'Açık';

  @override
  String get themeDark => 'Koyu';

  @override
  String get darkModeLabel => 'Koyu Mod';

  @override
  String get darkModeSubtitle => 'Koyu ve açık temalar arasında geçiş yap';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get settingsLanguageLabel => 'Dil';

  @override
  String get languageSelectionPrompt => 'Lütfen dilinizi seçin';

  @override
  String get languageEnglish => 'İngilizce';

  @override
  String get languageUrdu => 'Urduca';

  @override
  String get languageArabic => 'Arapça';

  @override
  String get languageHindi => 'Hintçe';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageNote => 'Daha fazla dil yakında geliyor';

  @override
  String get settingsAboutLabel => 'Hakkında';

  @override
  String get aboutVersion => 'Sürüm';

  @override
  String get aboutDescription =>
      'Altın Ağırlık Dönüştürücüsü, çeşitli geleneksel altın ağırlık birimleri ile gram arasında dönüştürme için basit ve etkili bir araçtır.';

  @override
  String get unknownLabel => 'Bilinmiyor';
}
