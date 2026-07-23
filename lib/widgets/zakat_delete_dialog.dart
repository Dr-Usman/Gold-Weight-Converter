import 'package:flutter/material.dart';
import 'package:gold_weight_converter/l10n/app_localizations.dart';

/// Shows a confirm dialog before deleting a zakat gold item.
/// Returns `true` when the user confirms deletion.
Future<bool> confirmZakatItemDeletion(
  BuildContext context, {
  required String itemName,
}) async {
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  final bool? confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(l10n.zakatDeleteConfirmTitle),
        content: Text(l10n.zakatDeleteConfirmMessage(itemName)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.zakatCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.zakatDeleteItem),
          ),
        ],
      );
    },
  );
  return confirmed == true;
}
