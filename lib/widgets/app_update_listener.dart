import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/app_update_service.dart';

/// Runs a one-time Play flexible update check after the first frame.
class AppUpdateListener extends StatefulWidget {
  const AppUpdateListener({required this.child, super.key});

  final Widget child;

  @override
  State<AppUpdateListener> createState() => _AppUpdateListenerState();
}

class _AppUpdateListenerState extends State<AppUpdateListener> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppUpdateService.checkForFlexibleUpdate(
        onDownloadReady: _showRestartSnackBar,
      );
    });
  }

  void _showRestartSnackBar() {
    if (!mounted) return;

    final AppLocalizations? l10n = AppLocalizations.of(context);
    if (l10n == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.appUpdateReady),
        action: SnackBarAction(
          label: l10n.appUpdateRestart,
          onPressed: AppUpdateService.completeFlexibleUpdate,
        ),
      ),
    );
  }

  @override
  void dispose() {
    AppUpdateService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
