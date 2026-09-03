// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Convertisseur de Poids d\'Or';

  @override
  String get validationValidNumber => 'Veuillez entrer un nombre valide';

  @override
  String get validationPositiveNumber => 'Veuillez entrer un nombre positif';

  @override
  String get tolaLabel => 'Tola';

  @override
  String get tolaInfo =>
      '1 Tola = 11,66 grammes = 12 Masha = 16 Ana = 96 Ratti';

  @override
  String get tolaHint => 'ex. 2.5';

  @override
  String get tolaSemanticLabel => 'Champ de saisie du poids en Tola';

  @override
  String get mashaLabel => 'Masha';

  @override
  String get mashaInfo => '1 Masha = 0,972 gramme = 1,333 Ana = 8 Ratti';

  @override
  String get mashaHint => 'ex. 12.5';

  @override
  String get mashaSemanticLabel => 'Champ de saisie du poids en Masha';

  @override
  String get anaLabel => 'Ana';

  @override
  String get anaInfo => '1 Ana = 0,72875 gramme = 6 Ratti';

  @override
  String get anaHint => 'ex. 16.25';

  @override
  String get anaSemanticLabel => 'Champ de saisie du poids en Ana';

  @override
  String get rattiLabel => 'Ratti';

  @override
  String get rattiInfo => '1 Ratti = 0,1215 gramme';

  @override
  String get rattiHint => 'ex. 96.75';

  @override
  String get rattiSemanticLabel => 'Champ de saisie du poids en Ratti';

  @override
  String get lalLabel => 'Lal';

  @override
  String get lalInfo => '1 Lal = 0.1166 grams = 0.01 Tola (100 Lal = 1 Tola)';

  @override
  String get lalHint => 'e.g. 25';

  @override
  String get lalSemanticLabel => 'Lal weight input field';

  @override
  String get gramLabel => 'Gramme';

  @override
  String get gramInfo => 'Saisie directe en grammes';

  @override
  String get gramHint => 'ex. 11.66';

  @override
  String get gramSemanticLabel => 'Champ de saisie du poids en grammes';

  @override
  String get goldRateLabel => 'Prix de l\'Or';

  @override
  String get goldRateInfo => 'Cours actuel du marché par unité';

  @override
  String get goldRateHint => 'ex. 150 000';

  @override
  String get goldRateSemanticLabel => 'Champ de saisie du prix de l\'or';

  @override
  String get calculateButton => 'Calculer';

  @override
  String get calculateSemanticLabel => 'Calculer la conversion du poids d\'or';

  @override
  String get clearAllButton => 'Tout effacer';

  @override
  String get clearAllSemanticLabel => 'Effacer tous les champs de saisie';

  @override
  String get conversionDetails => 'Détails de la conversion';

  @override
  String tolaConversion(String value, String factor, String result) {
    return 'Tola: $value × $factor = $result grammes';
  }

  @override
  String mashaConversion(String value, String factor, String result) {
    return 'Masha: $value × $factor = $result grammes';
  }

  @override
  String anaConversion(String value, String factor, String result) {
    return 'Ana: $value × $factor = $result grammes';
  }

  @override
  String rattiConversion(String value, String factor, String result) {
    return 'Ratti: $value × $factor = $result grammes';
  }

  @override
  String lalConversion(String value, String factor, String result) {
    return 'Lal: $value × $factor = $result grams';
  }

  @override
  String gramConversion(String value) {
    return 'Gramme: $value grammes';
  }

  @override
  String totalWeight(String value) {
    return 'Poids Total: $value grammes';
  }

  @override
  String get convertedTo => 'Converti en:';

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
    return 'Valeur de l\'Or: $price';
  }

  @override
  String rateInfo(String rate, String unit) {
    return '(Prix: $rate par $unit)';
  }

  @override
  String get unitTola => 'Tola';

  @override
  String get unitLal => 'Lal';

  @override
  String get unitTenGram => '10 Grammes';

  @override
  String get unitOneGram => '1 Gramme';

  @override
  String enterValueHint(String label) {
    return 'Entrez la valeur pour $label';
  }

  @override
  String inputFieldSemantic(String label) {
    return 'Champ de saisie $label';
  }

  @override
  String unitSelectorSemantic(String label) {
    return 'Sélecteur d\'unité $label';
  }

  @override
  String get converterTabLabel => 'Convertisseur';

  @override
  String get settingsTabLabel => 'Paramètres';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsThemeLabel => 'Thème';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get darkModeLabel => 'Mode Sombre';

  @override
  String get darkModeSubtitle => 'Basculer entre les thèmes sombre et clair';

  @override
  String get themeSystem => 'Système';

  @override
  String get settingsLanguageLabel => 'Langue';

  @override
  String get settingsCurrencyLabel => 'Devise';

  @override
  String get currencySelectionPrompt => 'Sélectionnez votre devise';

  @override
  String get currencySearchHint => 'Rechercher par code, nom ou symbole';

  @override
  String get currencySearchEmpty => 'Aucune devise correspondante';

  @override
  String get languageSelectionPrompt => 'Veuillez sélectionner votre langue';

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageUrdu => 'Ourdou';

  @override
  String get languageArabic => 'Arabe';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languageTurkish => 'Turc';

  @override
  String get languageNote => 'D\'autres langues arrivent bientôt';

  @override
  String get settingsAboutLabel => 'À propos';

  @override
  String get aboutVersion => 'Version';

  @override
  String get aboutDescription =>
      'Gold Weight Converter est un outil simple et efficace pour convertir entre les unités de poids d\'or traditionnelles et les grammes.';

  @override
  String get unknownLabel => 'Inconnu';

  @override
  String get zakatMenuLabel => 'Zakat sur l\'Or';

  @override
  String get zakatScreenTitle => 'Zakat sur l\'Or';

  @override
  String get zakatDisclaimer =>
      'Aide pour les objets en or uniquement — ne constitue pas une évaluation complète de la zakat ou une fatwa religieuse. Les autres biens et le nissab relèvent de votre responsabilité ; consultez un savant local.';

  @override
  String get zakatRateInfo =>
      'Prix du marché pour l\'or 24K / or pur par unité';

  @override
  String get zakatItemsTitle => 'Vos objets en or';

  @override
  String get zakatAddItem => 'Ajouter un objet';

  @override
  String get zakatEditItem => 'Modifier l\'objet';

  @override
  String get zakatEmptyItems =>
      'Aucun objet en or pour le moment. Ajoutez des bijoux ou des lingots pour calculer la zakat.';

  @override
  String get zakatItemNameLabel => 'Nom (facultatif)';

  @override
  String get zakatItemNameHint => 'ex. Alliance';

  @override
  String get zakatWeightLabel => 'Poids';

  @override
  String get zakatWeightHint => 'ex. 10';

  @override
  String get zakatWeightUnitLabel => 'Unité';

  @override
  String get zakatPurityLabel => 'Pureté (Carat)';

  @override
  String get zakatCustomKaratLabel => 'Carat personnalisé (1–24)';

  @override
  String get zakatCustomKaratHint => 'ex. 20';

  @override
  String get zakatPurity24k => '24K (pur)';

  @override
  String get zakatPurity22k => '22K';

  @override
  String get zakatPurity21k => '21K';

  @override
  String get zakatPurity18k => '18K';

  @override
  String get zakatPurityCustom => 'Personnalisé';

  @override
  String get zakatSaveItem => 'Enregistrer';

  @override
  String get zakatDeleteItem => 'Supprimer';

  @override
  String get zakatDeleteConfirmTitle => 'Supprimer l\'objet en or ?';

  @override
  String zakatDeleteConfirmMessage(String name) {
    return 'Cela supprimera \"$name\" de votre liste de zakat.';
  }

  @override
  String get zakatCancel => 'Annuler';

  @override
  String get zakatUntitledItem => 'Objet en or';

  @override
  String get zakatSummaryTitle => 'Résumé de la Zakat';

  @override
  String get zakatTotalPureGold => 'Total or pur';

  @override
  String zakatPureGoldValue(String grams, String tola) {
    return '$grams g ($tola tola)';
  }

  @override
  String get zakatTotalValue => 'Valeur estimée';

  @override
  String get zakatDueLabel => 'Zakat due (2,5%)';

  @override
  String get zakatEnterRatePrompt =>
      'Entrez le prix de l\'or pour estimer la valeur et la zakat';

  @override
  String get zakatCalculateButton => 'Calculer la zakat';

  @override
  String zakatItemDetail(String weight, String unit, String purity) {
    return '$weight $unit · $purity';
  }

  @override
  String get zakatValidationWeight => 'Entrez un poids supérieur à zéro';

  @override
  String get zakatValidationKarat => 'Entrez un carat entre 1 et 24';

  @override
  String get copyResults => 'Copier';

  @override
  String get shareResults => 'Partager';

  @override
  String get resultsCopied => 'Copié dans le presse-papiers';

  @override
  String get privacyPolicyLabel => 'Politique de confidentialité';

  @override
  String get rateAppLabel => 'Noter l\'application';

  @override
  String get moreAppsLabel => 'Plus d\'applications';

  @override
  String get shareAppLabel => 'Partager l\'application';

  @override
  String shareAppMessage(String url) {
    return 'Essayez le convertisseur de poids d\'or : $url';
  }

  @override
  String get openLinkFailed => 'Impossible d\'ouvrir le lien';

  @override
  String get appUpdateReady =>
      'Mise à jour téléchargée. Redémarrez pour l\'installer.';

  @override
  String get appUpdateRestart => 'Redémarrer';
}
