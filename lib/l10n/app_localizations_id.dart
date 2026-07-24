// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Pengonversi Berat Emas';

  @override
  String get validationValidNumber => 'Silakan masukkan nomor yang valid';

  @override
  String get validationPositiveNumber => 'Silakan masukkan nomor positif';

  @override
  String get tolaLabel => 'Tola';

  @override
  String get tolaInfo => '1 Tola = 11.66 gram = 12 Masha = 16 Ana = 96 Ratti';

  @override
  String get tolaHint => 'Misalnya 2.5';

  @override
  String get tolaSemanticLabel => 'Kolom input berat Tola';

  @override
  String get mashaLabel => 'Masha';

  @override
  String get mashaInfo => '1 Masha = 0.972 gram = 1.333 Ana = 8 Ratti';

  @override
  String get mashaHint => 'Misalnya 12.5';

  @override
  String get mashaSemanticLabel => 'Kolom input berat Masha';

  @override
  String get anaLabel => 'Ana';

  @override
  String get anaInfo => '1 Ana = 0.72875 gram = 6 Ratti';

  @override
  String get anaHint => 'Misalnya 16.25';

  @override
  String get anaSemanticLabel => 'Kolom input berat Ana';

  @override
  String get rattiLabel => 'Ratti';

  @override
  String get rattiInfo => '1 Ratti = 0.1215 gram';

  @override
  String get rattiHint => 'Misalnya 96.75';

  @override
  String get rattiSemanticLabel => 'Kolom input berat Ratti';

  @override
  String get gramLabel => 'Gram';

  @override
  String get gramInfo => 'Masukkan gram secara langsung';

  @override
  String get gramHint => 'Misalnya 11.66';

  @override
  String get gramSemanticLabel => 'Kolom input berat Gram';

  @override
  String get goldRateLabel => 'Harga Emas';

  @override
  String get goldRateInfo => 'Harga pasar saat ini per unit';

  @override
  String get goldRateHint => 'Misalnya 150,000';

  @override
  String get goldRateSemanticLabel => 'Kolom input harga emas';

  @override
  String get calculateButton => 'Hitung';

  @override
  String get calculateSemanticLabel => 'Hitung konversi berat emas';

  @override
  String get clearAllButton => 'Hapus Semua';

  @override
  String get clearAllSemanticLabel => 'Hapus semua kolom input';

  @override
  String get conversionDetails => 'Detail Konversi';

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
    return 'Berat Total: $value gram';
  }

  @override
  String get convertedTo => 'Dikonversi ke:';

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
    return '(Harga: $rate per $unit)';
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
    return 'Kolom input $label';
  }

  @override
  String unitSelectorSemantic(String label) {
    return 'Pemilih unit $label';
  }

  @override
  String get converterTabLabel => 'Pengonversi';

  @override
  String get settingsTabLabel => 'Pengaturan';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get settingsThemeLabel => 'Tema';

  @override
  String get themeLight => 'Terang';

  @override
  String get themeDark => 'Gelap';

  @override
  String get darkModeLabel => 'Mode Gelap';

  @override
  String get darkModeSubtitle => 'Beralih antara tema gelap dan terang';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get settingsLanguageLabel => 'Bahasa';

  @override
  String get settingsCurrencyLabel => 'Mata uang';

  @override
  String get currencySelectionPrompt => 'Pilih mata uang Anda';

  @override
  String get currencySearchHint => 'Cari berdasarkan kode, nama, atau simbol';

  @override
  String get currencySearchEmpty => 'Tidak ada mata uang yang cocok';

  @override
  String get languageSelectionPrompt => 'Silakan pilih bahasa Anda';

  @override
  String get languageEnglish => 'Bahasa Inggris';

  @override
  String get languageUrdu => 'Urdu';

  @override
  String get languageArabic => 'Arab';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languageTurkish => 'Turki';

  @override
  String get languageNote => 'Lebih banyak bahasa akan segera hadir';

  @override
  String get settingsAboutLabel => 'Tentang';

  @override
  String get aboutVersion => 'Versi';

  @override
  String get aboutDescription =>
      'Pengonversi Berat Emas adalah alat yang sederhana dan efisien untuk mengonversi antara berbagai unit berat emas tradisional dan gram.';

  @override
  String get unknownLabel => 'Tidak Diketahui';

  @override
  String get zakatMenuLabel => 'Zakat Emas';

  @override
  String get zakatScreenTitle => 'Zakat Emas';

  @override
  String get zakatDisclaimer =>
      'Hanya pembantu untuk barang emas — bukan penilaian zakat lengkap atau fatwa. Aset lain dan nisab adalah tanggung jawab Anda; konsultasikan ulama setempat.';

  @override
  String get zakatRateInfo => 'Harga pasar emas 24K / murni per unit';

  @override
  String get zakatItemsTitle => 'Barang emas Anda';

  @override
  String get zakatAddItem => 'Tambah barang';

  @override
  String get zakatEditItem => 'Edit barang';

  @override
  String get zakatEmptyItems =>
      'Belum ada barang emas. Tambahkan perhiasan atau batangan untuk menghitung zakat.';

  @override
  String get zakatItemNameLabel => 'Nama (opsional)';

  @override
  String get zakatItemNameHint => 'mis. cincin kawin';

  @override
  String get zakatWeightLabel => 'Berat';

  @override
  String get zakatWeightHint => 'mis. 10';

  @override
  String get zakatWeightUnitLabel => 'Satuan';

  @override
  String get zakatPurityLabel => 'Kadar';

  @override
  String get zakatCustomKaratLabel => 'Karat khusus (1–24)';

  @override
  String get zakatCustomKaratHint => 'mis. 20';

  @override
  String get zakatPurity24k => '24K (murni)';

  @override
  String get zakatPurity22k => '22K';

  @override
  String get zakatPurity21k => '21K';

  @override
  String get zakatPurity18k => '18K';

  @override
  String get zakatPurityCustom => 'Khusus';

  @override
  String get zakatSaveItem => 'Simpan';

  @override
  String get zakatDeleteItem => 'Hapus';

  @override
  String get zakatDeleteConfirmTitle => 'Hapus barang emas?';

  @override
  String zakatDeleteConfirmMessage(String name) {
    return 'Ini akan menghapus \"$name\" dari daftar zakat Anda.';
  }

  @override
  String get zakatCancel => 'Batal';

  @override
  String get zakatUntitledItem => 'Barang emas';

  @override
  String get zakatSummaryTitle => 'Ringkasan zakat';

  @override
  String get zakatTotalPureGold => 'Total emas murni';

  @override
  String zakatPureGoldValue(String grams, String tola) {
    return '$grams g ($tola tola)';
  }

  @override
  String get zakatTotalValue => 'Nilai perkiraan';

  @override
  String get zakatDueLabel => 'Zakat atas barang ini (2,5%)';

  @override
  String get zakatEnterRatePrompt =>
      'Masukkan harga emas untuk memperkirakan nilai dan zakat';

  @override
  String get zakatCalculateButton => 'Hitung zakat';

  @override
  String zakatItemDetail(String weight, String unit, String purity) {
    return '$weight $unit · $purity';
  }

  @override
  String get zakatValidationWeight => 'Masukkan berat lebih dari nol';

  @override
  String get zakatValidationKarat => 'Masukkan karat antara 1 dan 24';
}
