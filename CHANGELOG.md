# Changelog

All notable changes to the Gold Weight Converter project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

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
