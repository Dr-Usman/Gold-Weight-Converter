import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/languages.dart';
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
    final double maxHeight = MediaQuery.sizeOf(context).height * 0.80;

    return Material(
      color: scheme.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
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
                const SizedBox(height: 12),
                Text(
                  l10n.languageSelectionPrompt,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isDark ? Colors.white : scheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: Languages.supported.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 3.0,
                        ),
                    itemBuilder: (context, index) {
                      final AppLanguage language = Languages.supported[index];
                      final bool isSelected = language.matches(currentLocale);

                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () async {
                          await ref
                              .read(localeProvider.notifier)
                              .setLocale(language.locale);
                          await Future.delayed(
                            const Duration(milliseconds: 150),
                          );
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? scheme.primary.withValues(alpha: 0.12)
                                : (isDark
                                      ? scheme.surfaceContainerHighest
                                            .withValues(alpha: 0.4)
                                      : scheme.surface),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? scheme.primary
                                  : scheme.outlineVariant.withValues(
                                      alpha: 0.6,
                                    ),
                              width: isSelected ? 1.5 : 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    text: language.nativeLabel,
                                    style: TextStyle(
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w600,
                                      fontSize: 13.5,
                                      color: isDark
                                          ? Colors.white
                                          : scheme.onSurface,
                                    ),
                                    children:
                                        language.englishName !=
                                            language.nativeLabel
                                        ? [
                                            TextSpan(
                                              text:
                                                  '  (${language.englishName})',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: isDark
                                                    ? Colors.white70
                                                    : scheme.onSurfaceVariant,
                                              ),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (isSelected) ...[
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.check_circle,
                                  size: 18,
                                  color: scheme.primary,
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
