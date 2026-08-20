import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gold_weight_converter/l10n/app_localizations.dart';
import 'package:gold_weight_converter/services/analytics_service.dart';
import 'package:gold_weight_converter/services/external_links.dart';

/// Copy and share icon buttons for a result card.
class ResultActions extends StatelessWidget {
  final String text;
  final String screen;

  const ResultActions({super.key, required this.text, required this.screen});

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: text));
    AnalyticsService.trackResultsCopied(screen: screen);
    if (!context.mounted) return;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.resultsCopied)));
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: l10n.copyResults,
          visualDensity: VisualDensity.compact,
          onPressed: text.trim().isEmpty ? null : () => _copy(context),
          icon: Icon(
            Icons.copy_outlined,
            size: 20,
            color: scheme.onSurfaceVariant,
          ),
        ),
        IconButton(
          tooltip: l10n.shareResults,
          visualDensity: VisualDensity.compact,
          onPressed: text.trim().isEmpty
              ? null
              : () => ExternalLinks.shareText(text, screen: screen),
          icon: Icon(
            Icons.share_outlined,
            size: 20,
            color: scheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
