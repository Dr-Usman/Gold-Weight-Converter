import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/gold_item_model.dart';
import '../../../utils/number_helper.dart';

class ZakatItemTile extends StatelessWidget {
  final GoldItemModel item;
  final String purityLabel;
  final String weightUnitLabel;
  final Future<bool?> Function() onConfirmDelete;
  final VoidCallback onDismissed;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  const ZakatItemTile({
    super.key,
    required this.item,
    required this.purityLabel,
    required this.weightUnitLabel,
    required this.onConfirmDelete,
    required this.onDismissed,
    required this.onTap,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final String title = item.displayName ?? l10n.zakatUntitledItem;
    final String weightText = NumberHelper.formatNumber(item.weight);

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => onConfirmDelete(),
      onDismissed: (_) => onDismissed(),
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
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: scheme.onSurface,
            ),
          ),
          subtitle: Text(
            l10n.zakatItemDetail(weightText, weightUnitLabel, purityLabel),
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit_outlined, color: scheme.onSurfaceVariant),
            onPressed: onEdit,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
