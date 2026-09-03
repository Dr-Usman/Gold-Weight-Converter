import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gold_weight_converter/constants/app_colors.dart';
import 'package:gold_weight_converter/constants/purity_enum.dart';
import 'package:gold_weight_converter/constants/weight_unit_enum.dart';
import 'package:gold_weight_converter/l10n/app_localizations.dart';
import 'package:gold_weight_converter/models/gold_item_model.dart';
import 'package:gold_weight_converter/providers/zakat_provider.dart';
import 'package:gold_weight_converter/utils/number_formatter.dart';
import 'package:gold_weight_converter/utils/number_helper.dart';
import 'package:gold_weight_converter/widgets/zakat_delete_dialog.dart';

/// Bottom sheet to add or edit a gold item for zakat.
class GoldItemSheet extends ConsumerStatefulWidget {
  final GoldItemModel? existing;

  const GoldItemSheet({super.key, this.existing});

  @override
  ConsumerState<GoldItemSheet> createState() => _GoldItemSheetState();
}

class _GoldItemSheetState extends ConsumerState<GoldItemSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _weightController;
  late final TextEditingController _karatController;
  late WeightUnitEnum _unit;
  late PurityEnum _purity;
  String? _weightError;
  String? _karatError;

  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final GoldItemModel? existing = widget.existing;
    _nameController = TextEditingController(text: existing?.name ?? '');
    _weightController = TextEditingController(
      text: existing == null ? '' : NumberHelper.formatNumber(existing.weight),
    );
    _karatController = TextEditingController(
      text: existing?.customKarat?.toString() ?? '',
    );
    _unit = existing?.unit ?? WeightUnitEnum.gram;
    _purity = existing?.purity ?? PurityEnum.karat22;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    _karatController.dispose();
    super.dispose();
  }

  bool _validate() {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final double? weight = NumberHelper.parseFormattedNumber(
      _weightController.text,
    );
    String? weightError;
    String? karatError;

    if (weight == null || weight <= 0) {
      weightError = l10n.zakatValidationWeight;
    }

    int? customKarat;
    if (_purity == PurityEnum.custom) {
      customKarat = int.tryParse(_karatController.text.trim());
      if (customKarat == null || customKarat < 1 || customKarat > 24) {
        karatError = l10n.zakatValidationKarat;
      }
    }

    setState(() {
      _weightError = weightError;
      _karatError = karatError;
    });

    return weightError == null && karatError == null;
  }

  Future<void> _save() async {
    if (!_validate()) return;

    final double weight = NumberHelper.parseFormattedNumber(
      _weightController.text,
    )!;
    final String? name = _nameController.text.trim().isEmpty
        ? null
        : _nameController.text.trim();
    final int? customKarat = _purity == PurityEnum.custom
        ? int.parse(_karatController.text.trim())
        : null;

    final GoldItemModel item = GoldItemModel(
      id:
          widget.existing?.id ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      weight: weight,
      unit: _unit,
      purity: _purity,
      customKarat: customKarat,
    );

    final notifier = ref.read(zakatNotifierProvider.notifier);
    if (_isEditing) {
      await notifier.updateItem(item);
    } else {
      await notifier.addItem(item);
    }

    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    final GoldItemModel? existing = widget.existing;
    if (existing == null) return;

    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final String name = existing.displayName ?? l10n.zakatUntitledItem;
    final bool confirmed = await confirmZakatItemDeletion(
      context,
      itemName: name,
    );
    if (!confirmed || !mounted) return;

    await ref.read(zakatNotifierProvider.notifier).removeItem(existing.id);
    if (mounted) Navigator.of(context).pop();
  }

  String _purityLabel(AppLocalizations l10n, PurityEnum purity) {
    return switch (purity) {
      PurityEnum.karat24 => l10n.zakatPurity24k,
      PurityEnum.karat22 => l10n.zakatPurity22k,
      PurityEnum.karat21 => l10n.zakatPurity21k,
      PurityEnum.karat18 => l10n.zakatPurity18k,
      PurityEnum.custom => l10n.zakatPurityCustom,
    };
  }

  String _unitLabel(AppLocalizations l10n, WeightUnitEnum unit) {
    return switch (unit) {
      WeightUnitEnum.tola => l10n.tolaLabel,
      WeightUnitEnum.lal => l10n.lalLabel,
      WeightUnitEnum.masha => l10n.mashaLabel,
      WeightUnitEnum.ana => l10n.anaLabel,
      WeightUnitEnum.ratti => l10n.rattiLabel,
      WeightUnitEnum.gram => l10n.gramLabel,
    };
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? scheme.surface : AppColors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: scheme.outlineVariant,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _isEditing ? l10n.zakatEditItem : l10n.zakatAddItem,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: l10n.zakatItemNameLabel,
                    hintText: l10n.zakatItemNameHint,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: _weightController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [ThousandsSeparatorInputFormatter()],
                        decoration: InputDecoration(
                          labelText: l10n.zakatWeightLabel,
                          hintText: l10n.zakatWeightHint,
                          errorText: _weightError,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<WeightUnitEnum>(
                        key: ValueKey(_unit),
                        initialValue: _unit,
                        decoration: InputDecoration(
                          labelText: l10n.zakatWeightUnitLabel,
                        ),
                        items: WeightUnitEnum.values
                            .map(
                              (unit) => DropdownMenuItem(
                                value: unit,
                                child: Text(_unitLabel(l10n, unit)),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() => _unit = value);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<PurityEnum>(
                  key: ValueKey(_purity),
                  initialValue: _purity,
                  decoration: InputDecoration(labelText: l10n.zakatPurityLabel),
                  items: PurityEnum.values
                      .map(
                        (purity) => DropdownMenuItem(
                          value: purity,
                          child: Text(_purityLabel(l10n, purity)),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _purity = value);
                  },
                ),
                if (_purity == PurityEnum.custom) ...[
                  const SizedBox(height: 14),
                  TextField(
                    controller: _karatController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: l10n.zakatCustomKaratLabel,
                      hintText: l10n.zakatCustomKaratHint,
                      errorText: _karatError,
                    ),
                  ),
                ],
                const SizedBox(height: 22),
                Row(
                  children: [
                    if (_isEditing)
                      TextButton(
                        onPressed: _delete,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: Text(l10n.zakatDeleteItem),
                      ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(l10n.zakatCancel),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: _save,
                      child: Text(l10n.zakatSaveItem),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
