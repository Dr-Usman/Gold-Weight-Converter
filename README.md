# Gold Weight Converter App

A clean, open-source Flutter app to convert gold weight between traditional South Asian units (Tola, Masha, Ana, Ratti, Lal) and metric units (Gram), with gold price estimation, display-currency formatting, and a gold zakat calculator.

**[Try the live demo](https://dr-usman.github.io/Gold-Weight-Converter/)**

![Gold Weight Converter Banner](docs/feature-graphics/feature-graphic-en.png)

## Features

- Convert weights between Tola, Masha, Ana, Ratti, Lal and Gram
- Calculate gold price by rate per Tola, per 10 Gram, or per 1 Gram
- Localized conversion breakdown with copy and share actions
- Converter gold rate and rate unit remembered across sessions
- Gold zakat calculator (drawer → Gold Zakat)
  - Add items with weight, unit, and purity (24K / 22K / 21K / 18K / custom karat)
  - Shared 24K market rate; applies 2.5% on listed items (no nisab gate)
  - Pure-gold grams, estimated value, and zakat due summary
  - Copy and share zakat summary
  - Items and rate persisted across sessions
- Searchable display currency preference in the drawer (locale-aware default; formatting only, no FX conversion)
- Show conversion and pricing breakdown with readable formulas
- Persisted theme support: light, dark, and system mode
- Multilingual UI with in-app language switching (20 supported locales)
- Smart numeric input formatting with thousands separators
- Clear-all reset for all fields and computed results
- Accessibility labels for key input fields
- In-drawer About, Privacy policy, Rate app, More apps, and Share app links

## Download

- Please choose one Android source (GitHub Releases or Play Store). Switching sources may require uninstall/reinstall because signing certificates differ.

<a href="https://github.com/Dr-Usman/Gold-Weight-Converter/releases/latest">
  <img src="https://github.com/user-attachments/assets/7f24e68f-1bee-4cab-a0ec-5a5ec66632c2" width="250" alt="Download from GitHub Releases" />
</a>
<a href="https://play.google.com/store/apps/details?id=com.avenzor.gold_weight_converter">
  <img src="https://github.com/user-attachments/assets/2038fc47-dd6c-488c-b423-598723600d6e" width="250" alt="Download from Google Play" />
</a>

## Screenshots

| Converter | Results & price |
| --- | --- |
| <img width="300" alt="Convert Tola, Masha, Ana, Ratti and Gram" src="docs/screenshots/01-converter-light.png" /> | <img width="300" alt="Conversion details with copy/share and gold price summary" src="docs/screenshots/02-results-and-price.png" /> |
| **Gold zakat** | **Currency** |
| <img width="300" alt="Gold zakat calculator with item purity, 2.5% summary, and copy/share" src="docs/screenshots/03-gold-zakat.png" /> | <img width="300" alt="Searchable display currency picker" src="docs/screenshots/04-currency.png" /> |
| **Languages** | **Dark mode** |
| <img width="300" alt="Language selection with 20 supported locales" src="docs/screenshots/05-languages.png" /> | <img width="300" alt="Converter screen in dark mode" src="docs/screenshots/06-dark-mode.png" /> |
| **Menu & settings** | |
| <img width="300" alt="App drawer with zakat, Light/Dark/System theme, language, currency, and about links" src="docs/screenshots/07-menu-settings.png" /> | |

## Conversion Table

| Unit    | Gram Equivalent | Notes                            |
| ------- | --------------- | -------------------------------- |
| 1 Tola  | 11.66 g         | = 12 Masha = 16 Ana = 96 Ratti = 100 Lal |
| 1 Masha | 0.972 g         | = 1.333 Ana = 8 Ratti           |
| 1 Ana   | 0.72875 g       | = 6 Ratti = 6.25 Lal            |
| 1 Ratti | 0.1215 g        |                                  |
| 1 Lal   | 0.1166 g        | = 1/100 Tola (traditional unit in Nepal) |

These are standard traditional conversion factors used in the app calculations.

## Supported Languages

The app supports 20 locales:

| Language | Code | Language | Code |
|---|---|---|---|
| English | `en` | हिंदी (Hindi) | `hi` |
| اردو (Urdu) | `ur` | Roman Urdu | `ur-RO` |
| বাংলা (Bengali) | `bn` | नेपाली (Nepali) | `ne` |
| العربية (Arabic) | `ar` | Español (Spanish) | `es` |
| Français (French) | `fr` | Filipino | `fil` |
| தமிழ் (Tamil) | `ta` | မြန်မာစာ (Burmese) | `my` |
| සිංහල (Sinhala) | `si` | አማርኛ (Amharic) | `am` |
| فارسی (Persian) | `fa` | پښتو (Pashto) | `ps` |
| سنڌي (Sindhi) | `sd` | Indonesia (Indonesian) | `id` |
| Melayu (Malay) | `ms` | Türkçe (Turkish) | `tr` |

Language can be changed from the settings drawer and is persisted across sessions.

## Supported Currencies

The app supports 36 display currencies with locale-aware number and symbol formatting:

| Currency | Code | Symbol | Currency | Code | Symbol |
|---|---|---|---|---|---|
| Indian Rupee | `INR` | ₹ | Pakistani Rupee | `PKR` | Rs. |
| Bangladeshi Taka | `BDT` | ৳ | US Dollar | `USD` | $ |
| Nepalese Rupee | `NPR` | Rs. | Saudi Riyal | `SAR` | SAR |
| UAE Dirham | `AED` | AED | British Pound | `GBP` | £ |
| Euro | `EUR` | € | Sri Lankan Rupee | `LKR` | Rs. |
| Malaysian Ringgit | `MYR` | RM | Philippine Peso | `PHP` | ₱ |
| Indonesian Rupiah | `IDR` | Rp | Qatari Riyal | `QAR` | QAR |
| Kuwaiti Dinar | `KWD` | KD | Omani Rial | `OMR` | OMR |
| Bahraini Dinar | `BHD` | BD | Canadian Dollar | `CAD` | CA$ |
| Australian Dollar | `AUD` | A$ | Japanese Yen | `JPY` | ¥ |
| Turkish Lira | `TRY` | ₺ | Egyptian Pound | `EGP` | E£ |
| Afghan Afghani | `AFN` | ؋ | Iranian Rial | `IRR` | ﷼ |
| Ethiopian Birr | `ETB` | Br | Ghanaian Cedi | `GHS` | GH₵ |
| Myanmar Kyat | `MMK` | K | South African Rand | `ZAR` | R |
| Nigerian Naira | `NGN` | ₦ | Kenyan Shilling | `KES` | KSh |
| Sierra Leonean Leone | `SLE` | Le | Thai Baht | `THB` | ฿ |
| Hong Kong Dollar | `HKD` | HK$ | Singapore Dollar | `SGD` | S$ |
| Chinese Yuan | `CNY` | ¥ | Swiss Franc | `CHF` | CHF |

*Currency selection formats gold price and zakat calculations for your region; there is no live currency exchange (FX) conversion.*

## Supported Platforms

- Android
- iOS
- Web
- macOS
- Linux
- Windows

Android is the primary distributed platform (Play Store + GitHub release APKs).

## Getting Started

### Prerequisites

- Flutter SDK (latest stable): https://flutter.dev/docs/get-started/install
- Dart SDK compatible with this project: ^3.11.5 (bundled with Flutter)
- Android Studio or VS Code
- A connected device or emulator

### Installation

1. Clone the repository:

```bash
git clone https://github.com/Dr-Usman/Gold-Weight-Converter.git
cd Gold-Weight-Converter
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

## Developer Workflow

### Quality checks

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

### Useful test commands

```bash
flutter test test/widget_test.dart
flutter test test/zakat_calculator_test.dart
flutter test test/widget_test.dart --plain-name 'calculates gold price using the tola rate unit'
```

### Build commands

```bash
flutter build apk --debug
flutter build apk --release
flutter build apk --split-per-abi
flutter build appbundle
flutter build web --release --base-href "/Gold-Weight-Converter/"
```

Hide banner ads (README / store screenshots, or a quieter debug run):

```bash
flutter run --dart-define=HIDE_ADS=true
flutter build apk --debug --dart-define=HIDE_ADS=true
```

Prefill converter demo values and auto-calculate (pair with `HIDE_ADS` for README shots):

```bash
flutter run --dart-define=HIDE_ADS=true --dart-define=SCREENSHOT_DEMO=true
```

## Architecture At A Glance

- App bootstrap in `lib/main.dart` initializes PreferencesService and injects it via Riverpod `ProviderScope` override; `lib/app.dart` hosts `MaterialApp`.
- Screens live in `lib/screens/` (`converter_screen.dart`, `zakat_screen.dart`).
- Shared conversion and zakat math live in `lib/services/` (`weight_converter.dart`, `zakat_calculator.dart`).
- State is managed by Riverpod providers in `lib/providers/` for theme, locale, currency, converter results, zakat items, rate unit, and app version.
- Shared preference persistence is centralized in `lib/services/preferences_service.dart`.
- Reusable UI components are in `lib/widgets/` (input field, drawer, language/currency sheets, gold item sheet).
- Localization is generated from ARB files in `lib/l10n/`.

## Releases

- Version is maintained in [pubspec.yaml](pubspec.yaml).
- Change history is tracked in CHANGELOG.md.
- For each release, bump `pubspec.yaml` and add developer notes under `## [X.Y.Z]` in CHANGELOG.md plus a short **user-facing** `### Play Store (en-US)` section (paste into Google Play Console). Keep Play Store copy plain-language; no separate what’s-new file.
- Tagging `v*` creates a GitHub Release titled **GWC vX.Y.Z**. Release body is generated from that CHANGELOG section (Play Store subsection excluded) with a Full Changelog link at the bottom.
- Per-platform workflows attach versioned assets:
  - Android: `gwc-android-X.Y.Z-universal.apk` + ABI splits
  - Web: `gwc-web-X.Y.Z.zip`
  - macOS: `gwc-macos-X.Y.Z.zip`
  - Linux: `gwc-linux-X.Y.Z-x64.tar.gz`
  - Windows: `gwc-windows-X.Y.Z-x64.zip`
  - iOS: manual `workflow_dispatch` only (signing secrets required)
- The same `v*` tags also deploy the web build to GitHub Pages (`.github/workflows/deploy-pages.yml`), live at https://dr-usman.github.io/Gold-Weight-Converter/.

Example release flow:

```bash
# 1. Bump pubspec.yaml version (e.g. 1.7.0+9)
# 2. Update CHANGELOG.md (developer notes + ### Play Store section)
git add pubspec.yaml CHANGELOG.md
git commit -m "release: vX.Y.Z+N"
git tag vX.Y.Z
git push origin main --tags
```

Then paste the Play Store section from [CHANGELOG.md](CHANGELOG.md) into Google Play Console → Release → Release notes.

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for contribution workflow, checks, and pull request guidance.

## Privacy Policy

[Privacy Policy](https://dr-usman.github.io/Gold-Weight-Converter/privacy-policy.html)

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
