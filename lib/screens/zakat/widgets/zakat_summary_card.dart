import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../services/zakat_calculator.dart';
import '../../../services/weight_converter.dart';
import '../../../widgets/result_actions.dart';

class ZakatSummaryCard extends StatelessWidget {
  final AppLocalizations l10n;
  final ZakatSummary summary;
  final NumberFormat currencyFormat;
  final bool hasRateFraction;

  const ZakatSummaryCard({
    super.key,
    required this.l10n,
    required this.summary,
    required this.currencyFormat,
    this.hasRateFraction = false,
  });

  String _zakatSummaryShareText({
    required AppLocalizations l10n,
    required ZakatSummary summary,
    required NumberFormat currencyFormat,
    required double? displayTotalValue,
    required double? displayZakatDue,
  }) {
    final StringBuffer buffer = StringBuffer()
      ..writeln(l10n.zakatSummaryTitle)
      ..writeln(l10n.zakatTotalPureGold)
      ..writeln(
        l10n.zakatPureGoldValue(
          summary.totalPureGrams.toStringAsFixed(4),
          summary.totalPureTola.toStringAsFixed(4),
        ),
      );
    if (displayTotalValue != null) {
      buffer
        ..writeln(l10n.zakatTotalValue)
        ..writeln(currencyFormat.format(displayTotalValue));
    } else {
      buffer.writeln(l10n.zakatEnterRatePrompt);
    }
    if (displayZakatDue != null) {
      buffer
        ..writeln(l10n.zakatDueLabel)
        ..writeln(currencyFormat.format(displayZakatDue));
    }
    return buffer.toString().trim();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool hasItems =
        summary.totalPureGrams > 0 || summary.totalGrossGrams > 0;

    final double? displayTotalValue = summary.totalValue == null
        ? null
        : (hasRateFraction
              ? summary.totalValue
              : summary.totalValue!.roundToDouble());

    final double? displayZakatDue = summary.zakatDue == null
        ? null
        : (hasRateFraction
              ? summary.zakatDue
              : summary.zakatDue!.ceilToDouble());

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
              : AppColors.cardBorder.withValues(alpha: 0.8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.zakatSummaryTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
              ),
              if (hasItems)
                ResultActions(
                  text: _zakatSummaryShareText(
                    l10n: l10n,
                    summary: summary,
                    currencyFormat: currencyFormat,
                    displayTotalValue: displayTotalValue,
                    displayZakatDue: displayZakatDue,
                  ),
                  screen: 'zakat',
                  totalGrams: double.parse(
                    summary.totalGrossGrams.toStringAsFixed(4),
                  ),
                  totalTola: double.parse(
                    WeightConverter.gramsToTola(
                      summary.totalGrossGrams,
                    ).toStringAsFixed(4),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          if (!hasItems)
            Text(
              l10n.zakatEmptyItems,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            )
          else ...[
            Text(
              l10n.zakatTotalPureGold,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.zakatPureGoldValue(
                summary.totalPureGrams.toStringAsFixed(4),
                summary.totalPureTola.toStringAsFixed(4),
              ),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              l10n.zakatTotalValue,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 4),
            if (displayTotalValue != null)
              Text(
                currencyFormat.format(displayTotalValue),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              )
            else
              Text(
                l10n.zakatEnterRatePrompt,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            const SizedBox(height: 14),
            Text(
              l10n.zakatDueLabel,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 4),
            if (displayZakatDue != null)
              Text(
                currencyFormat.format(displayZakatDue),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: isDark ? scheme.primary : AppColors.primaryDark,
                ),
              )
            else
              Text(
                l10n.zakatEnterRatePrompt,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
          ],
        ],
      ),
    );
  }
}
