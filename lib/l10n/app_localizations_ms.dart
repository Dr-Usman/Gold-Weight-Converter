// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appTitle => 'Penukar Berat Emas';

  @override
  String get validationValidNumber => 'Sila masukkan nombor yang sah';

  @override
  String get validationPositiveNumber => 'Sila masukkan nombor positif';

  @override
  String get tolaLabel => 'Tola';

  @override
  String get tolaInfo => '1 Tola = 11.66 gram = 12 Masha = 16 Ana = 96 Ratti';

  @override
  String get tolaHint => 'Contohnya 2.5';

  @override
  String get tolaSemanticLabel => 'Bidang input berat Tola';

  @override
  String get mashaLabel => 'Masha';

  @override
  String get mashaInfo => '1 Masha = 0.972 gram = 1.333 Ana = 8 Ratti';

  @override
  String get mashaHint => 'Contohnya 12.5';

  @override
  String get mashaSemanticLabel => 'Bidang input berat Masha';

  @override
  String get anaLabel => 'Ana';

  @override
  String get anaInfo => '1 Ana = 0.72875 gram = 6 Ratti';

  @override
  String get anaHint => 'Contohnya 16.25';

  @override
  String get anaSemanticLabel => 'Bidang input berat Ana';

  @override
  String get rattiLabel => 'Ratti';

  @override
  String get rattiInfo => '1 Ratti = 0.1215 gram';

  @override
  String get rattiHint => 'Contohnya 96.75';

  @override
  String get rattiSemanticLabel => 'Bidang input berat Ratti';

  @override
  String get gramLabel => 'Gram';

  @override
  String get gramInfo => 'Input gram secara langsung';

  @override
  String get gramHint => 'Contohnya 11.66';

  @override
  String get gramSemanticLabel => 'Bidang input berat Gram';

  @override
  String get goldRateLabel => 'Harga Emas';

  @override
  String get goldRateInfo => 'Harga pasaran semasa bagi setiap unit';

  @override
  String get goldRateHint => 'Contohnya 150,000';

  @override
  String get goldRateSemanticLabel => 'Bidang input harga emas';

  @override
  String get calculateButton => 'Kira';

  @override
  String get calculateSemanticLabel => 'Kira penukaran berat emas';

  @override
  String get clearAllButton => 'Padam Semua';

  @override
  String get clearAllSemanticLabel => 'Padamkan semua bidang input';

  @override
  String get conversionDetails => 'Butiran Penukaran';

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
    return 'Jumlah Berat: $value gram';
  }

  @override
  String get convertedTo => 'Ditukar kepada:';

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
    return 'Harga Emas: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(Harga: $rate bagi $unit)';
  }

  @override
  String get unitTola => 'Tola';

  @override
  String get unitTenGram => '10 Gram';

  @override
  String get unitOneGram => '1 Gram';

  @override
  String enterValueHint(String label) {
    return 'Masukkan nilai $label';
  }

  @override
  String inputFieldSemantic(String label) {
    return 'Bidang input $label';
  }

  @override
  String unitSelectorSemantic(String label) {
    return 'Pemilih unit $label';
  }

  @override
  String get converterTabLabel => 'Penukar';

  @override
  String get settingsTabLabel => 'Tetapan';

  @override
  String get settingsTitle => 'Tetapan';

  @override
  String get settingsThemeLabel => 'Tema';

  @override
  String get themeLight => 'Terang';

  @override
  String get themeDark => 'Gelap';

  @override
  String get darkModeLabel => 'Mod Gelap';

  @override
  String get darkModeSubtitle => 'Tukar antara tema gelap dan terang';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get settingsLanguageLabel => 'Bahasa';

  @override
  String get languageSelectionPrompt => 'Sila pilih bahasa anda';

  @override
  String get languageEnglish => 'Bahasa Inggeris';

  @override
  String get languageUrdu => 'Urdu';

  @override
  String get languageArabic => 'Arab';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languageTurkish => 'Turki';

  @override
  String get languageNote => 'Lebih banyak bahasa akan datang';

  @override
  String get settingsAboutLabel => 'Tentang';

  @override
  String get aboutVersion => 'Versi';

  @override
  String get aboutDescription =>
      'Penukar Berat Emas adalah alat yang mudah dan cekap untuk menukar antara pelbagai unit berat emas tradisional dan gram.';

  @override
  String get unknownLabel => 'Tidak diketahui';

  @override
  String get zakatMenuLabel => 'Zakat Emas';

  @override
  String get zakatScreenTitle => 'Zakat Emas';

  @override
  String get zakatDisclaimer =>
      'Pembantu untuk barang emas sahaja — bukan penilaian zakat penuh atau fatwa. Aset lain dan nisab adalah tanggungjawab anda; rujuk ulama tempatan.';

  @override
  String get zakatRateInfo => 'Harga pasaran emas 24K / tulen bagi setiap unit';

  @override
  String get zakatItemsTitle => 'Barangan emas anda';

  @override
  String get zakatAddItem => 'Tambah barang';

  @override
  String get zakatEditItem => 'Edit barang';

  @override
  String get zakatEmptyItems =>
      'Tiada barang emas lagi. Tambah barang kemas atau jongkong untuk kira zakat.';

  @override
  String get zakatItemNameLabel => 'Nama (pilihan)';

  @override
  String get zakatItemNameHint => 'cth. cincin kahwin';

  @override
  String get zakatWeightLabel => 'Berat';

  @override
  String get zakatWeightHint => 'cth. 10';

  @override
  String get zakatWeightUnitLabel => 'Unit';

  @override
  String get zakatPurityLabel => 'Ketulenan';

  @override
  String get zakatCustomKaratLabel => 'Karat tersuai (1–24)';

  @override
  String get zakatCustomKaratHint => 'cth. 20';

  @override
  String get zakatPurity24k => '24K (tulen)';

  @override
  String get zakatPurity22k => '22K';

  @override
  String get zakatPurity21k => '21K';

  @override
  String get zakatPurity18k => '18K';

  @override
  String get zakatPurityCustom => 'Tersuai';

  @override
  String get zakatSaveItem => 'Simpan';

  @override
  String get zakatDeleteItem => 'Padam';

  @override
  String get zakatDeleteConfirmTitle => 'Padam barang emas?';

  @override
  String zakatDeleteConfirmMessage(String name) {
    return 'Ini akan mengeluarkan \"$name\" daripada senarai zakat anda.';
  }

  @override
  String get zakatCancel => 'Batal';

  @override
  String get zakatUntitledItem => 'Barang emas';

  @override
  String get zakatSummaryTitle => 'Ringkasan zakat';

  @override
  String get zakatTotalPureGold => 'Jumlah emas tulen';

  @override
  String zakatPureGoldValue(String grams, String tola) {
    return '$grams g ($tola tola)';
  }

  @override
  String get zakatTotalValue => 'Anggaran nilai';

  @override
  String get zakatDueLabel => 'Zakat ke atas barang ini (2.5%)';

  @override
  String get zakatEnterRatePrompt =>
      'Masukkan kadar emas untuk anggaran nilai dan zakat';

  @override
  String get zakatCalculateButton => 'Kira zakat';

  @override
  String zakatItemDetail(String weight, String unit, String purity) {
    return '$weight $unit · $purity';
  }

  @override
  String get zakatValidationWeight => 'Masukkan berat lebih daripada sifar';

  @override
  String get zakatValidationKarat => 'Masukkan karat antara 1 dan 24';
}
