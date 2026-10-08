import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gold_weight_converter/constants/ad_config.dart';
import 'package:gold_weight_converter/services/ads_service.dart';
import 'package:gold_weight_converter/services/preferences_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Inline adaptive banner for use inside scroll content (not sticky).
/// Hides itself when ads are unsupported, ad-free pass is active, or fails to load.
class AppBannerAd extends ConsumerStatefulWidget {
  final BannerPlacement placement;

  const AppBannerAd({
    super.key,
    this.placement = BannerPlacement.converter,
  });

  @override
  ConsumerState<AppBannerAd> createState() => _AppBannerAdState();
}

class _AppBannerAdState extends ConsumerState<AppBannerAd> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  bool _loadStarted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }

  Future<void> _loadAd() async {
    final adFreeUntil = ref.read(adFreePassProvider);
    final bool isAdFree =
        adFreeUntil != null && DateTime.now().isBefore(adFreeUntil);

    if (!AdConfig.adsEnabled ||
        !AdsService.isSupported ||
        isAdFree ||
        _loadStarted) {
      return;
    }
    _loadStarted = true;

    final int width = MediaQuery.sizeOf(context).width.truncate();
    if (width <= 0) {
      _loadStarted = false;
      return;
    }

    try {
      final AnchoredAdaptiveBannerAdSize? size =
          await AdSize.getLargeAnchoredAdaptiveBannerAdSize(width);
      if (size == null || !mounted) return;

      final BannerAd banner = BannerAd(
        adUnitId: AdConfig.getBannerAdUnitId(widget.placement),
        size: size,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            if (!mounted) {
              ad.dispose();
              return;
            }
            setState(() => _isLoaded = true);
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
            if (_bannerAd == ad) {
              _bannerAd = null;
            }
            if (mounted) {
              setState(() => _isLoaded = false);
            }
          },
        ),
      );

      _bannerAd = banner;
      await banner.load();
    } catch (_) {
      _bannerAd?.dispose();
      _bannerAd = null;
      if (mounted) {
        setState(() => _isLoaded = false);
      }
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _bannerAd = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adFreeUntil = ref.watch(adFreePassProvider);
    final bool isAdFree =
        adFreeUntil != null && DateTime.now().isBefore(adFreeUntil);

    if (!AdConfig.adsEnabled || isAdFree) {
      return const SizedBox.shrink();
    }

    final BannerAd? banner = _bannerAd;
    if (!_isLoaded || banner == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: double.infinity,
          height: banner.size.height.toDouble(),
          child: AdWidget(ad: banner),
        ),
      ),
    );
  }
}
