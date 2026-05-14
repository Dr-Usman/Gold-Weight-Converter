# Copilot Instructions

## Build, test, and lint commands

- Install dependencies: `flutter pub get`
- Check formatting the same way CI does: `dart format --output=none --set-exit-if-changed .`
- Run static analysis: `flutter analyze`
- Run the full test suite: `flutter test`
- Run the current widget test file only: `flutter test test/widget_test.dart`
- Run one named test: `flutter test test/widget_test.dart --plain-name 'Calculate button works with tola input'`
- Run the smoke build used in PR checks: `flutter build apk --debug`
- Release builds in CI use tags and produce both universal and split APKs with:
  - `flutter build apk --release`
  - `flutter build apk --split-per-abi`

## High-level architecture

- `lib/main.dart` is the app bootstrap. It initializes `PreferencesService`, then injects it into Riverpod by overriding `preferencesServiceProvider` in the root `ProviderScope`.
- The app is centered on a single main screen: `lib/converter_screen.dart`. That widget owns all text controllers, performs the gold weight and price calculations inline, and pushes the rendered result strings into Riverpod state.
- Riverpod state is split by concern:
  - `providers/theme_provider.dart` persists the current `ThemeMode`
  - `providers/locale_provider.dart` persists the current locale
  - `providers/weight_provider.dart` stores the result text shown below the form
  - `providers/unit_provider.dart` stores the selected rate unit for the gold-rate dropdown
- `widgets/gold_text_field.dart` is the shared input component for both plain numeric fields and the rate field with a unit dropdown. It applies the custom thousands-separator formatter used throughout the app.
- Settings live off the main flow in `widgets/app_drawer.dart` and `widgets/language_bottom_sheet.dart`. The drawer changes theme and language and shows the app version from `providers/version_provider.dart`.
- Localization is generated from `lib/l10n/app_en.arb` using `l10n.yaml` plus `flutter.generate: true` in `pubspec.yaml`. Generated localization files are committed under `lib/l10n/`.

## Key conventions

- Keep persisted UI preferences behind `PreferencesService`. Theme and locale providers read and write through that service rather than using `SharedPreferences` directly from widgets.
- `MyApp` depends on Riverpod providers that ultimately depend on the root `ProviderScope` override for `preferencesServiceProvider`. Widget tests that pump `MyApp` need to supply a `ProviderScope` and a usable preferences override.
- Numeric user input is intentionally formatted with thousands separators while typing. Use `NumberHelper.parseFormattedNumber` for parsing and `ThousandsSeparatorInputFormatter` for input behavior instead of raw `double.parse`.
- Conversion factors also exist in `lib/constants/app_constants.dart`, but `lib/converter_screen.dart` currently keeps local copies of the same ratios for calculation. If you change unit ratios, keep both places aligned unless you intentionally refactor to a single source of truth.
- The app already has localization keys for many conversion-result strings in `app_en.arb`, but `GoldConverterScreen._calculate()` still assembles several result lines as raw English strings. Text changes to calculation output may require updates in both the calculation code and localization resources.
- Styling is intentionally centralized in `lib/constants/app_colors.dart` and the shared theme builder in `MyApp`. Prefer extending those shared definitions over adding one-off colors or field styles inside individual widgets.
