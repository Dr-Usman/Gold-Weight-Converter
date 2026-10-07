# Changelog

All notable changes to the Gold Weight Converter project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.9.6] - 2026-10-07

### Added
- Troy Ounce (`Ounce`) rate and weight conversion support across gold converter and zakat calculations
- Dynamic Ounce input field automatically displayed when the market rate unit is set to Ounce
- Automatic Ounce equivalent weight displayed in conversion details (`Ounce: X.XXXX oz`)
- Complete native translations for Troy Ounce across all 19 non-English languages
- Support for Tanzanian Shilling (`TZS`) display currency with automatic country code detection (`TZ`)
- Automatic USD default mapping for international markets including Zimbabwe (`ZW`), Guyana (`GY`), Iraq (`IQ`), Lebanon (`LB`), Liberia (`LR`), Somalia (`SO`), Malawi (`MW`), Papua New Guinea (`PG`), Sudan (`SD`), Yemen (`YE`), Uzbekistan (`UZ`), and Cambodia (`KH`)
- Device system locale (`device_locale`) and timezone offset (`device_timezone_offset`) registered as Mixpanel Super Properties and synced to People profiles for improved geographical analytics

### Changed
- Reordered Conversion Details breakdown so Ounce calculations are grouped with other multiplied unit formulas and direct Gram input appears cleanly at the end
- Expanded the rate unit dropdown width and improved horizontal padding to provide clean, truncation-free unit labels
- Implemented smart hybrid flushing in `AnalyticsService` for real-time debug tracking and guaranteed delivery of key conversions in release builds
- Migrated Android application build configuration to Android Gradle Plugin Built-in Kotlin (removed legacy `kotlin-android`)

### Play Store (en-US)
```
What's new in 1.9.6
• Added Troy Ounce (Ounce) rate and weight conversion support
• Dynamic Ounce input field appears when Ounce rate is selected
• Complete translations for Ounce across all 20 languages
• Added Tanzanian Shilling (TZS) currency support
• Improved calculation breakdown and unit dropdown layout
```

---

## [1.9.5] - 2026-10-02

### Added
- National flag emojis displayed beside all 20 supported languages in the Language selection sheet (with the US flag for English)
- Support for Latin American display currencies: Argentine Peso (`ARS`), Colombian Peso (`COP`), and Venezuelan Bolívar (`VES`)
- Automatic initial currency detection for devices configured with Argentina (`AR`), Colombia (`CO`), and Venezuela (`VE`) country codes
- Unified `drawer_item_clicked` Mixpanel tracking for all navigation, settings, and external actions in the app drawer

### Changed
- Streamlined product analytics by consolidating drawer interactions into a single event and eliminating redundant standalone link events
- Upgraded CI/CD GitHub Actions workflows to modern releases with Node 24 support

### Play Store (en-US)
```
What's new in 1.9.5
• Added national flag icons in the language selection menu
• Added support for Argentine Peso (ARS), Colombian Peso (COP), and Venezuelan Bolívar (VES)
• Automatic local currency detection for Argentina, Colombia, and Venezuela
• Performance improvements and bug fixes
```

---

## [1.9.4] - 2026-09-30

### Added
- Rate-driven decimal formatting: whole number gold rates format price results as whole integers without redundant decimals, while fractional rates preserve 2-decimal precision
- Upper digit ceiling rounding (`ceilToDouble`) for Gold Zakat calculations when gold rate is a whole number, ensuring religious obligations are never underpaid
- Comprehensive widget test scenarios covering whole and fractional rates, 10 Gram rate units, traditional units, and multi-item mixed-purity zakat calculations (123 total tests)

### Changed
- Redesigned the Converter price result card with bold 16sp selectable price text and 14sp secondary rate information, removing the fixed dollar icon for maximum horizontal room
- Refactored monolithic screen files into clean, modular feature folders (`lib/screens/converter/` and `lib/screens/zakat/`) with dedicated subcomponents

### Fixed
- Fixed keyboard unexpectedly restoring over the navigation drawer when opened after calculating or tapping outside an input field

### Play Store (en-US)
```
What's new in 1.9.4
• Smarter price rounding based on entered gold rate
• Zakat calculation rounds up to ensure complete fulfillment
• Redesigned, cleaner price result display
• Fixed keyboard showing when opening the drawer
• Performance improvements and bug fixes
```

---

## [1.9.3] - 2026-09-30

### Fixed
- Fixed default currency detection on first app launch for users in Pakistan and South Asia whose device display language is set to English (United Kingdom) or English (United States)
- Added timezone offset disambiguation so ambiguous locales like `en_GB` and `en_US` correctly default to regional currencies (e.g. `PKR` for PKT +05:00, `INR` for IST +05:30, `NPR` for NPT +05:45, `BDT` for BST +06:00, `AED` for GST +04:00, and `SAR` for AST +03:00)

