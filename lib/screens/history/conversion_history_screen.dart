import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/conversion_history_item.dart';
import '../../providers/history_provider.dart';
import '../../services/analytics_service.dart';
import '../../widgets/app_banner_ad.dart';
import '../../widgets/gold_ornament_painter.dart';
import 'widgets/conversion_history_card.dart';

class ConversionHistoryScreen extends ConsumerWidget {
  const ConversionHistoryScreen({super.key});

  Future<void> _confirmClearAll(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.historyClearConfirmTitle),
        content: Text(l10n.historyClearConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: Text(l10n.historyClearTooltip),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(conversionHistoryProvider.notifier).clearAll();
    }
  }

  void _restoreItem(
    BuildContext context,
    WidgetRef ref,
    ConversionHistoryItem item,
  ) {
    ref.read(pendingRestoreProvider.notifier).requestRestore(item);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final List<ConversionHistoryItem> history = ref.watch(
      conversionHistoryProvider,
    );
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final bool isDark = theme.brightness == Brightness.dark;

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          ScaffoldMessenger.of(context).clearSnackBars();
        }
      },
      child: ScaffoldMessenger(
        child: Builder(
          builder: (scaffoldContext) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  l10n.historyTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    letterSpacing: 0.2,
                  ),
                ),
                centerTitle: true,
                foregroundColor: Colors.white,
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryDark,
                        AppColors.primary,
                        AppColors.secondary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                actions: [
                  if (history.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.delete_sweep_outlined),
                      tooltip: l10n.historyClearTooltip,
                      onPressed: () => _confirmClearAll(context, ref),
                    ),
                ],
              ),
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? const [
                            Color(0xFF171310),
                            Color(0xFF211A14),
                            Color(0xFF2A2118),
                          ]
                        : const [
                            AppColors.background,
                            AppColors.backgroundMid,
                            AppColors.backgroundFade,
                          ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: IgnorePointer(
                        child: CustomPaint(
                          painter: GoldOrnamentPainter(isDark: isDark),
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Column(
                        children: [
                          Expanded(
                            child: history.isEmpty
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 32,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.history_rounded,
                                            size: 72,
                                            color: scheme.onSurfaceVariant
                                                .withValues(alpha: 0.4),
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            l10n.historyEmptyTitle,
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: scheme.onSurface,
                                                ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            l10n.historyEmptySubtitle,
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                                  color:
                                                      scheme.onSurfaceVariant,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    itemCount: history.length,
                                    itemBuilder: (context, index) {
                                      final item = history[index];
                                      return Dismissible(
                                        key: ValueKey(item.id),
                                        direction: DismissDirection.endToStart,
                                        background: Container(
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.only(
                                            right: 24,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: scheme.errorContainer,
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.delete_outline,
                                            color: scheme.onErrorContainer,
                                          ),
                                        ),
                                        onDismissed: (_) {
                                          final historyNotifier = ref.read(
                                            conversionHistoryProvider.notifier,
                                          );
                                          historyNotifier.deleteEntry(item.id);
                                          AnalyticsService.trackHistoryItemDeleted(
                                            totalGrams: item.totalGrams,
                                            totalTola: item.totalTola,
                                            hasGoldRate:
                                                item.goldRate != null &&
                                                item.goldRate! > 0,
                                            totalPrice: item.priceFormatted,
                                          );
                                          final messenger =
                                              ScaffoldMessenger.of(
                                                scaffoldContext,
                                              );
                                          messenger.clearSnackBars();
                                          messenger.showSnackBar(
                                            SnackBar(
                                              duration: const Duration(
                                                seconds: 4,
                                              ),
                                              persist: false,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              content: Text(
                                                l10n.historyItemDeleted,
                                              ),
                                              action: SnackBarAction(
                                                label: l10n.historyUndo,
                                                onPressed: () {
                                                  historyNotifier.addEntry(
                                                    item,
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        child: ConversionHistoryCard(
                                          item: item,
                                          onRestore: () =>
                                              _restoreItem(context, ref, item),
                                          onDelete: () {
                                            ref
                                                .read(
                                                  conversionHistoryProvider
                                                      .notifier,
                                                )
                                                .deleteEntry(item.id);
                                            AnalyticsService.trackHistoryItemDeleted(
                                              totalGrams: item.totalGrams,
                                              totalTola: item.totalTola,
                                              hasGoldRate:
                                                  item.goldRate != null &&
                                                  item.goldRate! > 0,
                                              totalPrice: item.priceFormatted,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          const AppBannerAd(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
