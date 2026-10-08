import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/conversion_history_item.dart';
import '../../../widgets/result_actions.dart';

class ConversionHistoryCard extends StatelessWidget {
  final ConversionHistoryItem item;
  final VoidCallback onRestore;
  final VoidCallback? onDelete;

  const ConversionHistoryCard({
    super.key,
    required this.item,
    required this.onRestore,
    this.onDelete,
  });

  String _formatTimestamp(BuildContext context, DateTime dt) {
    final l10n = AppLocalizations.of(context)!;
    final String locale = Localizations.localeOf(context).toString();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final itemDate = DateTime(dt.year, dt.month, dt.day);
    final timeStr = DateFormat.jm(locale).format(dt);

    if (itemDate == today) {
      return l10n.historyToday(timeStr);
    } else if (itemDate == yesterday) {
      return l10n.historyYesterday(timeStr);
    } else if (now.year == dt.year) {
      return '${DateFormat.MMMEd(locale).format(dt)}, $timeStr';
    } else {
      return '${DateFormat.yMMMEd(locale).format(dt)}, $timeStr';
    }
  }

  String _formatNumber(double val) {
    if (val == val.truncateToDouble()) {
      return val.truncate().toString();
    }
    return val.toString();
  }

  String _getShareableText() {
    if (item.resultText != null && item.resultText!.isNotEmpty) {
      if (item.priceFormatted != null && item.priceFormatted!.isNotEmpty) {
        return '${item.priceFormatted}\n\n${item.resultText}';
      }
      return item.resultText!;
    }
    if (item.priceFormatted != null && item.priceFormatted!.isNotEmpty) {
      return '${item.priceFormatted}\nTotal: ${item.totalGrams} g (${item.totalTola} tola)';
    }
    return 'Total Weight: ${item.totalGrams} g (${item.totalTola} tola)';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final bool isDark = theme.brightness == Brightness.dark;

    final String timestampStr = _formatTimestamp(context, item.timestamp);
    final String shareableText = _getShareableText();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: isDark ? 2 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark
              ? scheme.outlineVariant.withValues(alpha: 0.5)
              : AppColors.cardBorder.withValues(alpha: 0.8),
          width: 1.2,
        ),
      ),
      color: isDark ? scheme.surfaceContainerHigh : scheme.surface,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        // Card tap to restore disabled: values are only filled upon clicking the Restore button
        onTap: null,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Timestamp + Action Buttons
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 15,
                    color: scheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    timestampStr,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  ResultActions(
                    text: shareableText,
                    screen: 'history',
                    totalGrams: item.totalGrams,
                    totalTola: item.totalTola,
                    totalPrice: item.priceFormatted,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Total Weight
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '${item.totalTola.toStringAsFixed(4)} ${l10n.tolaLabel}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? scheme.primary : AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(${item.totalGrams.toStringAsFixed(4)} ${l10n.unitOneGram})',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),

              // Price (if available)
              if (item.priceFormatted != null &&
                  item.priceFormatted!.isNotEmpty) ...[
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? scheme.primaryContainer.withValues(alpha: 0.3)
                        : AppColors.priceCardStart.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item.priceFormatted!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 10),

              // Input Values Chips
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: [
                  ...item.inputs.entries.where((e) => e.value > 0).map((e) {
                    final String label =
                        '${e.key[0].toUpperCase()}${e.key.substring(1)}: ${_formatNumber(e.value)}';
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        label,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }),
                ],
              ),

              const SizedBox(height: 10),

              // Restore Action Button
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.tonalIcon(
                  onPressed: onRestore,
                  style: FilledButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                  ),
                  icon: const Icon(Icons.restore, size: 16),
                  label: Text(l10n.historyRestoreButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
