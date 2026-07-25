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

    // Audience-first: India / South Asia, then MENA, then SE Asia / other.
    final List<({Locale locale, String nativeLabel})> localeLanguages = [
      (locale: Locale('en'), nativeLabel: 'English'),
      (locale: Locale('hi'), nativeLabel: 'हिंदी'),
      (locale: Locale('bn'), nativeLabel: 'বাংলা'),
      (locale: Locale('ur'), nativeLabel: 'اردو'),
      (locale: Locale('ur', 'RO'), nativeLabel: 'Roman Urdu'),
      (locale: Locale('sd'), nativeLabel: 'سنڌي'),
      (locale: Locale('ar'), nativeLabel: 'العربية'),
      (locale: Locale('fa'), nativeLabel: 'فارسی'),
      (locale: Locale('ps'), nativeLabel: 'پښتو'),
      (locale: Locale('ms'), nativeLabel: 'Melayu'),
      (locale: Locale('id'), nativeLabel: 'Indonesia'),
      (locale: Locale('tr'), nativeLabel: 'Türkçe'),
    ];

    // Color the sheet first, then SafeArea-pad content — otherwise the home
    // indicator inset stays transparent over the modal scrim.
    return Material(
      color: scheme.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                spacing: 6.0,
                runSpacing: 0.0,
                alignment: WrapAlignment.start,
                children: localeLanguages.map((language) {
                  final bool isSelected =
                      currentLocale.languageCode ==
                          language.locale.languageCode &&
                      currentLocale.countryCode == language.locale.countryCode;

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
                    labelStyle: Theme.of(context).textTheme.titleSmall
                        ?.copyWith(
                          color: isSelected
                              ? scheme.onPrimary
                              : (isDark ? Colors.white : scheme.onSurface),
                          fontWeight: FontWeight.w700,
                        ),
                    onSelected: (_) async {
                      await ref
                          .read(localeProvider.notifier)
                          .setLocale(language.locale);
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
      ),
    );
  }
}
