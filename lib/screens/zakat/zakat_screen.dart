import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../constants/ad_config.dart';
import '../../constants/app_colors.dart';
import '../../constants/purity_enum.dart';
import '../../constants/unit_enum.dart';
import '../../constants/weight_unit_enum.dart';
import '../../l10n/app_localizations.dart';
import '../../models/gold_item_model.dart';
import '../../providers/currency_provider.dart';
import '../../providers/zakat_provider.dart';
import '../../services/analytics_service.dart';
import '../../services/zakat_calculator.dart';
import '../../widgets/app_banner_ad.dart';
import '../../widgets/gold_item_sheet.dart';
import '../../widgets/zakat_delete_dialog.dart';
import 'widgets/zakat_disclaimer_banner.dart';
import 'widgets/zakat_item_tile.dart';
import 'widgets/zakat_rate_card.dart';
import 'widgets/zakat_summary_card.dart';

class ZakatScreen extends ConsumerStatefulWidget {
  const ZakatScreen({super.key});

  @override
  ConsumerState<ZakatScreen> createState() => _ZakatScreenState();
}

class _ZakatScreenState extends ConsumerState<ZakatScreen> {
  late final TextEditingController _rateController;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _summaryKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _rateController = TextEditingController(
      text: ref.read(zakatNotifierProvider).rateText,
    );
    _rateController.addListener(_onRateChanged);
  }

  @override
  void dispose() {
    _rateController.removeListener(_onRateChanged);
    _rateController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _openItemSheet({GoldItemModel? existing}) async {
    await showModalBottomSheet<void>(
      context: context,
      useSafeArea: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => GoldItemSheet(existing: existing),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    );
  }

  void _onRateChanged() {
    ref.read(zakatNotifierProvider.notifier).setRateText(_rateController.text);
  }

  void _scrollToSummary() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _calculateZakat() {
    FocusManager.instance.primaryFocus?.unfocus();
    final ZakatState state = ref.read(zakatNotifierProvider);
    if (state.items.isEmpty) return;

    final List<String> puritiesUsed = state.items
        .map(
          (item) => switch (item.purity) {
            PurityEnum.karat24 => '24k',
            PurityEnum.karat22 => '22k',
            PurityEnum.karat21 => '21k',
            PurityEnum.karat18 => '18k',
            PurityEnum.custom => 'custom',
          },
        )
        .toSet()
        .toList();

    final List<String> weightUnitsUsed = state.items
        .map((item) => item.unit.name)
        .toSet()
        .toList();

    final bool hasCustomKarat = state.items.any(
      (item) => item.purity == PurityEnum.custom,
    );

    AnalyticsService.trackZakatCalculated(
      itemCount: state.items.length,
      rateUnit: switch (state.rateUnit) {
        UnitEnum.tola => 'tola',
        UnitEnum.tenGram => 'ten_gram',
        UnitEnum.oneGram => 'one_gram',
        UnitEnum.ounce => 'ounce',
      },
      hasGoldRate: state.rateValue > 0,
      totalGrams: double.parse(
        state.summary.totalGrossGrams.toStringAsFixed(4),
      ),
      totalPureGrams: double.parse(
        state.summary.totalPureGrams.toStringAsFixed(4),
      ),
      puritiesUsed: puritiesUsed,
      weightUnitsUsed: weightUnitsUsed,
      hasCustomKarat: hasCustomKarat,
    );
    _scrollToSummary();
  }

  Future<bool> _confirmDelete(GoldItemModel item) async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final String name = item.displayName ?? l10n.zakatUntitledItem;
    return confirmZakatItemDeletion(context, itemName: name);
  }

  String _purityLabel(AppLocalizations l10n, GoldItemModel item) {
    return switch (item.purity) {
      PurityEnum.karat24 => l10n.zakatPurity24k,
      PurityEnum.karat22 => l10n.zakatPurity22k,
      PurityEnum.karat21 => l10n.zakatPurity21k,
      PurityEnum.karat18 => l10n.zakatPurity18k,
      PurityEnum.custom => '${item.effectiveKarat}K',
    };
  }

  String _weightUnitLabel(AppLocalizations l10n, WeightUnitEnum unit) {
    return switch (unit) {
      WeightUnitEnum.tola => l10n.tolaLabel,
      WeightUnitEnum.lal => l10n.lalLabel,
      WeightUnitEnum.masha => l10n.mashaLabel,
      WeightUnitEnum.ana => l10n.anaLabel,
      WeightUnitEnum.ratti => l10n.rattiLabel,
      WeightUnitEnum.gram => l10n.gramLabel,
      WeightUnitEnum.ounce => l10n.ounceLabel,
    };
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final ZakatState zakatState = ref.watch(zakatNotifierProvider);
    final ZakatSummary summary = zakatState.summary;
    final currency = ref.watch(currencyProvider);
    final bool hasRateFraction =
        (zakatState.rateValue - zakatState.rateValue.truncateToDouble()).abs() >
        0.000001;
    final int decimalDigits = hasRateFraction ? 2 : 0;
    final NumberFormat currencyFormat = currency.numberFormatWithDigits(
      decimalDigits,
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text(
          l10n.zakatScreenTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: 0.2,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        elevation: 0,
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
        child: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                children: [
                  ZakatDisclaimerBanner(text: l10n.zakatDisclaimer),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.zakatItemsTitle,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: scheme.onSurface,
                              ),
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: () => _openItemSheet(),
                        icon: const Icon(Icons.add, size: 18),
                        label: Text(l10n.zakatAddItem),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (zakatState.items.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: isDark
                            ? scheme.surfaceContainerHighest
                            : AppColors.paper,
                      ),
                      child: Text(
                        l10n.zakatEmptyItems,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  else
                    ...zakatState.items.map(
                      (item) => ZakatItemTile(
                        item: item,
                        purityLabel: _purityLabel(l10n, item),
                        weightUnitLabel: _weightUnitLabel(l10n, item.unit),
                        onConfirmDelete: () => _confirmDelete(item),
                        onDismissed: () {
                          ref
                              .read(zakatNotifierProvider.notifier)
                              .removeItem(item.id);
                        },
                        onTap: () => _openItemSheet(existing: item),
                        onEdit: () => _openItemSheet(existing: item),
                      ),
                    ),
                  const SizedBox(height: 18),
                  ZakatRateCard(
                    controller: _rateController,
                    rateUnit: zakatState.rateUnit,
                    onUnitChanged: (value) {
                      if (value == null) return;
                      ref
                          .read(zakatNotifierProvider.notifier)
                          .setRateUnit(UnitEnum.fromString(value));
                    },
                  ),
                  if (zakatState.items.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        onPressed: _calculateZakat,
                        child: Text(l10n.zakatCalculateButton),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  KeyedSubtree(
                    key: _summaryKey,
                    child: ZakatSummaryCard(
                      l10n: l10n,
                      summary: summary,
                      currencyFormat: currencyFormat,
                      hasRateFraction: hasRateFraction,
                    ),
                  ),
                  const AppBannerAd(
                    placement: BannerPlacement.zakat,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
