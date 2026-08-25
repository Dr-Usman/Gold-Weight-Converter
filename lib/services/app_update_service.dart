import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_update/in_app_update.dart';

import 'analytics_service.dart';

/// Google Play flexible in-app updates (Android + Play installs only).
class AppUpdateService {
  AppUpdateService._();

  static bool _checkedThisSession = false;
  static StreamSubscription<InstallStatus>? _installSubscription;

  static bool get isSupported {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android;
  }

  /// Checks Play once per session and starts a flexible update when available.
  static Future<void> checkForFlexibleUpdate({
    required VoidCallback onDownloadReady,
  }) async {
    if (!isSupported || _checkedThisSession) return;
    _checkedThisSession = true;

    try {
      final AppUpdateInfo info = await InAppUpdate.checkForUpdate();

      if (info.installStatus == InstallStatus.downloaded) {
        onDownloadReady();
        return;
      }

      if (info.updateAvailability != UpdateAvailability.updateAvailable) {
        return;
      }

      if (!info.flexibleUpdateAllowed) {
        return;
      }

      _installSubscription?.cancel();
      _installSubscription = InAppUpdate.installUpdateListener.listen((
        InstallStatus status,
      ) {
        if (status == InstallStatus.downloaded) {
          onDownloadReady();
        }
      });

      AnalyticsService.trackAppUpdatePrompted();

      final AppUpdateResult result = await InAppUpdate.startFlexibleUpdate();
      if (result != AppUpdateResult.success) {
        await _installSubscription?.cancel();
        _installSubscription = null;
      }
    } catch (_) {
      // Unavailable off Play (sideloaded APK, emulator, API errors).
    }
  }

  static Future<void> completeFlexibleUpdate() async {
    if (!isSupported) return;

    try {
      AnalyticsService.trackAppUpdateCompleted();
      await InAppUpdate.completeFlexibleUpdate();
    } catch (_) {
      // Play may reject if update is no longer pending.
    }
  }

  static void dispose() {
    unawaited(_installSubscription?.cancel());
    _installSubscription = null;
  }
}
