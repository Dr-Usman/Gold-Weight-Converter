# Contributing

Thanks for contributing to Gold Weight Converter.

## Development Setup

1. Fork and clone the repository.
2. Create a feature branch.

```bash
git checkout -b feature/your-feature-name
```

3. Install dependencies.

```bash
flutter pub get
```

4. Run the app locally.

```bash
flutter run
```

## Required Quality Checks

Before opening a pull request, run:

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

Optional focused checks:

```bash
flutter test test/widget_test.dart
flutter build apk --debug
```

## Pull Request Guidelines

- Keep PRs focused on one logical change.
- Use clear commit messages.
- Add or update tests when behavior changes.
- Update README.md, CHANGELOG.md, and localization files when relevant.
- Ensure all GitHub Action checks pass.

## Localization Updates

If you add or change user-facing text:

1. Update the source ARB file in lib/l10n.
2. Regenerate localization artifacts using standard Flutter localization workflow.
3. Verify language switching behavior from the settings drawer.

## Release Notes

For release-related changes:

- Update pubspec.yaml version.
- Update CHANGELOG.md.
- Use a version tag format like v1.3.0 to trigger release builds.

## Code Style

- Follow Effective Dart guidelines.
- Reuse shared utilities and providers where possible.
- Keep UI styling aligned with centralized constants and theme setup.
