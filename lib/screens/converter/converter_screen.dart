import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../constants/unit_enum.dart';
import '../../constants/weight_unit_enum.dart';
import '../../l10n/app_localizations.dart';
import '../../models/app_currency.dart';
import '../../models/conversion_history_item.dart';
import '../../providers/currency_provider.dart';
import '../../providers/history_provider.dart';
import '../../providers/locale_provider.dart';
import '../../providers/unit_provider.dart';
import '../../providers/weight_provider.dart';
import '../../services/analytics_service.dart';
import '../../services/preferences_service.dart';
import '../../services/weight_converter.dart';
import '../../utils/number_helper.dart';
import '../../widgets/app_banner_ad.dart';
import '../../widgets/app_drawer.dart';
import 'widgets/converter_action_buttons.dart';
import 'widgets/converter_input_section.dart';
import 'widgets/converter_price_card.dart';
import 'widgets/converter_results_section.dart';

class GoldConverterScreen extends ConsumerStatefulWidget {
  const GoldConverterScreen({super.key});

  @override
  ConsumerState<GoldConverterScreen> createState() =>
      _GoldConverterScreenState();
}

class _GoldConverterScreenState extends ConsumerState<GoldConverterScreen> {
  /// Prefills sample weights/rate and runs Calculate (README screenshots).
  ///
  /// ```bash
  /// flutter run --dart-define=HIDE_ADS=true --dart-define=SCREENSHOT_DEMO=true
  /// ```
  static const bool _screenshotDemo = bool.fromEnvironment(
    'SCREENSHOT_DEMO',
    defaultValue: false,
  );

