# Changelog

All notable changes to this project are documented in this file.

## v1.3.0 - 2026-05-30

### Highlights
- Polished premium gold-theme redesign across the main converter experience.
- Added full dark mode support with persisted theme preferences and improved drawer/settings UX.
- Delivered comprehensive multilingual support with 12 languages and locale persistence.

### Resolved Issues
- Resolved #2: Gold-themed UI redesign.
- Resolved #5: Dark mode toggle and theming consistency.
- Resolved #8: Multi-language localization support and locale handling.

### Added
- New localization resources and generated localization delegates for Arabic, Urdu, Roman Urdu, Hindi, Bengali, Sindhi, Pashto, Farsi, Malay, Indonesian, and Turkish.
- Language selection bottom sheet and locale persistence via preferences service.
- App drawer settings enhancements including runtime app version display.
- PR checks CI workflow for formatting, analysis, tests, and debug build smoke checks.
- MIT license and project-level Copilot instructions.

### Improved
- Centralized color usage and modernized app theming for light and dark modes.
- Converter UI styling, accessibility labels, and input presentation.
- Widget test coverage and test harness setup for provider-backed app bootstrapping.
- Android signing fallback behavior for local release runs without keystore properties.

### Notes
- This release contains the cumulative changes since v1.2.0 and is tagged as v1.3.0.
