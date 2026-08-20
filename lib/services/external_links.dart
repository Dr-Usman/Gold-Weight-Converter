import 'package:flutter/material.dart';
import 'package:gold_weight_converter/l10n/app_localizations.dart';
import 'package:gold_weight_converter/services/analytics_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ExternalLinks {
  ExternalLinks._();

  static Future<void> openUrl(
    BuildContext context,
    String url, {
    VoidCallback? onOpened,
  }) async {
    final Uri uri = Uri.parse(url);
    final bool launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (launched) {
      onOpened?.call();
      return;
    }
    if (!context.mounted) return;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.openLinkFailed)));
  }

  static Future<void> shareText(String text, {required String screen}) async {
    final ShareResult result = await SharePlus.instance.share(
      ShareParams(text: text),
    );
    if (result.status == ShareResultStatus.dismissed) return;
    AnalyticsService.trackResultsShared(screen: screen);
  }

  static Future<void> shareApp(String message) async {
    final ShareResult result = await SharePlus.instance.share(
      ShareParams(text: message),
    );
    if (result.status == ShareResultStatus.dismissed) return;
    AnalyticsService.trackAppShared();
  }
}
