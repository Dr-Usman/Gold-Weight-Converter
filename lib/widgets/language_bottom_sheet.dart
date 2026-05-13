import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../providers/locale_provider.dart';

class LanguageBottomSheet extends ConsumerStatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  ConsumerState<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends ConsumerState<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeProvider);
    final ColorScheme scheme = Theme.of(context).colorScheme;

    final List<({String code, String label})> languages = [
      (code: 'en', label: l10n.languageEnglish),
      (code: 'ur', label: l10n.languageUrdu),
      (code: 'ar', label: l10n.languageArabic),
      (code: 'hi', label: l10n.languageHindi),
      (code: 'tr', label: l10n.languageTurkish),
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.settingsLanguageLabel,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.languageNote,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final language in languages)
                  ChoiceChip(
                    label: Text(language.label),
                    selected: currentLocale.languageCode == language.code,
                    onSelected: (_) async {
                      await ref.read(localeProvider.notifier).setLocale(language.code);
                    },
                    avatar: currentLocale.languageCode == language.code
                        ? Icon(Icons.check, size: 16, color: scheme.onPrimary)
                        : null,
                    selectedColor: scheme.primary,
                    labelStyle: TextStyle(
                      color: currentLocale.languageCode == language.code
                          ? scheme.onPrimary
                          : scheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                    side: BorderSide(color: scheme.outlineVariant),
                    showCheckmark: false,
                  ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
