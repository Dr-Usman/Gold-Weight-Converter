import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fil.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_my.dart';
import 'app_localizations_ne.dart';
import 'app_localizations_ps.dart';
import 'app_localizations_sd.dart';
import 'app_localizations_si.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('am'),
    Locale('ar'),
    Locale('bn'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fil'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('ms'),
    Locale('my'),
    Locale('ne'),
    Locale('ps'),
    Locale('sd'),
    Locale('si'),
    Locale('ta'),
    Locale('tr'),
    Locale('ur'),
    Locale('ur', 'RO'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Gold Weight Converter'**
  String get appTitle;

  /// Validation message when input is not a valid number
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get validationValidNumber;

  /// Validation message when input is negative
  ///
  /// In en, this message translates to:
  /// **'Please enter a positive number'**
  String get validationPositiveNumber;

  /// Label for Tola weight unit
  ///
  /// In en, this message translates to:
  /// **'Tola'**
  String get tolaLabel;

  /// Information about Tola conversion
  ///
  /// In en, this message translates to:
  /// **'1 Tola = 11.66 grams = 12 Masha = 16 Ana = 96 Ratti'**
  String get tolaInfo;

  /// Hint text for Tola input field
  ///
  /// In en, this message translates to:
  /// **'e.g. 2.5'**
  String get tolaHint;

  /// Semantic label for Tola input field
  ///
  /// In en, this message translates to:
  /// **'Tola weight input field'**
  String get tolaSemanticLabel;

  /// Label for Masha weight unit
  ///
  /// In en, this message translates to:
  /// **'Masha'**
  String get mashaLabel;

  /// Information about Masha conversion
  ///
  /// In en, this message translates to:
  /// **'1 Masha = 0.972 grams = 1.333 Ana = 8 Ratti'**
  String get mashaInfo;

  /// Hint text for Masha input field
  ///
  /// In en, this message translates to:
  /// **'e.g. 12.5'**
  String get mashaHint;

  /// Semantic label for Masha input field
  ///
  /// In en, this message translates to:
  /// **'Masha weight input field'**
  String get mashaSemanticLabel;

  /// Label for Ana weight unit
  ///
  /// In en, this message translates to:
  /// **'Ana'**
  String get anaLabel;

  /// Information about Ana conversion
  ///
  /// In en, this message translates to:
  /// **'1 Ana = 0.72875 grams = 6 Ratti'**
  String get anaInfo;

  /// Hint text for Ana input field
  ///
  /// In en, this message translates to:
  /// **'e.g. 16.25'**
  String get anaHint;

  /// Semantic label for Ana input field
  ///
  /// In en, this message translates to:
  /// **'Ana weight input field'**
  String get anaSemanticLabel;

  /// Label for Ratti weight unit
  ///
  /// In en, this message translates to:
  /// **'Ratti'**
  String get rattiLabel;

  /// Information about Ratti conversion
  ///
  /// In en, this message translates to:
  /// **'1 Ratti = 0.1215 grams'**
  String get rattiInfo;

  /// Hint text for Ratti input field
  ///
  /// In en, this message translates to:
  /// **'e.g. 96.75'**
  String get rattiHint;

  /// Semantic label for Ratti input field
  ///
  /// In en, this message translates to:
  /// **'Ratti weight input field'**
  String get rattiSemanticLabel;

  /// Label for Lal weight unit (Nepal)
  ///
  /// In en, this message translates to:
  /// **'Lal'**
  String get lalLabel;

  /// Information about Lal conversion
  ///
  /// In en, this message translates to:
  /// **'1 Lal = 0.1166 grams = 0.01 Tola (100 Lal = 1 Tola)'**
  String get lalInfo;

  /// Hint text for Lal input field
  ///
  /// In en, this message translates to:
  /// **'e.g. 25'**
  String get lalHint;

  /// Semantic label for Lal input field
  ///
  /// In en, this message translates to:
  /// **'Lal weight input field'**
  String get lalSemanticLabel;

  /// Label for Gram weight unit
  ///
  /// In en, this message translates to:
  /// **'Gram'**
  String get gramLabel;

  /// Information about Gram input
  ///
  /// In en, this message translates to:
  /// **'Direct gram input'**
  String get gramInfo;

  /// Hint text for Gram input field
  ///
  /// In en, this message translates to:
  /// **'e.g. 11.66'**
  String get gramHint;

  /// Semantic label for Gram input field
  ///
  /// In en, this message translates to:
  /// **'Gram weight input field'**
  String get gramSemanticLabel;

  /// Label for Gold Rate input field
  ///
  /// In en, this message translates to:
  /// **'Gold Rate'**
  String get goldRateLabel;

  /// Information about Gold Rate input
  ///
  /// In en, this message translates to:
  /// **'Current market rate per unit'**
  String get goldRateInfo;

  /// Hint text for Gold Rate input field
  ///
  /// In en, this message translates to:
  /// **'e.g. 150,000'**
  String get goldRateHint;

  /// Semantic label for Gold Rate input field
  ///
  /// In en, this message translates to:
  /// **'Gold rate input field'**
  String get goldRateSemanticLabel;

  /// Label for Calculate button
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get calculateButton;

  /// Semantic label for Calculate button
  ///
  /// In en, this message translates to:
  /// **'Calculate gold weight conversion'**
  String get calculateSemanticLabel;

  /// Label for Clear All button
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAllButton;

  /// Semantic label for Clear All button
  ///
  /// In en, this message translates to:
  /// **'Clear all input fields'**
  String get clearAllSemanticLabel;

  /// Title for conversion results section
  ///
  /// In en, this message translates to:
  /// **'Conversion Details'**
  String get conversionDetails;

  /// Tola conversion result text
  ///
  /// In en, this message translates to:
  /// **'Tola: {value} × {factor} = {result} grams'**
  String tolaConversion(String value, String factor, String result);

  /// Masha conversion result text
  ///
  /// In en, this message translates to:
  /// **'Masha: {value} × {factor} = {result} grams'**
  String mashaConversion(String value, String factor, String result);

  /// Ana conversion result text
  ///
  /// In en, this message translates to:
  /// **'Ana: {value} × {factor} = {result} grams'**
  String anaConversion(String value, String factor, String result);

  /// Ratti conversion result text
  ///
  /// In en, this message translates to:
  /// **'Ratti: {value} × {factor} = {result} grams'**
  String rattiConversion(String value, String factor, String result);

  /// Lal conversion result text
  ///
  /// In en, this message translates to:
  /// **'Lal: {value} × {factor} = {result} grams'**
  String lalConversion(String value, String factor, String result);

  /// Gram conversion result text
  ///
  /// In en, this message translates to:
  /// **'Gram: {value} grams'**
  String gramConversion(String value);

  /// Total weight calculation result
  ///
  /// In en, this message translates to:
  /// **'Total Weight: {value} grams'**
  String totalWeight(String value);

  /// Header for converted values section
  ///
  /// In en, this message translates to:
  /// **'Converted to:'**
  String get convertedTo;

  /// Tola result after conversion
  ///
  /// In en, this message translates to:
  /// **'Tola: {value}'**
  String tolaResult(String value);

  /// Lal result after conversion
  ///
  /// In en, this message translates to:
  /// **'Lal: {value}'**
  String lalResult(String value);

  /// Masha result after conversion
  ///
  /// In en, this message translates to:
  /// **'Masha: {value}'**
  String mashaResult(String value);

  /// Ana result after conversion
  ///
  /// In en, this message translates to:
  /// **'Ana: {value}'**
  String anaResult(String value);

  /// Ratti result after conversion
  ///
  /// In en, this message translates to:
  /// **'Ratti: {value}'**
  String rattiResult(String value);

  /// Gold price calculation result
  ///
  /// In en, this message translates to:
  /// **'Gold Price: {price}'**
  String goldPrice(String price);

  /// Rate information for gold price
  ///
  /// In en, this message translates to:
  /// **'(Rate: {rate} per {unit})'**
  String rateInfo(String rate, String unit);

  /// Unit name for Tola
  ///
  /// In en, this message translates to:
  /// **'Tola'**
  String get unitTola;

  /// Unit name for Lal
  ///
  /// In en, this message translates to:
  /// **'Lal'**
  String get unitLal;

  /// Unit name for 10 Gram
  ///
  /// In en, this message translates to:
  /// **'10 Gram'**
  String get unitTenGram;

  /// Unit name for 1 Gram
  ///
  /// In en, this message translates to:
  /// **'1 Gram'**
  String get unitOneGram;

  /// Hint text for entering a value
  ///
  /// In en, this message translates to:
  /// **'Enter {label} value'**
  String enterValueHint(String label);

  /// Semantic label for input field
  ///
  /// In en, this message translates to:
  /// **'{label} input field'**
  String inputFieldSemantic(String label);

  /// Semantic label for unit selector dropdown
  ///
  /// In en, this message translates to:
  /// **'{label} unit selector'**
  String unitSelectorSemantic(String label);

  /// Label for converter navigation tab
  ///
  /// In en, this message translates to:
  /// **'Converter'**
  String get converterTabLabel;

  /// Label for settings navigation tab
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTabLabel;

  /// Title of the settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Label for theme settings section
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsThemeLabel;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// Label for dark mode toggle
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkModeLabel;

  /// Subtitle for dark mode toggle
  ///
  /// In en, this message translates to:
  /// **'Switch between dark and light themes'**
  String get darkModeSubtitle;

  /// System theme option
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// Label for language settings section
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageLabel;

  /// Label for currency settings section in the drawer
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get settingsCurrencyLabel;

  /// Heading shown on currency selection bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Select your currency'**
  String get currencySelectionPrompt;

  /// Hint text for currency search field
  ///
  /// In en, this message translates to:
  /// **'Search by code, name, or symbol'**
  String get currencySearchHint;

  /// Empty state when currency search has no results
  ///
  /// In en, this message translates to:
  /// **'No currencies match your search'**
  String get currencySearchEmpty;

  /// Heading shown on language selection bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Please select your language'**
  String get languageSelectionPrompt;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Urdu language option
  ///
  /// In en, this message translates to:
  /// **'Urdu'**
  String get languageUrdu;

  /// Arabic language option
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get languageArabic;

  /// Hindi language option
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get languageHindi;

  /// Turkish language option
  ///
  /// In en, this message translates to:
  /// **'Turkish'**
  String get languageTurkish;

  /// Note about future language support
  ///
  /// In en, this message translates to:
  /// **'More languages coming soon'**
  String get languageNote;

  /// Label for about section
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAboutLabel;

  /// Version label in about section
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get aboutVersion;

  /// Description of the app
  ///
  /// In en, this message translates to:
  /// **'Gold Weight Converter is a simple and efficient tool for converting between various traditional gold weight units and grams.'**
  String get aboutDescription;

  /// Fallback text for unknown values
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknownLabel;

  /// Drawer menu label for gold zakat screen
  ///
  /// In en, this message translates to:
  /// **'Gold Zakat'**
  String get zakatMenuLabel;

  /// App bar title for gold zakat screen
  ///
  /// In en, this message translates to:
  /// **'Gold Zakat'**
  String get zakatScreenTitle;

  /// Disclaimer shown on the zakat screen
  ///
  /// In en, this message translates to:
  /// **'Helper for gold items only — not a full zakat assessment or religious ruling. Other assets and nisab are your responsibility; consult a local scholar.'**
  String get zakatDisclaimer;

  /// Info text under zakat gold rate field
  ///
  /// In en, this message translates to:
  /// **'Market rate for 24K / pure gold per unit'**
  String get zakatRateInfo;

  /// Section title for gold items list
  ///
  /// In en, this message translates to:
  /// **'Your gold items'**
  String get zakatItemsTitle;

  /// Button to add a gold item
  ///
  /// In en, this message translates to:
  /// **'Add item'**
  String get zakatAddItem;

  /// Title when editing a gold item
  ///
  /// In en, this message translates to:
  /// **'Edit item'**
  String get zakatEditItem;

  /// Empty state when no zakat items exist
  ///
  /// In en, this message translates to:
  /// **'No gold items yet. Add jewelry or bars to calculate zakat.'**
  String get zakatEmptyItems;

  /// Label for optional item name
  ///
  /// In en, this message translates to:
  /// **'Name (optional)'**
  String get zakatItemNameLabel;

  /// Hint for optional item name
  ///
  /// In en, this message translates to:
  /// **'e.g. Wedding ring'**
  String get zakatItemNameHint;

  /// Label for item weight
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get zakatWeightLabel;

  /// Hint for item weight
  ///
  /// In en, this message translates to:
  /// **'e.g. 10'**
  String get zakatWeightHint;

  /// Label for weight unit dropdown
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get zakatWeightUnitLabel;

  /// Label for purity dropdown
  ///
  /// In en, this message translates to:
  /// **'Purity'**
  String get zakatPurityLabel;

  /// Label for custom karat input
  ///
  /// In en, this message translates to:
  /// **'Custom karat (1–24)'**
  String get zakatCustomKaratLabel;

  /// Hint for custom karat
  ///
  /// In en, this message translates to:
  /// **'e.g. 20'**
  String get zakatCustomKaratHint;

  /// 24 karat purity option
  ///
  /// In en, this message translates to:
  /// **'24K (pure)'**
  String get zakatPurity24k;

  /// 22 karat purity option
  ///
  /// In en, this message translates to:
  /// **'22K'**
  String get zakatPurity22k;

  /// 21 karat purity option
  ///
  /// In en, this message translates to:
  /// **'21K'**
  String get zakatPurity21k;

  /// 18 karat purity option
  ///
  /// In en, this message translates to:
  /// **'18K'**
  String get zakatPurity18k;

  /// Custom purity option
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get zakatPurityCustom;

  /// Save item button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get zakatSaveItem;

  /// Delete item button
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get zakatDeleteItem;

  /// Title for delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Delete gold item?'**
  String get zakatDeleteConfirmTitle;

  /// Message for delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'This will remove \"{name}\" from your zakat list.'**
  String zakatDeleteConfirmMessage(String name);

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get zakatCancel;

  /// Fallback name when item has no name
  ///
  /// In en, this message translates to:
  /// **'Gold item'**
  String get zakatUntitledItem;

  /// Title for zakat results card
  ///
  /// In en, this message translates to:
  /// **'Zakat summary'**
  String get zakatSummaryTitle;

  /// Label for total pure gold
  ///
  /// In en, this message translates to:
  /// **'Total pure gold'**
  String get zakatTotalPureGold;

  /// Formatted pure gold weight
  ///
  /// In en, this message translates to:
  /// **'{grams} g ({tola} tola)'**
  String zakatPureGoldValue(String grams, String tola);

  /// Label for estimated total value
  ///
  /// In en, this message translates to:
  /// **'Estimated value'**
  String get zakatTotalValue;

  /// Label for zakat amount
  ///
  /// In en, this message translates to:
  /// **'Zakat on these items (2.5%)'**
  String get zakatDueLabel;

  /// Prompt when rate is missing
  ///
  /// In en, this message translates to:
  /// **'Enter gold rate to estimate value and zakat'**
  String get zakatEnterRatePrompt;

  /// Button to calculate and track zakat
  ///
  /// In en, this message translates to:
  /// **'Calculate zakat'**
  String get zakatCalculateButton;

  /// Secondary line for an item row
  ///
  /// In en, this message translates to:
  /// **'{weight} {unit} · {purity}'**
  String zakatItemDetail(String weight, String unit, String purity);

  /// Validation when weight is missing or zero
  ///
  /// In en, this message translates to:
  /// **'Enter a weight greater than zero'**
  String get zakatValidationWeight;

  /// Validation for custom karat
  ///
  /// In en, this message translates to:
  /// **'Enter a karat between 1 and 24'**
  String get zakatValidationKarat;

  /// Tooltip for copying results to the clipboard
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copyResults;

  /// Tooltip for sharing results
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareResults;

  /// SnackBar shown after results are copied
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get resultsCopied;

  /// Drawer item that opens the privacy policy
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicyLabel;

  /// Drawer item that opens the Play Store listing
  ///
  /// In en, this message translates to:
  /// **'Rate app'**
  String get rateAppLabel;

  /// Drawer item that opens the developer's other apps on the store
  ///
  /// In en, this message translates to:
  /// **'More apps'**
  String get moreAppsLabel;

  /// Drawer item that shares a link to the app
  ///
  /// In en, this message translates to:
  /// **'Share app'**
  String get shareAppLabel;

  /// Text shared when the user shares the app
  ///
  /// In en, this message translates to:
  /// **'Convert gold weights with Gold Weight Converter: {url}'**
  String shareAppMessage(String url);

  /// SnackBar when a URL cannot be launched
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the link'**
  String get openLinkFailed;

  /// SnackBar when a Play flexible update has finished downloading
  ///
  /// In en, this message translates to:
  /// **'Update downloaded. Restart to install.'**
  String get appUpdateReady;

  /// SnackBar action that applies a downloaded Play update
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get appUpdateRestart;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'am',
    'ar',
    'bn',
    'en',
    'es',
    'fa',
    'fil',
    'fr',
    'hi',
    'id',
    'ms',
    'my',
    'ne',
    'ps',
    'sd',
    'si',
    'ta',
    'tr',
    'ur',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'ur':
      {
        switch (locale.countryCode) {
          case 'RO':
            return AppLocalizationsUrRo();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am':
      return AppLocalizationsAm();
    case 'ar':
      return AppLocalizationsAr();
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fa':
      return AppLocalizationsFa();
    case 'fil':
      return AppLocalizationsFil();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'ms':
      return AppLocalizationsMs();
    case 'my':
      return AppLocalizationsMy();
    case 'ne':
      return AppLocalizationsNe();
    case 'ps':
      return AppLocalizationsPs();
    case 'sd':
      return AppLocalizationsSd();
    case 'si':
      return AppLocalizationsSi();
    case 'ta':
      return AppLocalizationsTa();
    case 'tr':
      return AppLocalizationsTr();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
