import 'package:flutter/foundation.dart';
import 'package:gold_weight_converter/constants/ad_config.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Initializes Google Mobile Ads on supported platforms only.
class AdsService {
  AdsService._();

  static bool get isSupported {
    if (!AdConfig.adsEnabled) return false;
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  static Future<void> init() async {
    if (!isSupported) return;
    try {
      await MobileAds.instance.initialize();
    } catch (_) {
      // Missing plugin in tests / unsupported embedder — ads stay disabled.
    }
  }
}
