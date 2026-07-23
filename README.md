# Gold Weight Converter App

A clean, open-source Flutter app to convert gold weight between traditional South Asian units (Tola, Masha, Ana, Ratti) and metric units (Gram), with integrated gold price estimation.

**[Try the live demo](https://dr-usman.github.io/Gold-Weight-Converter/)**

## Features

- Convert weights between Tola, Masha, Ana, Ratti, and Gram
- Calculate gold price by rate per Tola, per 10 Gram, or per 1 Gram
- Show conversion and pricing breakdown with readable formulas
- Persisted theme support: light, dark, and system mode
- Multilingual UI with in-app language switching (12 supported locales)
- Smart numeric input formatting with thousands separators
- Clear-all reset for all fields and computed results
- Accessibility labels for key input fields

## Screenshots

|  |  |
| --- | --- |
| <img width="300" alt="Light input form" src="https://github.com/user-attachments/assets/96835e89-90b4-4930-8f46-e0a34a505849" /> | <img width="300" alt="Light input form and result" src="https://github.com/user-attachments/assets/b458f657-6551-48b8-928a-22d5d6606bf8" /> |
| <img width="300" alt="Light and dark theme input form" src="https://github.com/user-attachments/assets/cac8e63c-bee3-444e-abd0-7ea27a1311b5" /> | <img width="300" alt="App drawer preview" src="https://github.com/user-attachments/assets/8dc678ed-2a1d-48cc-a91b-84c562519b2f" /> |
| <img width="300" alt="Language bottom sheet" src="https://github.com/user-attachments/assets/94c962b8-651a-47ac-a2aa-1f480718ae53" /> | |

## Download

- Please choose one Android source (GitHub Releases or Play Store). Switching sources may require uninstall/reinstall because signing certificates differ.

<a href="https://github.com/Dr-Usman/Gold-Weight-Converter/releases/latest">
  <img src="https://github.com/user-attachments/assets/7f24e68f-1bee-4cab-a0ec-5a5ec66632c2" width="250" alt="Download from GitHub Releases" />
</a>
<a href="https://play.google.com/store/apps/details?id=com.avenzor.gold_weight_converter">
  <img src="https://github.com/user-attachments/assets/2038fc47-dd6c-488c-b423-598723600d6e" width="250" alt="Download from Google Play" />
</a>

## Conversion Table

| Unit    | Gram Equivalent | Notes                            |
| ------- | --------------- | -------------------------------- |
| 1 Tola  | 11.66 g         | = 12 Masha = 16 Ana = 96 Ratti  |
| 1 Masha | 0.972 g         | = 1.333 Ana = 8 Ratti           |
| 1 Ana   | 0.72875 g       | = 6 Ratti                       |
| 1 Ratti | 0.1215 g        |                                  |

These are standard traditional conversion factors used in the app calculations.

## Supported Languages

The app supports 12 locales:

- English (en)
- Urdu (ur)
- Roman Urdu (ur-RO)
- Arabic (ar)
- Bengali (bn)
- Farsi/Persian (fa)
- Hindi (hi)
- Indonesian (id)
- Malay (ms)
- Pashto (ps)
- Sindhi (sd)
- Turkish (tr)

Language can be changed from the settings drawer and is persisted across sessions.

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

## Architecture At A Glance

- App bootstrap in lib/main.dart initializes PreferencesService and injects it via Riverpod ProviderScope override.
- Core calculator UI and calculation logic live in lib/converter_screen.dart.
- State is managed by Riverpod providers in lib/providers for theme, locale, result text, selected rate unit, and app version.
- Shared preference persistence is centralized in lib/services/preferences_service.dart.
- Reusable UI components are in lib/widgets (input field, settings drawer, language selector).
- Localization is generated from ARB files in lib/l10n.

## Releases

- Version is maintained in pubspec.yaml (current: 1.4.0+4).
- Change history is tracked in CHANGELOG.md.
- GitHub release workflow is tag-driven and runs on tags matching v*.
- The same v* tags also deploy the web build to GitHub Pages (`.github/workflows/deploy-pages.yml`), live at https://dr-usman.github.io/Gold-Weight-Converter/. The Pages deploy can also be run manually via workflow_dispatch.

Example release flow:

```bash
git add pubspec.yaml CHANGELOG.md
git commit -m "release: vX.Y.Z+N"
git tag vX.Y.Z
git push origin main --tags
```

CI then builds universal and split APKs and attaches them to the GitHub Release, and publishes the web build to GitHub Pages.

## Contributing

Please read CONTRIBUTING.md for contribution workflow, checks, and pull request guidance.

## License

This project is licensed under the MIT License. See LICENSE for details.
