import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/unit_enum.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/gold_text_field.dart';

class ZakatRateCard extends StatelessWidget {
  final TextEditingController controller;
  final UnitEnum rateUnit;
  final ValueChanged<String?> onUnitChanged;

  const ZakatRateCard({
    super.key,
    required this.controller,
    required this.rateUnit,
    required this.onUnitChanged,
  });

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

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
        controller: controller,
        semanticLabel: l10n.goldRateSemanticLabel,
        hintText: l10n.goldRateHint,
        hasDropdown: true,
        dropdownValue: rateUnit.name,
        dropdownItems: UnitEnum.values.map((unit) => unit.name).toList(),
        onDropdownChanged: onUnitChanged,
      ),
    );
  }
}