### Added
- Unit test suite validating timezone-aware initial currency resolution across standard, ambiguous, and fallback locales

### Play Store (en-US)
```
What's new in 1.9.3
• Improved automatic currency detection on first launch for Pakistan and South Asia
• Accurate local currency setup based on device timezone
• Performance improvements and bug fixes
```

---

## [1.9.2] - 2026-09-24

### Added
- Registered Mixpanel Super Properties (`preferred_language`, `theme_mode`, `preferred_currency`) so user preferences automatically attach client-side to every tracked event
- Independent fallback and graceful preference initialization for first-time installs before `app_opened` fires
- Dynamic Super Property updates whenever users change their language, theme mode, or display currency
- Unit test suite for analytics helpers and preference value resolvers

### Play Store (en-US)
```
What's new in 1.9.2
• Improved app reliability and user settings persistence
• Performance improvements and bug fixes
```

---

## [1.9.1] - 2026-09-23

### Fixed
- Fixed decimal trailing zero bug in number input formatter, allowing seamless typing of decimal fractions like `0.0`, `2.00`, and `3.5005`
- Fixed caret trapping when backspacing across thousands separator commas
- Prevented invalid multiple decimal points, leading redundant zeros, and negative signs in weight fields

### Added
- Comprehensive test suite covering 55 number formatter edge cases and high-precision unit conversions

### Play Store (en-US)
```
What's new in 1.9.1
• Improved number input when entering decimals and zeros
• Smoother typing and editing across all gold weight fields
• Performance improvements and bug fixes
```

---

## [1.9.0] - 2026-09-23

### Added
- Localized Google Play Store listings, phone mockups, and promotional feature graphics for Pakistan (Urdu) and Bangladesh (Bengali)
- Comprehensive Lal weight unit localization strings across all 20 supported languages
- Enriched Mixpanel analytics tracking for conversion, zakat, copy, and share actions with weight metrics (`total_grams`, `total_tola`, `total_pure_grams`)
- Refreshed high-resolution platform app launcher icons (Android adaptive, iOS, macOS, and Web)

### Play Store (en-US)
```
What's new in 1.9.0
• Localized store listings and graphics for Pakistan and Bangladesh
• Improved Lal weight unit translations across all languages
• Updated modern app icon
• Performance improvements and bug fixes
```

---

## [1.8.0] - 2026-09-07

### Added
- 8 new supported languages: Amharic, Spanish, Filipino, French, Burmese, Nepali, Sinhala, and Tamil (20 languages total)
- Lal weight unit support for Nepali locale and NPR currency mode (100 Lal = 1 Tola, 1 Lal = 0.1166 g)
- "More apps" link in the drawer opening the developer's Google Play catalog
- Mixpanel event: `more_apps_opened`
- High-resolution localized Google Play Store mockups and feature graphics for English, Hindi (India), and Nepali (Nepal)
- Ready-to-use localized store listing copy files (`docs/store-listings/`)

### Play Store (en-US)
```
What's new in 1.8.0
• Added 8 new languages: Spanish, French, Nepali, Filipino, Tamil, Burmese, Sinhala, and Amharic
• Support for Lal weight unit (Nepal)
• "More apps" option in the menu
• Improvements and optimizations
```

---

## [1.7.2] - 2026-08-25

### Added
- Google Play flexible in-app updates on Android (Play Store installs only)
- Restart snackbar when a flexible update finishes downloading (localized)
- Mixpanel events: `app_update_prompted`, `app_update_completed`

### Play Store (en-US)
```
What's new in 1.7.2
• App can download updates from Play in the background
• Tap Restart when prompted to install the update
• No need to open the Play Store listing for routine updates
```

---

## [1.7.0] - 2026-08-21

### Added
- Copy and share actions on converter and zakat result cards
- In-app About dialog, privacy policy, Rate app, and Share app links in the drawer
- Mixpanel events: `results_copied`, `results_shared`, `app_shared`, `rate_app_opened`, `privacy_policy_opened`
- Optional `--dart-define=HIDE_ADS=true` to disable banner ads (screenshots / quiet debug)
- Optional `--dart-define=SCREENSHOT_DEMO=true` to prefill converter demo values for screenshots

### Changed
- Converter result breakdown uses existing localization strings (no longer hardcoded English)
- Converter gold rate and rate unit persist across sessions
- Theme control is Light / Dark / System (system preference is preserved)
- Converter math uses shared `WeightConverter` helpers
- Calculate and Clear All semantic labels use localized strings
- Shortened converter field hints across all locales (e.g. `مثلاً` / `maslan` / `مثل` instead of long “for example” phrases)
- README screenshots updated for copy/share, theme modes, about links, and ad-free captures

