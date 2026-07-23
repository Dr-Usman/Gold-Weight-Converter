import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';
import '../providers/version_provider.dart';
import '../screens/zakat_screen.dart';
import 'language_bottom_sheet.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeModeProvider);
    final versionAsync = ref.watch(appVersionProvider);
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool darkModeEnabled =
        themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            Theme.of(context).brightness == Brightness.dark);

    return Drawer(
      backgroundColor: scheme.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 30,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.settingsTitle,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Gold Zakat
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Card(
                        color: scheme.surfaceContainerHighest,
                        child: ListTile(
                          leading: Icon(
                            Icons.volunteer_activism_outlined,
                            color: scheme.primary,
                          ),
                          title: Text(l10n.zakatMenuLabel),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const ZakatScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Theme Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Card(
                        color: scheme.surfaceContainerHighest,
                        child: SwitchListTile.adaptive(
                          secondary: Icon(
                            darkModeEnabled
                                ? Icons.dark_mode
                                : Icons.light_mode,
                            color: scheme.primary,
                          ),
                          title: Text(l10n.darkModeLabel),
                          value: darkModeEnabled,
                          onChanged: (enabled) {
                            ref
                                .read(themeModeProvider.notifier)
                                .setThemeMode(
                                  enabled ? ThemeMode.dark : ThemeMode.light,
                                );
                          },
                          activeThumbColor: scheme.primary,
                          activeTrackColor: scheme.primaryContainer,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Language Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Card(
                        color: scheme.surfaceContainerHighest,
                        child: ListTile(
                          leading: Icon(Icons.language, color: scheme.primary),
                          title: Text(l10n.settingsLanguageLabel),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              useSafeArea: true,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => const LanguageBottomSheet(),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
              child: versionAsync.when(
                data: (version) => Text(
                  '${l10n.aboutVersion} $version',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                loading: () => Text(
                  '${l10n.aboutVersion} ...',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                error: (_, _) => Text(
                  '${l10n.aboutVersion} ${l10n.unknownLabel}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
