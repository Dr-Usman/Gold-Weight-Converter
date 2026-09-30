import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/result_actions.dart';

class ConverterResultsSection extends StatelessWidget {
  final String resultText;
  final String shareableText;
  final double totalGrams;
  final double totalTola;

  const ConverterResultsSection({
    super.key,
    required this.resultText,
    required this.shareableText,
    required this.totalGrams,
    required this.totalTola,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: isDark
              ? [scheme.surfaceContainerHigh, scheme.surfaceContainer]
              : [AppColors.resultCardStart, AppColors.resultCardEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: isDark
              ? scheme.outlineVariant
              : AppColors.cardBorder.withValues(alpha: 0.9),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.18)
                : AppColors.primaryDark.withValues(alpha: 0.11),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.analytics_outlined,
                color: AppColors.primaryDark,
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.conversionDetails,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurface,
                  ),
                ),
              ),
              ResultActions(
                text: shareableText,
                screen: 'converter',
                totalGrams: totalGrams,
                totalTola: totalTola,
              ),
            ],
          ),
          const SizedBox(height: 12),
          SelectableText(
            resultText,
            style: TextStyle(
              fontSize: 14,
              color: scheme.onSurface,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