### Play Store (en-US)
```
What's new in 1.7.0
• Copy or share your converter and zakat results
• Gold rate and unit remembered for next time
• Choose Light, Dark, or match your system theme
• About, privacy policy, Rate app, and Share app in the menu
• Clearer localized conversion details and shorter field hints
```

---

## [1.6.2] - 2026-08-06

### Added
- More display currencies for high-traffic Play Store regions: Ethiopian Birr (ETB), Thai Baht (THB), Sierra Leonean Leone (SLE), Philippine Peso (PHP), Ghanaian Cedi (GHS), Myanmar Kyat (MMK)
- Drawer language tile shows the selected native language label (same pattern as currency)

### Changed
- Supported currencies live in `lib/constants/currencies.dart`; list ordered by Play Store audience volume
- Supported languages live in `lib/constants/languages.dart` (shared by drawer and language sheet)
- Language drawer icon uses translate glyph
- Mixpanel `conversion_completed` and `zakat_calculated` include `total_grams`

### Play Store (en-US)
```
What's new in 1.6.2
• More currencies: Ethiopia, Thailand, Sierra Leone, Philippines, Ghana, and Myanmar
• Currency list reordered for the regions using the app most
• Drawer now shows your selected language at a glance
```

---

## [1.6.1] - 2026-07-30

### Fixed
- Android release crash on startup under AGP 9 R8 full mode
  - Force `androidx.work:work-runtime:2.11.2` (AdMob was pulling 2.7.0)
  - Keep Room/WorkManager reflective constructors in ProGuard rules
  - Resolves Play Console “16 KB page size” lab crash (`WorkDatabase` / `InitializationProvider`)

### Play Store (en-US)
```
What's new in 1.6.1
• Stability fix for Android startup crashes reported in Play review
• Same features as 1.6.0 (ads, privacy policy, safer bottom sheets)
```

---

## [1.6.0] - 2026-07-29

### Added
- AdMob inline adaptive banner ads on converter and zakat screens
  - Test ad units in debug/profile; production units in release
  - Non-sticky banners inside scroll content via `AppBannerAd`
- Hosted privacy policy page (`web/privacy-policy.html`) linked from README
- Local app screenshots in README

### Changed
- Android toolchain: Gradle 9.1, AGP 9.0.1, Kotlin 2.3.20
- iOS and macOS: migrate plugin dependencies from CocoaPods to Swift Package Manager

### Fixed
- Language/currency bottom sheets respect system safe area (home indicator)

### Play Store (en-US)
```
What's new in 1.6.0
• Light ads on the converter and zakat screens help keep the app free
• Privacy policy is now available on the app website
• Bottom sheets sit correctly above the home indicator
• Under-the-hood updates for smoother builds and installs
```

---

## [1.5.0] - 2026-07-24

### Added
- Gold zakat calculator (drawer → Gold Zakat)
  - Dynamic gold items with weight, unit, and purity (24K / 22K / 21K / 18K / custom karat)
  - Shared 24K market rate; always applies 2.5% on listed items (no nisab gate)
  - Pure-gold grams, estimated value, and zakat due summary
  - Items and rate persisted via SharedPreferences
  - Mixpanel `zakat_calculated` event (`item_count`, `rate_unit`, `is_gold_rate_set`)
- Searchable display currency preference in the drawer
  - Common currencies with locale-aware default and persistence
  - Applied to converter and zakat value formatting (no FX conversion)
  - Mixpanel `currency_changed` event and People property `preferred_currency`
- Shared `WeightConverter` / `ZakatCalculator` services with unit tests

### Changed
- GitHub Releases now use CHANGELOG-driven notes (title `GWC vX.Y.Z`, Play Store section excluded) and versioned multi-platform assets (`gwc-android-*`, `gwc-web-*`, `gwc-macos-*`, `gwc-linux-*`, `gwc-windows-*`)

### Fixed
- Android: disable Impeller to avoid native crashes on some Qualcomm Adreno/Vulkan drivers (`PipelineVK` / `vkCreateGraphicsPipelines`)

### Play Store (en-US)
```
What's new in 1.5.0
• Calculate gold zakat from your items with weight, purity, and a 2.5% summary
• Choose your display currency from the drawer (searchable list)
• Clearer value formatting on converter and zakat screens
• Improved stability on some Android devices
```

---

## [1.4.0] - 2026-07-23

### Added
- Mixpanel product analytics (`mixpanel_flutter`)
  - `app_opened` on startup
  - `conversion_completed` when Calculate runs with weight input
  - `language_changed` and `theme_changed` preference events
  - People profile properties: `preferred_language`, `theme_mode`
