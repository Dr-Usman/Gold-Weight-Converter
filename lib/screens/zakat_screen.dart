import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gold_weight_converter/constants/app_colors.dart';
import 'package:gold_weight_converter/constants/purity_enum.dart';
import 'package:gold_weight_converter/constants/unit_enum.dart';
import 'package:gold_weight_converter/constants/weight_unit_enum.dart';
import 'package:gold_weight_converter/l10n/app_localizations.dart';
import 'package:gold_weight_converter/models/gold_item_model.dart';
import 'package:gold_weight_converter/providers/zakat_provider.dart';
import 'package:gold_weight_converter/services/analytics_service.dart';
import 'package:gold_weight_converter/services/zakat_calculator.dart';
import 'package:gold_weight_converter/utils/number_helper.dart';
import 'package:gold_weight_converter/widgets/gold_item_sheet.dart';
import 'package:gold_weight_converter/widgets/gold_text_field.dart';
import 'package:gold_weight_converter/widgets/zakat_delete_dialog.dart';
import 'package:intl/intl.dart';

class ZakatScreen extends ConsumerStatefulWidget {
  const ZakatScreen({super.key});

  @override
  ConsumerState<ZakatScreen> createState() => _ZakatScreenState();
}

class _ZakatScreenState extends ConsumerState<ZakatScreen> {
  late final TextEditingController _rateController;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _summaryKey = GlobalKey();
  final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'en_PK',
    symbol: 'Rs. ',
    decimalDigits: 2,
  );

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
      useSafeArea: true,
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
      final BuildContext? summaryContext = _summaryKey.currentContext;
      if (summaryContext != null) {
        Scrollable.ensureVisible(
          summaryContext,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.1,
        );
        return;
      }
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
    FocusScope.of(context).unfocus();
    final ZakatState state = ref.read(zakatNotifierProvider);
    if (state.items.isEmpty) return;

    AnalyticsService.trackZakatCalculated(
      itemCount: state.items.length,
      rateUnit: switch (state.rateUnit) {
        UnitEnum.tola => 'tola',
        UnitEnum.tenGram => 'ten_gram',
        UnitEnum.oneGram => 'one_gram',
      },
      hasGoldRate: state.rateValue > 0,
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
      WeightUnitEnum.masha => l10n.mashaLabel,
      WeightUnitEnum.ana => l10n.anaLabel,
      WeightUnitEnum.ratti => l10n.rattiLabel,
      WeightUnitEnum.gram => l10n.gramLabel,
    };
  }

  Widget _buildRateCard({
    required AppLocalizations l10n,
    required ColorScheme scheme,
    required bool isDark,
    required ZakatState zakatState,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: isDark
            ? scheme.surfaceContainer.withValues(alpha: 0.92)
            : AppColors.surface.withValues(alpha: 0.96),
        border: Border.all(
          color: isDark
              ? scheme.outlineVariant
              : AppColors.cardBorder.withValues(alpha: 0.7),
        ),
      ),
      child: GoldTextField(
        label: l10n.goldRateLabel,
        info: l10n.zakatRateInfo,
        controller: _rateController,
        semanticLabel: l10n.goldRateSemanticLabel,
        hintText: l10n.goldRateHint,
        hasDropdown: true,
        dropdownValue: zakatState.rateUnit.name,
        dropdownItems: UnitEnum.values.map((unit) => unit.name).toList(),
        onDropdownChanged: (value) {
          if (value == null) return;
          ref
              .read(zakatNotifierProvider.notifier)
              .setRateUnit(UnitEnum.fromString(value));
        },
      ),
    );
  }

  Widget _buildItemTile({
    required AppLocalizations l10n,
    required ColorScheme scheme,
    required bool isDark,
    required GoldItemModel item,
  }) {
    final String title = item.displayName ?? l10n.zakatUntitledItem;
    final String weightText = NumberHelper.formatNumber(item.weight);

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => _confirmDelete(item),
      onDismissed: (_) {
        ref.read(zakatNotifierProvider.notifier).removeItem(item.id);
      },
      background: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade700,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        color: isDark ? scheme.surfaceContainerHighest : AppColors.surface,
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            l10n.zakatItemDetail(
              weightText,
              _weightUnitLabel(l10n, item.unit),
              _purityLabel(l10n, item),
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => _openItemSheet(existing: item),
          ),
          onTap: () => _openItemSheet(existing: item),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final ZakatState zakatState = ref.watch(zakatNotifierProvider);
    final ZakatSummary summary = zakatState.summary;

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
                  _DisclaimerBanner(text: l10n.zakatDisclaimer),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.zakatItemsTitle,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
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
                      (item) => _buildItemTile(
                        l10n: l10n,
                        scheme: scheme,
                        isDark: isDark,
                        item: item,
                      ),
                    ),
                  const SizedBox(height: 18),
                  _buildRateCard(
                    l10n: l10n,
                    scheme: scheme,
                    isDark: isDark,
                    zakatState: zakatState,
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
                    child: _SummaryCard(
                      l10n: l10n,
                      summary: summary,
                      currencyFormat: _currencyFormat,
                    ),
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

class _DisclaimerBanner extends StatelessWidget {
  final String text;

  const _DisclaimerBanner({required this.text});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: scheme.secondaryContainer.withValues(alpha: 0.55),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: scheme.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                height: 1.35,
                color: scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final AppLocalizations l10n;
  final ZakatSummary summary;
  final NumberFormat currencyFormat;

  const _SummaryCard({
    required this.l10n,
    required this.summary,
    required this.currencyFormat,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool hasItems =
        summary.totalPureGrams > 0 || summary.totalGrossGrams > 0;

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
          Text(
            l10n.zakatSummaryTitle,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
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
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 4),
            Text(
              l10n.zakatPureGoldValue(
                summary.totalPureGrams.toStringAsFixed(4),
                summary.totalPureTola.toStringAsFixed(4),
              ),
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 14),
            Text(
              l10n.zakatTotalValue,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 4),
            if (summary.totalValue != null)
              Text(
                currencyFormat.format(summary.totalValue),
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
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
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 4),
            if (summary.zakatDue != null)
              Text(
                currencyFormat.format(summary.zakatDue),
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
