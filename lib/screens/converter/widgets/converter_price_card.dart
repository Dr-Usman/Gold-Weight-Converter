import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class ConverterPriceCard extends StatelessWidget {
  final String priceText;

  const ConverterPriceCard({super.key, required this.priceText});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final int newlineIndex = priceText.indexOf('\n');
    final String goldPriceLine = newlineIndex != -1
        ? priceText.substring(0, newlineIndex).trim()
        : priceText.trim();
    final String? rateInfoLine = newlineIndex != -1
        ? priceText.substring(newlineIndex + 1).trim()
        : null;

    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: isDark
              ? [
                  scheme.primaryContainer.withValues(alpha: 0.62),
                  scheme.surfaceContainerHigh,
                ]
              : [AppColors.priceCardStart, AppColors.priceCardEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: isDark
              ? scheme.outlineVariant
              : AppColors.primaryDark.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.22)
                : AppColors.primaryDark.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SelectableText(
            goldPriceLine,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: scheme.onSurface,
            ),
          ),
          if (rateInfoLine != null && rateInfoLine.isNotEmpty) ...[
            const SizedBox(height: 6),
            SelectableText(
              rateInfoLine,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: scheme.onSurface.withValues(alpha: 0.75),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