- `AGENTS.md` Mixpanel tracking guidance for future contributors
- Mixpanel web SDK script for Flutter web builds

### Play Store (en-US)
```
What's new in 1.4.0
• Settings now shows version and build number for easier support
• Under-the-hood improvements so we can keep making the converter better
```

---

## [1.3.0] - 2026-05-30

### Added
- Comprehensive multilingual support for 12 languages: English, Urdu, Roman Urdu, Hindi, Bengali, Sindhi, Pashto, Farsi/Persian, Arabic, Malay, Indonesian, and Turkish (#8)
  - ARB localization files with 100+ translated strings per language
  - Language selection bottom sheet with native language labels
  - Locale persistence via shared preferences across app sessions
- Dark theme and system theme support with theme persistence
- App drawer with navigation, theme toggle, and language selection
- Riverpod-based state management (`flutter_riverpod`) replacing `StatefulWidget`
  - `GoldResultNotifier` for result/price state
  - `rateUnitProvider` for unit selection
  - `Consumer` widgets with `select()` to prevent unnecessary rebuilds
- Custom reusable widgets: `GoldTextField`, `LanguageBottomSheet`, `AppDrawer`
- Version provider for displaying app version info
- GitHub Actions workflow for PR checks (format, analyze, test)

### Changed
- Refactored theme system to use Riverpod providers
- Replaced `setState` calls with reactive provider reads/writes
- Extracted `NumberHelper` utility to `lib/utils/number_helper.dart`
- Added `AppConstants` with shared thousand-separator number format
- Updated converter screen for dark theme support
- Used `FocusManager` to unfocus text fields when drawer opens
- Polished language selection bottom sheet UI

### Fixed
- Guarded Android keystore configuration with fallback to debug signing
- Handle unsupported locales with fallback resolution
- Renamed test override `saveLanguage` to `saveLocale` for consistency

---

## [1.2.0] - 2026-04-16

### Added
- Riverpod state management migration (`flutter_riverpod` dependency)
  - `UnitEnum` (tola, tenGram, oneGram) with `fromString` helper
  - `GoldResultModel` for `weightsText`/`priceText` state
  - `GoldResultNotifier` (`NotifierProvider`) for result/price management
  - `rateUnitProvider` (`StateProvider<UnitEnum>`) for unit selection
  - `NumberHelper` extracted to `lib/utils/number_helper.dart`
  - `AppConstants` with shared formatting utilities
- Enhanced gold theme redesign for improved visuals (#2)
  - Custom `AppColors` constants
  - Gradient backgrounds, refined card/button/input styling
  - Centralized color literals
- Improved README with download links and description
- GitHub Actions CI workflow for release builds

### Changed
- Refactored `converter_screen.dart` from `StatefulWidget` to `ConsumerStatefulWidget`
- Replaced all `setState` calls with provider reads/writes
- Wrapped Gold Rate field in `Consumer` to isolate unit dropdown rebuilds
- Wrapped result/price sections in `Consumer` with `select()` for performance
- Extracted buttons and result sections into private builder methods
- Bumped macOS deployment target from 10.14 to 10.15
- Updated `flutter_release.yml` to `actions/checkout@v6`

### Fixed
- Added `KEYPROPERTIES_BASE64` decode in CI workflow for Android signing
- Fixed Android package name configuration
- Updated app icons and assets

---

## [1.1.0] - 2025-06-30

### Added
- Custom widgets and utilities for better code organization
  - `GoldTextField` widget with theming support
  - `NumberFormatter` utility for gold price formatting
- Auto-scroll to bottom after calculation
- Real-time input validation and calculation
- Comprehensive test coverage for core functionality
- Workflow improvements and documentation updates

### Changed
- Enhanced UI design with gradients and improved styling
- Improved gold price text formatting with better readability
- Major refactor of `converter_screen.dart` (+792/-176 lines)
- Updated `main.dart` with improved app structure

---

## [1.0.0] - 2025-05-15

### Added
- Initial release of Gold Weight Converter
- Multi-platform support: Android, iOS, Web, Linux, macOS, Windows
- Core converter functionality for gold weight units (Tola, Masha, Ana, Ratti, Gram)
- GitHub Actions workflow for Flutter release builds
- MIT license
- Basic README with project description

[Unreleased]: https://github.com/Dr-Usman/Gold-Weight-Converter/compare/v1.3.0...HEAD
[1.3.0]: https://github.com/Dr-Usman/Gold-Weight-Converter/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/Dr-Usman/Gold-Weight-Converter/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/Dr-Usman/Gold-Weight-Converter/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/Dr-Usman/Gold-Weight-Converter/releases/tag/v1.0.0
