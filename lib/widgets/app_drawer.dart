import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/languages.dart';
import '../l10n/app_localizations.dart';
import '../providers/currency_provider.dart';
import '../providers/locale_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/version_provider.dart';
import '../screens/zakat_screen.dart';
import 'currency_bottom_sheet.dart';
import 'language_bottom_sheet.dart';

/// Drawer shell — no provider watches. Each row owns its own watch so a
/// currency/theme/version update does not rebuild the whole drawer.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Drawer(
      backgroundColor: scheme.surface,
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top,
                        left: 18,
                        right: 18,
                        bottom: 18,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [scheme.primary, scheme.secondary],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.balance,
                            color: Colors.white,
                            size: 30,
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            child: Text(
                              l10n.appTitle,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    const _ZakatDrawerTile(),
                    const SizedBox(height: 10),
                    const _ThemeDrawerTile(),
                    const SizedBox(height: 10),
                    const _LanguageDrawerTile(),
                    const SizedBox(height: 10),
                    const _CurrencyDrawerTile(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            const _VersionDrawerFooter(),
          ],
        ),
      ),
    );
  }
}

class _ZakatDrawerTile extends StatelessWidget {
  const _ZakatDrawerTile();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        color: scheme.surfaceContainerHighest,
        child: ListTile(
          leading: Icon(
            Icons.volunteer_activism_outlined,
            color: scheme.primary,
          ),
          title: Text(l10n.zakatMenuLabel),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const ZakatScreen()),
            );
          },
        ),
      ),
    );
  }
}

class _ThemeDrawerTile extends ConsumerWidget {
  const _ThemeDrawerTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final ThemeMode themeMode = ref.watch(themeModeProvider);
    final bool darkModeEnabled =
        themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            Theme.of(context).brightness == Brightness.dark);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        color: scheme.surfaceContainerHighest,
        child: SwitchListTile.adaptive(
          secondary: Icon(
            darkModeEnabled ? Icons.dark_mode : Icons.light_mode,
            color: scheme.primary,
          ),
          title: Text(l10n.darkModeLabel),
          value: darkModeEnabled,
          onChanged: (enabled) {
            ref
                .read(themeModeProvider.notifier)
                .setThemeMode(enabled ? ThemeMode.dark : ThemeMode.light);
          },
          activeThumbColor: scheme.primary,
          activeTrackColor: scheme.primaryContainer,
        ),
      ),
    );
  }
}

class _LanguageDrawerTile extends ConsumerWidget {
  const _LanguageDrawerTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Locale locale = ref.watch(localeProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        color: scheme.surfaceContainerHighest,
        child: ListTile(
          leading: Icon(Icons.translate, color: scheme.primary),
          title: Text(l10n.settingsLanguageLabel),
          subtitle: Text(Languages.nativeLabelFor(locale)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            showModalBottomSheet(
              context: context,
              useSafeArea: false,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const LanguageBottomSheet(),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CurrencyDrawerTile extends ConsumerWidget {
  const _CurrencyDrawerTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final currency = ref.watch(currencyProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        color: scheme.surfaceContainerHighest,
        child: ListTile(
          leading: Icon(Icons.currency_exchange, color: scheme.primary),
          title: Text(l10n.settingsCurrencyLabel),
          subtitle: Text(currency.displayLabel),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            showModalBottomSheet(
              context: context,
              useSafeArea: false,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const CurrencyBottomSheet(),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _VersionDrawerFooter extends ConsumerWidget {
  const _VersionDrawerFooter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final versionAsync = ref.watch(appVersionProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      child: versionAsync.when(
        data: (version) => Text(
          '${l10n.aboutVersion} $version',
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
        loading: () => Text(
          '${l10n.aboutVersion} ...',
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
        error: (_, _) => Text(
          '${l10n.aboutVersion} ${l10n.unknownLabel}',
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ),
    );
  }
}
