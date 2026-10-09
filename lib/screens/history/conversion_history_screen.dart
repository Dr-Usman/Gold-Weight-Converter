import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/ad_config.dart';
import '../../constants/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/conversion_history_item.dart';
import '../../providers/history_provider.dart';
import '../../services/ads_service.dart';
import '../../services/analytics_service.dart';
import '../../services/preferences_service.dart';
import '../../widgets/app_banner_ad.dart';
import '../../widgets/gold_ornament_painter.dart';
import 'widgets/conversion_history_card.dart';
import 'widgets/history_unlock_card.dart';

class ConversionHistoryScreen extends ConsumerStatefulWidget {
  const ConversionHistoryScreen({super.key});

  @override
  ConsumerState<ConversionHistoryScreen> createState() =>
      _ConversionHistoryScreenState();
}

class _ConversionHistoryScreenState
    extends ConsumerState<ConversionHistoryScreen> {
  bool _isLoadingAd = false;

  Future<void> _confirmClearAll(BuildContext context) async {
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

  void _restoreItem(BuildContext context, ConversionHistoryItem item) {
    ref.read(pendingRestoreProvider.notifier).requestRestore(item);
    Navigator.of(context).pop();
  }

  Future<void> _handleQuickUnlock(int historyCount) async {
    setState(() => _isLoadingAd = true);
    final bool success = await AdsService.showInterstitial();
    if (!mounted) return;
    setState(() => _isLoadingAd = false);
    if (success) {
      ref.read(sessionHistoryUnlockedProvider.notifier).unlock();
      AnalyticsService.trackHistoryTierUnlocked(
        tier: 'items_7',
        historyCount: historyCount,
      );
    }
  }

  Future<void> _handleFullUnlock(int historyCount) async {
    setState(() => _isLoadingAd = true);
    final bool earned = await AdsService.showRewarded();
    if (!mounted) return;
    setState(() => _isLoadingAd = false);
    if (earned) {
      await ref.read(adFreePassProvider.notifier).grant24HourPass();
      AnalyticsService.trackHistoryTierUnlocked(
        tier: 'rewarded_24h',
        historyCount: historyCount,
      );
    }
  }

  String _formatTimeRemaining(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${math.max(1, minutes)}m';
  }

  Widget _buildAdFreeBadge(
    BuildContext context,
    Duration remaining,
    bool isDark,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final String timeStr = _formatTimeRemaining(remaining);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.primary.withValues(alpha: 0.15)
            : const Color(0xFFFFF7E6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.workspace_premium_rounded,
            color: AppColors.primary,
            size: 18,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              l10n.historyAdFreePassActive(timeStr),
              style: TextStyle(
                color: isDark ? const Color(0xFFFFDF88) : AppColors.primaryDark,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final List<ConversionHistoryItem> history = ref.watch(
      conversionHistoryProvider,
    );
    final DateTime? adFreeUntil = ref.watch(adFreePassProvider);
    final bool isAdFree =
        adFreeUntil != null && DateTime.now().isBefore(adFreeUntil);

    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final bool isDark = theme.brightness == Brightness.dark;
    final bool unlockedSeven = ref.watch(sessionHistoryUnlockedProvider);

    // Determine visible item count based on Option C tier
    final int visibleCount;
    if (isAdFree) {
      visibleCount = history.length;
    } else if (unlockedSeven) {
      visibleCount = math.min(history.length, 7);
    } else {
      visibleCount = math.min(history.length, 1);
    }

    final bool hasMoreToUnlock = history.length > visibleCount;

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
                      onPressed: () => _confirmClearAll(context),
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
                          if (isAdFree)
                            _buildAdFreeBadge(
                              context,
                              adFreeUntil.difference(DateTime.now()),
                              isDark,
                            ),
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
                                    itemCount:
                                        visibleCount +
                                        (hasMoreToUnlock ? 1 : 0),
                                    itemBuilder: (context, index) {
                                      if (index == visibleCount) {
                                        return HistoryUnlockCard(
                                          visibleCount: visibleCount,
                                          totalCount: history.length,
                                          canQuickUnlock: !unlockedSeven,
                                          isLoading: _isLoadingAd,
                                          onQuickUnlock: () =>
                                              _handleQuickUnlock(
                                                history.length,
                                              ),
                                          onFullUnlock: () =>
                                              _handleFullUnlock(history.length),
                                        );
                                      }

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
                                              _restoreItem(context, item),
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
                          const AppBannerAd(placement: BannerPlacement.history),
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
