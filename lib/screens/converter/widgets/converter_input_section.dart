import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/unit_enum.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/gold_text_field.dart';

class ConverterInputSection extends StatelessWidget {
  final TextEditingController tolaController;
  final TextEditingController mashaController;
  final TextEditingController anaController;
  final TextEditingController rattiController;
  final TextEditingController gramController;
  final TextEditingController lalController;
  final TextEditingController goldRateController;
  final bool isNepaliSystem;
  final Locale currentLocale;
  final UnitEnum selectedRateUnit;
  final ValueChanged<UnitEnum> onRateUnitChanged;
  final String? Function(String?) validator;
  final VoidCallback onFieldChanged;

  const ConverterInputSection({
    super.key,
    required this.tolaController,
    required this.mashaController,
    required this.anaController,
    required this.rattiController,
    required this.gramController,
    required this.lalController,
    required this.goldRateController,
    required this.isNepaliSystem,
    required this.currentLocale,
    required this.selectedRateUnit,
    required this.onRateUnitChanged,
    required this.validator,
    required this.onFieldChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: isDark
            ? scheme.surfaceContainer.withValues(alpha: 0.95)
            : Colors.white.withValues(alpha: 0.95),
        border: Border.all(
          color: isDark
              ? scheme.outlineVariant
              : AppColors.cardBorder.withValues(alpha: 0.9),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.26)
                : AppColors.primaryDark.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GoldTextField(
            label: l10n.tolaLabel,
            info: isNepaliSystem && currentLocale.languageCode == 'en'
                ? '1 Tola = 11.66 grams = 16 Aana = 100 Lal'
                : l10n.tolaInfo,
            controller: tolaController,
            semanticLabel: l10n.tolaSemanticLabel,
            validator: validator,
            onChanged: onFieldChanged,
            hintText: l10n.tolaHint,
          ),
          if (isNepaliSystem) ...[
            GoldTextField(
              label: l10n.anaLabel,
              info: currentLocale.languageCode == 'en'
                  ? '1 Aana = 0.729 grams = 6.25 Lal'
                  : l10n.anaInfo,
              controller: anaController,
              semanticLabel: l10n.anaSemanticLabel,
              validator: validator,
              onChanged: onFieldChanged,
              hintText: l10n.anaHint,
            ),
            GoldTextField(
              label: l10n.lalLabel,
              info: l10n.lalInfo,
              controller: lalController,
              semanticLabel: l10n.lalSemanticLabel,
              validator: validator,
              onChanged: onFieldChanged,
              hintText: l10n.lalHint,
            ),
          ] else ...[
            GoldTextField(
              label: l10n.mashaLabel,
              info: l10n.mashaInfo,
              controller: mashaController,
              semanticLabel: l10n.mashaSemanticLabel,
              validator: validator,
              onChanged: onFieldChanged,
              hintText: l10n.mashaHint,
            ),
            GoldTextField(
              label: l10n.anaLabel,
              info: l10n.anaInfo,
              controller: anaController,
              semanticLabel: l10n.anaSemanticLabel,
              validator: validator,
              onChanged: onFieldChanged,
              hintText: l10n.anaHint,
            ),
            GoldTextField(
              label: l10n.rattiLabel,
              info: l10n.rattiInfo,
              controller: rattiController,
              semanticLabel: l10n.rattiSemanticLabel,
              validator: validator,
              onChanged: onFieldChanged,
              hintText: l10n.rattiHint,
            ),
          ],
          GoldTextField(
            label: l10n.gramLabel,
            info: l10n.gramInfo,
            controller: gramController,
            semanticLabel: l10n.gramSemanticLabel,
            validator: validator,
            onChanged: onFieldChanged,
            hintText: l10n.gramHint,
          ),
          GoldTextField(
            label: l10n.goldRateLabel,
            info: l10n.goldRateInfo,
            controller: goldRateController,
            semanticLabel: l10n.goldRateSemanticLabel,
            validator: validator,
            onChanged: onFieldChanged,
            hintText: l10n.goldRateHint,
            hasDropdown: true,
            dropdownValue: selectedRateUnit.name,
            dropdownItems: UnitEnum.values.map<String>((e) => e.name).toList(),
            onDropdownChanged: (value) {
              if (value == null) return;
              onRateUnitChanged(UnitEnum.fromString(value));
            },
          ),
        ],
      ),
    );
  }
}
