import 'package:flutter/foundation.dart';

/// AdMob IDs for Gold Weight Converter.
///
/// Debug/profile builds use Google's official sample ad units so clicks and
/// impressions never count as real traffic (avoids policy risk).
/// Release builds use your production ad unit.
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

  /// Production banner: gwc_home_banner
  static const String _prodBannerAdUnitId =
      'ca-app-pub-2544985250210456/7322530743';

  /// Google sample banner — always use in non-release builds.
  static const String _testBannerAdUnitId =
      'ca-app-pub-3940256099942544/6300978111';

  /// Whether banners should load for this build.
  static bool get adsEnabled => !hideAds;

  /// Banner ad unit ID for the current build mode.
  static String get bannerAdUnitId {
    if (kReleaseMode) {
      return _prodBannerAdUnitId;
    }
    return _testBannerAdUnitId;
  }

  /// True when using Google sample ads (debug / profile).
  static bool get isUsingTestAds => !kReleaseMode;
}
