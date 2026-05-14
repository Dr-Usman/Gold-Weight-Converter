import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../providers/locale_provider.dart';

class LanguageBottomSheet extends ConsumerWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeProvider);
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double screenWidth = MediaQuery.sizeOf(context).width;

    final List<({String code, String nativeLabel})> languages = [
      (code: 'en', nativeLabel: 'English'),
      (code: 'rmu', nativeLabel: 'Roman Urdu'),
      (code: 'ur', nativeLabel: 'اردو'),
      (code: 'hi', nativeLabel: 'हिंदी'),
      (code: 'bn', nativeLabel: 'বাংলা'),
      (code: 'sd', nativeLabel: 'سنڌي'),
      (code: 'ar', nativeLabel: 'العربية'),
      (code: 'fa', nativeLabel: 'فارسی'),
      (code: 'ps', nativeLabel: 'پښتو'),
      (code: 'ms', nativeLabel: 'Melayu'),
      (code: 'id', nativeLabel: 'Indonesia'),
      (code: 'tr', nativeLabel: 'Türkçe'),
    ];

    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        // constraints: BoxConstraints(maxHeight: maxSheetHeight),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // const SizedBox(height: 6),
            Center(
              child: Container(
                width: screenWidth * 0.15,
                height: 4,
                decoration: BoxDecoration(
                  color: scheme.outlineVariant,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.languageSelectionPrompt,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isDark ? Colors.white : scheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6.0, // Space between chips
              runSpacing: 0.0, // Space between lines
              alignment: WrapAlignment.start,
              children: languages.map((language) {
                final bool isSelected =
                    currentLocale.languageCode == language.code;

                return ChoiceChip(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 8,
                  ),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 2),
                  label: SizedBox(
                    width: screenWidth * 0.25,
                    child: Center(
                      child: FittedBox(child: Text(language.nativeLabel)),
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: scheme.primary,
                  backgroundColor: isDark
                      ? scheme.surfaceContainerHighest
                      : scheme.surface,
                  showCheckmark: false,
                  side: BorderSide(color: scheme.outlineVariant),
                  labelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: isSelected
                        ? scheme.onPrimary
                        : (isDark ? Colors.white : scheme.onSurface),
                    fontWeight: FontWeight.w700,
                  ),
                  onSelected: (_) async {
                    await ref
                        .read(localeProvider.notifier)
                        .setLocale(language.code);
                    await Future.delayed(const Duration(milliseconds: 200));
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
