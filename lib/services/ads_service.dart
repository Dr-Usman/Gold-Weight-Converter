import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:gold_weight_converter/constants/ad_config.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Initializes Google Mobile Ads and manages full-screen ad presentation.
class AdsService {
  AdsService._();

  static DateTime? _lastInterstitialTime;
  static const Duration interstitialCooldown = Duration(minutes: 5);

  /// Test hook to bypass native ad SDK calls in widget tests.
  @visibleForTesting
  static bool bypassAdsForTesting = false;

  static bool get isSupported {
    if (bypassAdsForTesting) return false;
    if (!AdConfig.adsEnabled) return false;
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  static Future<void> init() async {
    if (!isSupported) return;
    try {
      await MobileAds.instance.initialize();
      // await MobileAds.instance.updateRequestConfiguration(
      //   RequestConfiguration(
      //     testDeviceIds: const [
      //       '442DA0E667491593DC9F710D29777DD3',
      //     ],
      //   ),
      // );
    } catch (e) {
      // Missing plugin in tests / unsupported embedder — ads stay disabled.
      if (kDebugMode) debugPrint('Error initializing ads: $e');
    }
  }

  /// Shows an interstitial ad with a 5-minute frequency cooldown.
  /// Returns `true` when user has satisfied the requirement (or on error/unsupported).
  static Future<bool> showInterstitial() async {
    if (!isSupported) return true;

    // Honor 5-minute cooldown between interstitial impressions
    if (_lastInterstitialTime != null &&
        DateTime.now().difference(_lastInterstitialTime!) <
            interstitialCooldown) {
      return true;
    }

    final completer = Completer<bool>();

    try {
      await InterstitialAd.load(
        adUnitId: AdConfig.historyInterstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
                _lastInterstitialTime = DateTime.now();
                if (!completer.isCompleted) completer.complete(true);
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
                if (!completer.isCompleted) completer.complete(true);
              },
            );
            ad.show();
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('Interstitial failed to load: $error');
            if (!completer.isCompleted) completer.complete(true);
          },
        ),
      );
    } catch (e) {
      debugPrint('Error showing interstitial: $e');
      if (!completer.isCompleted) completer.complete(true);
    }

    return completer.future;
  }

  /// Shows a rewarded ad. Returns `true` if the user earned the reward (or on graceful fallback).
  static Future<bool> showRewarded() async {
    if (!isSupported) return true;

    final completer = Completer<bool>();
    bool earned = false;

    try {
      await RewardedAd.load(
        adUnitId: AdConfig.historyRewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
                if (!completer.isCompleted) completer.complete(earned);
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
                // If ad failed to display, do not penalize user
                if (!completer.isCompleted) completer.complete(true);
              },
            );
            ad.show(
              onUserEarnedReward: (ad, reward) {
                earned = true;
              },
            );
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('Rewarded ad failed to load: $error');
            // Gracefully unlock if ad fails to load (no internet / no fill)
            if (!completer.isCompleted) completer.complete(true);
          },
        ),
      );
    } catch (e) {
      debugPrint('Error showing rewarded ad: $e');
      if (!completer.isCompleted) completer.complete(true);
    }

    return completer.future;
  }

  @visibleForTesting
  static void resetCooldown() {
    _lastInterstitialTime = null;
  }
}