  final TextEditingController tolaController = TextEditingController();
  final TextEditingController lalController = TextEditingController();
  final TextEditingController mashaController = TextEditingController();
  final TextEditingController anaController = TextEditingController();
  final TextEditingController rattiController = TextEditingController();
  final TextEditingController gramController = TextEditingController();
  final TextEditingController ounceController = TextEditingController();
  final TextEditingController goldRateController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (_screenshotDemo) {
      tolaController.text = '1.5';
      mashaController.text = '4';
      anaController.text = '7';
      rattiController.text = '18';
      goldRateController.text = '150,000';
    } else {
      goldRateController.text = ref
          .read(preferencesServiceProvider)
          .getConverterRateText();
    }
    goldRateController.addListener(_persistGoldRate);
    if (_screenshotDemo) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        calculateAll();
      });
    }
  }

  @override
  void dispose() {
    goldRateController.removeListener(_persistGoldRate);
    tolaController.dispose();
    lalController.dispose();
    mashaController.dispose();
    anaController.dispose();
    rattiController.dispose();
    gramController.dispose();
    ounceController.dispose();
    goldRateController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _persistGoldRate() {
    ref
        .read(preferencesServiceProvider)
        .saveConverterRateText(goldRateController.text);
  }

  String _localizedRateUnit(AppLocalizations l10n, UnitEnum unit) {
    return switch (unit) {
      UnitEnum.tola => l10n.unitTola,
      UnitEnum.tenGram => l10n.unitTenGram,
      UnitEnum.oneGram => l10n.unitOneGram,
      UnitEnum.ounce => l10n.unitOunce,
    };
  }

  void _clearAll() {
    FocusManager.instance.primaryFocus?.unfocus();

    tolaController.clear();
    lalController.clear();
    mashaController.clear();
    anaController.clear();
    rattiController.clear();
    gramController.clear();
    ounceController.clear();
    goldRateController.clear();

    ref.read(goldResultNotifierProvider.notifier).clearResults();
  }

  double _getDouble(TextEditingController controller) {
    final String text = controller.text.trim();
    if (text.isEmpty) return 0.0;

    final double? value = NumberHelper.parseFormattedNumber(text);
    if (value == null || value < 0) {
      return 0.0;
    }
    return value;
  }

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final number = NumberHelper.parseFormattedNumber(value);
    if (number == null) {
      final l10n = AppLocalizations.of(context)!;
      return l10n.validationValidNumber;
    }
    if (number < 0) {
      final l10n = AppLocalizations.of(context)!;
      return l10n.validationPositiveNumber;
    }
    return null;
  }

  // Private method for calculations without Unfocus (used by onChanged)
  void _calculate() {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final Locale currentLocale = ref.read(localeProvider);
    final AppCurrency currentCurrency = ref.read(currencyProvider);
    final bool isNepaliSystem =
        currentLocale.languageCode == 'ne' || currentCurrency.code == 'NPR';

    final double tola = _getDouble(tolaController);
    final double lal = _getDouble(lalController);
    final double masha = _getDouble(mashaController);
    final double ana = _getDouble(anaController);
    final double ratti = _getDouble(rattiController);
    final double gram = _getDouble(gramController);
    final UnitEnum selectedRateUnit = ref.read(rateUnitProvider);
    final double ounce = selectedRateUnit == UnitEnum.ounce
        ? _getDouble(ounceController)
        : 0.0;

    final bool hasAnyInput = isNepaliSystem
        ? (tola > 0 || ana > 0 || lal > 0 || gram > 0 || ounce > 0)
        : (tola > 0 ||
              masha > 0 ||
              ana > 0 ||
              ratti > 0 ||
              gram > 0 ||
              ounce > 0);

    if (!hasAnyInput) {
      ref.read(goldResultNotifierProvider.notifier).clearResults();
      return;
    }

    final double totalGrams = WeightConverter.totalGrams(
      tola: tola,
      lal: isNepaliSystem ? lal : 0,
      masha: isNepaliSystem ? 0 : masha,
      ana: ana,
      ratti: isNepaliSystem ? 0 : ratti,
      gram: gram,
      ounce: ounce,
    );
    final StringBuffer resultBuffer = StringBuffer();

    if (tola > 0) {
      resultBuffer.writeln(
        l10n.tolaConversion(
          '$tola',
          '${AppConstants.tolaToGram}',
          WeightConverter.toGrams(tola, WeightUnitEnum.tola).toStringAsFixed(4),
        ),
      );
    }
    if (isNepaliSystem) {
      if (ana > 0) {
        resultBuffer.writeln(
          l10n.anaConversion(
            '$ana',
            '${AppConstants.anaToGram}',
            WeightConverter.toGrams(ana, WeightUnitEnum.ana).toStringAsFixed(4),
          ),
        );
      }
      if (lal > 0) {
        resultBuffer.writeln(
          l10n.lalConversion(
            '$lal',
            '${AppConstants.lalToGram}',
            WeightConverter.toGrams(lal, WeightUnitEnum.lal).toStringAsFixed(4),
          ),
        );
      }
    } else {
      if (masha > 0) {
        resultBuffer.writeln(
          l10n.mashaConversion(
            '$masha',
            '${AppConstants.mashaToGram}',
            WeightConverter.toGrams(
              masha,
              WeightUnitEnum.masha,
            ).toStringAsFixed(4),
          ),
        );
      }
      if (ana > 0) {
        resultBuffer.writeln(
          l10n.anaConversion(
            '$ana',
            '${AppConstants.anaToGram}',
            WeightConverter.toGrams(ana, WeightUnitEnum.ana).toStringAsFixed(4),
          ),
        );
      }
      if (ratti > 0) {
        resultBuffer.writeln(
          l10n.rattiConversion(
            '$ratti',
            '${AppConstants.rattiToGram}',
            WeightConverter.toGrams(
              ratti,
              WeightUnitEnum.ratti,
            ).toStringAsFixed(4),
          ),
        );
      }
    }
    if (ounce > 0) {
      resultBuffer.writeln(
        l10n.ounceConversion(
          '$ounce',
          '${AppConstants.ounceToGram}',
          WeightConverter.toGrams(
            ounce,
            WeightUnitEnum.ounce,
          ).toStringAsFixed(4),
        ),
      );
    }
    if (gram > 0) {
      resultBuffer.writeln(l10n.gramConversion('$gram'));
    }

    resultBuffer.writeln(
      '\n${l10n.totalWeight(totalGrams.toStringAsFixed(4))}',
    );
    resultBuffer.writeln('\n${l10n.convertedTo}');
    resultBuffer.writeln(
      l10n.tolaResult(
        WeightConverter.fromGrams(
          totalGrams,
          WeightUnitEnum.tola,
        ).toStringAsFixed(4),
      ),
    );

    if (isNepaliSystem) {
      resultBuffer.writeln(
        l10n.anaResult(
          WeightConverter.fromGrams(
            totalGrams,
            WeightUnitEnum.ana,
          ).toStringAsFixed(4),
        ),
      );
      resultBuffer.writeln(
        l10n.lalResult(
          WeightConverter.fromGrams(
            totalGrams,
            WeightUnitEnum.lal,
          ).toStringAsFixed(4),
        ),
      );
    } else {
      resultBuffer.writeln(
        l10n.mashaResult(
          WeightConverter.fromGrams(
            totalGrams,
            WeightUnitEnum.masha,
          ).toStringAsFixed(4),
        ),
      );
      resultBuffer.writeln(
        l10n.anaResult(
          WeightConverter.fromGrams(
            totalGrams,
            WeightUnitEnum.ana,
          ).toStringAsFixed(4),
        ),
      );
      resultBuffer.writeln(
        l10n.rattiResult(
          WeightConverter.fromGrams(
            totalGrams,
            WeightUnitEnum.ratti,
          ).toStringAsFixed(4),
        ),
      );
    }

    resultBuffer.writeln(
      l10n.ounceResult(
        WeightConverter.fromGrams(
          totalGrams,
          WeightUnitEnum.ounce,
        ).toStringAsFixed(4),
      ),
    );

    String newResultText = resultBuffer.toString();
    String? newPriceText;

    double rate = _getDouble(goldRateController);
    if (rate > 0) {
      final goldRateUnit = ref.read(rateUnitProvider);
      final double gramRate = WeightConverter.ratePerGram(rate, goldRateUnit);
      double price = totalGrams * gramRate;

      final currency = ref.read(currencyProvider);
      final bool hasRateFraction =
          (rate - rate.truncateToDouble()).abs() > 0.000001;
      final int decimalDigits = hasRateFraction ? 2 : 0;
      final currencyFormat = currency.numberFormatWithDigits(decimalDigits);

      final double finalPrice = hasRateFraction ? price : price.roundToDouble();
      final String priceFormatted = currencyFormat.format(finalPrice);
      final String rateFormatted = currencyFormat.format(rate);
      final String unitLabel = _localizedRateUnit(l10n, goldRateUnit);

      newPriceText =
          '${l10n.goldPrice(priceFormatted)}\n'
          '${l10n.rateInfo(rateFormatted, unitLabel)}';
    }

    final goldResultState = ref.read(goldResultNotifierProvider);
    final String? resultText = goldResultState.weightsText;
    final String? priceText = goldResultState.priceText;

    final goldResultNotifier = ref.read(goldResultNotifierProvider.notifier);

    final double totalTola = WeightConverter.gramsToTola(totalGrams);
    final double roundedGrams = double.parse(totalGrams.toStringAsFixed(4));
    final double roundedTola = double.parse(totalTola.toStringAsFixed(4));

    if (resultText != newResultText ||
        goldResultState.totalGrams != roundedGrams ||
        goldResultState.totalTola != roundedTola) {
      goldResultNotifier.setGoldWeights(
        newResultText,
        totalGrams: roundedGrams,
        totalTola: roundedTola,
      );
    }
    if (priceText != newPriceText) {
      goldResultNotifier.setGoldPrice(newPriceText);
    }
  }

  // Public method for button presses (includes unfocus)
  void calculateAll() {
    FocusManager.instance.primaryFocus?.unfocus();

    final Locale currentLocale = ref.read(localeProvider);
    final AppCurrency currentCurrency = ref.read(currencyProvider);
    final bool isNepaliSystem =
        currentLocale.languageCode == 'ne' || currentCurrency.code == 'NPR';

    final double tola = _getDouble(tolaController);
    final double lal = _getDouble(lalController);
    final double masha = _getDouble(mashaController);
    final double ana = _getDouble(anaController);
    final double ratti = _getDouble(rattiController);
    final double gram = _getDouble(gramController);
    final UnitEnum rateUnit = ref.read(rateUnitProvider);
    final double ounce = rateUnit == UnitEnum.ounce
        ? _getDouble(ounceController)
        : 0.0;
    final double rate = _getDouble(goldRateController);
    final bool hasInput = isNepaliSystem
        ? (tola > 0 || ana > 0 || lal > 0 || gram > 0 || ounce > 0)
        : (tola > 0 ||
              masha > 0 ||
              ana > 0 ||
              ratti > 0 ||
              gram > 0 ||
              ounce > 0);

    _calculate();

    if (hasInput) {
      final List<String> inputUnitsUsed = <String>[
        if (tola > 0) 'tola',
        if (ana > 0) 'ana',
        if (isNepaliSystem && lal > 0) 'lal',
        if (!isNepaliSystem && masha > 0) 'masha',
        if (!isNepaliSystem && ratti > 0) 'ratti',
        if (gram > 0) 'gram',
        if (ounce > 0) 'ounce',
      ];
      final double totalGrams = WeightConverter.totalGrams(
        tola: tola,
        lal: isNepaliSystem ? lal : 0,
        masha: isNepaliSystem ? 0 : masha,
        ana: ana,
        ratti: isNepaliSystem ? 0 : ratti,
        gram: gram,
        ounce: ounce,
      );

      final double totalTola = WeightConverter.gramsToTola(totalGrams);

      AnalyticsService.trackConversionCompleted(
        inputUnitsUsed: inputUnitsUsed,
        rateUnit: switch (rateUnit) {
          UnitEnum.tola => 'tola',
          UnitEnum.tenGram => 'ten_gram',
          UnitEnum.oneGram => 'one_gram',
          UnitEnum.ounce => 'ounce',
        },
        hasGoldRate: rate > 0,
        totalGrams: double.parse(totalGrams.toStringAsFixed(4)),
        totalTola: double.parse(totalTola.toStringAsFixed(4)),
      );

      final String? priceText = ref.read(goldResultNotifierProvider).priceText;
      final String? weightsText = ref
          .read(goldResultNotifierProvider)
          .weightsText;

      final historyItem = ConversionHistoryItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp: DateTime.now(),
        inputs: <String, double>{
          if (tola > 0) 'tola': tola,
          if (ana > 0) 'ana': ana,
          if (isNepaliSystem && lal > 0) 'lal': lal,
          if (!isNepaliSystem && masha > 0) 'masha': masha,
          if (!isNepaliSystem && ratti > 0) 'ratti': ratti,
          if (gram > 0) 'gram': gram,
          if (ounce > 0) 'ounce': ounce,
        },
        goldRate: rate > 0 ? rate : null,
        rateUnit: rate > 0 ? rateUnit.name : null,
        currencyCode: currentCurrency.code,
        totalGrams: double.parse(totalGrams.toStringAsFixed(4)),
        totalTola: double.parse(totalTola.toStringAsFixed(4)),
        priceFormatted: priceText,
        resultText: weightsText,
        isNepaliSystem: isNepaliSystem,
      );

      ref.read(conversionHistoryProvider.notifier).addEntry(historyItem);
    }

    // Scroll to bottom after calculation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _restoreFromHistory(ConversionHistoryItem item) {
    String formatVal(double? val) {
      if (val == null || val <= 0) return '';
      if (val == val.truncateToDouble()) return val.truncate().toString();
      return val.toString();
    }

    tolaController.text = formatVal(item.inputs['tola']);
    lalController.text = formatVal(item.inputs['lal']);
    mashaController.text = formatVal(item.inputs['masha']);
    anaController.text = formatVal(item.inputs['ana']);
    rattiController.text = formatVal(item.inputs['ratti']);
    gramController.text = formatVal(item.inputs['gram']);
    ounceController.text = formatVal(item.inputs['ounce']);

    if (item.goldRate != null && item.goldRate! > 0) {
      goldRateController.text = formatVal(item.goldRate);
      if (item.rateUnit != null) {
        ref
            .read(rateUnitProvider.notifier)
            .setRateUnit(UnitEnum.fromString(item.rateUnit));
      }
    } else {
      goldRateController.clear();
    }

    calculateAll();

    AnalyticsService.trackHistoryItemRestored(
      totalGrams: item.totalGrams,
      totalTola: item.totalTola,
      hasGoldRate: item.goldRate != null && item.goldRate! > 0,
    );
  }

  String _shareableConverterText(String weightsText) {
    final String? priceText = ref.read(goldResultNotifierProvider).priceText;
    if (priceText == null || priceText.isEmpty) return weightsText.trim();
    return '${weightsText.trim()}\n\n${priceText.trim()}';
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final Locale currentLocale = ref.watch(localeProvider);
    final AppCurrency currentCurrency = ref.watch(currencyProvider);
    final bool isNepaliSystem =
        currentLocale.languageCode == 'ne' || currentCurrency.code == 'NPR';
    final UnitEnum selectedRateUnit = ref.watch(rateUnitProvider);

    ref.listen(currencyProvider, (_, _) {
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _calculate();
        });
      }
    });
    ref.listen(localeProvider, (_, _) {
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _calculate();
        });
      }
    });
    ref.listen<ConversionHistoryItem?>(pendingRestoreProvider, (_, next) {
      if (next != null && mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _restoreFromHistory(next);
            ref.read(pendingRestoreProvider.notifier).clear();
          }
        });
      }
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          l10n.appTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
            letterSpacing: 0,
            fontFamily: 'Cinzel',
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryDark,
                AppColors.primary,
                AppColors.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? const [
                    Color(0xFF171310),
                    Color(0xFF211A14),
                    Color(0xFF2A2118),
                  ]
                : const [
                    AppColors.background,
                    AppColors.backgroundMid,
                    AppColors.backgroundFade,
                  ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -60,
              right: -60,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.12),
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 760),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ConverterInputSection(
                          tolaController: tolaController,
                          mashaController: mashaController,
                          anaController: anaController,
                          rattiController: rattiController,
                          gramController: gramController,
                          ounceController: ounceController,
                          lalController: lalController,
                          goldRateController: goldRateController,
                          isNepaliSystem: isNepaliSystem,
                          currentLocale: currentLocale,
                          selectedRateUnit: selectedRateUnit,
                          onRateUnitChanged: (newUnit) {
                            ref
                                .read(rateUnitProvider.notifier)
                                .setRateUnit(newUnit);
                            _calculate();
                          },
                          validator: _validateInput,
                          onFieldChanged: _calculate,
                        ),
                        const SizedBox(height: 10),
                        ConverterActionButtons(
                          onCalculate: calculateAll,
                          onClearAll: _clearAll,
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final goldResult = ref.watch(
                              goldResultNotifierProvider,
                            );
                            final resultText = goldResult.weightsText;

                            if (resultText == null || resultText.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            return ConverterResultsSection(
                              resultText: resultText,
                              shareableText: _shareableConverterText(
                                resultText,
                              ),
                              totalGrams: goldResult.totalGrams ?? 0.0,
                              totalTola: goldResult.totalTola ?? 0.0,
                            );
                          },
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final priceText = ref.watch(
                              goldResultNotifierProvider.select(
                                (model) => model.priceText,
                              ),
                            );

                            if (priceText == null || priceText.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            return ConverterPriceCard(priceText: priceText);
                          },
                        ),
                        const AppBannerAd(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
