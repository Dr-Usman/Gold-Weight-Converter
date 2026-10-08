import 'package:flutter/foundation.dart';

enum BannerPlacement {
  converter,
  zakat,
  history,
}

/// AdMob IDs for Gold Weight Converter.
///
/// Debug/profile builds use Google's official sample ad units so clicks and
/// impressions never count as real traffic (avoids policy risk).
/// Release builds use production ad units.
///
/// Pass `--dart-define=HIDE_ADS=true` to disable banners entirely (useful for
/// README/Play Store screenshots, or a quieter debug session).
///
/// Google sample IDs:
/// https://developers.google.com/admob/android/test-ads
class AdConfig {
  /// AdMob App ID (Android). Also declared in AndroidManifest / Info.plist.
  static const String appId = 'ca-app-pub-2544985250210456~3307264116';

  /// When true, no ad SDK load or banner widgets (screenshots / quiet debug).
  ///
  /// ```bash
  /// flutter run --dart-define=HIDE_ADS=true
  /// flutter build apk --dart-define=HIDE_ADS=true
  /// ```
  static const bool hideAds = bool.fromEnvironment(
    'HIDE_ADS',
    defaultValue: false,
  );

  // Production Banner IDs
  static const String _prodConverterBanner =
      'ca-app-pub-2544985250210456/7322530743';
  static const String _prodZakatBanner =
      'ca-app-pub-2544985250210456/7063140288';
  static const String _prodHistoryBanner =
      'ca-app-pub-2544985250210456/3301743261';

  // Production Full-Screen IDs
  static const String _prodHistoryInterstitial =
      'ca-app-pub-2544985250210456/7226791812';
  static const String _prodHistoryRewarded =
      'ca-app-pub-2544985250210456/7669644949';

  // Google Test Ad Units (Official Sample Units)
  static const String _testBanner =
      'ca-app-pub-3940256099942544/6300978111';
  static const String _testInterstitial =
      'ca-app-pub-3940256099942544/1033173712';
  static const String _testRewarded =
      'ca-app-pub-3940256099942544/5224354917';

  /// Whether ads should load for this build.
  static bool get adsEnabled => !hideAds;

  /// Banner ad unit ID for the current build mode and placement.
  static String getBannerAdUnitId([
    BannerPlacement placement = BannerPlacement.converter,
  ]) {
    if (!kReleaseMode) {
      return _testBanner;
    }
    return switch (placement) {
      BannerPlacement.converter => _prodConverterBanner,
      BannerPlacement.zakat => _prodZakatBanner,
      BannerPlacement.history => _prodHistoryBanner,
    };
  }

  /// Default banner ad unit ID (for backward compatibility).
  static String get bannerAdUnitId => getBannerAdUnitId();

  /// History screen interstitial ad unit ID (for quick session unlock).
  static String get historyInterstitialAdUnitId {
    if (!kReleaseMode) {
      return _testInterstitial;
    }
    return _prodHistoryInterstitial;
  }

  /// History screen rewarded ad unit ID (for 24h ad-free pass + all items).
  static String get historyRewardedAdUnitId {
    if (!kReleaseMode) {
      return _testRewarded;
    }
    return _prodHistoryRewarded;
  }

  /// True when using Google sample ads (debug / profile).
  static bool get isUsingTestAds => !kReleaseMode;
}
