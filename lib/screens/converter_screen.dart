import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gold_weight_converter/constants/app_colors.dart';
import 'package:gold_weight_converter/constants/app_constants.dart';
import 'package:gold_weight_converter/constants/unit_enum.dart';
import 'package:gold_weight_converter/constants/weight_unit_enum.dart';
import 'package:gold_weight_converter/l10n/app_localizations.dart';
import 'package:gold_weight_converter/providers/currency_provider.dart';
import 'package:gold_weight_converter/providers/locale_provider.dart';
import 'package:gold_weight_converter/providers/unit_provider.dart';
import 'package:gold_weight_converter/providers/weight_provider.dart';
import 'package:gold_weight_converter/services/analytics_service.dart';
import 'package:gold_weight_converter/services/preferences_service.dart';
import 'package:gold_weight_converter/services/weight_converter.dart';
import 'package:gold_weight_converter/utils/number_helper.dart';

import 'package:gold_weight_converter/widgets/app_banner_ad.dart';
import 'package:gold_weight_converter/widgets/app_drawer.dart';
import 'package:gold_weight_converter/widgets/gold_text_field.dart';
import 'package:gold_weight_converter/widgets/result_actions.dart';

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
  final TextEditingController mashaController = TextEditingController();
  final TextEditingController anaController = TextEditingController();
  final TextEditingController rattiController = TextEditingController();
  final TextEditingController gramController = TextEditingController();
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
    mashaController.dispose();
    anaController.dispose();
    rattiController.dispose();
    gramController.dispose();
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
    };
  }

  void _clearAll() {
    // Unfocus any currently focused text field
    FocusScope.of(context).unfocus();

    tolaController.clear();
    mashaController.clear();
    anaController.clear();
    rattiController.clear();
    gramController.clear();
    goldRateController.clear();

    ref.read(goldResultNotifierProvider.notifier).clearResults();
    // setState(() {
    //   resultText = '';
    //   priceText = '';
    // });
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
    final double tola = _getDouble(tolaController);
    final double masha = _getDouble(mashaController);
    final double ana = _getDouble(anaController);
    final double ratti = _getDouble(rattiController);
    final double gram = _getDouble(gramController);

    if (tola == 0 && masha == 0 && ana == 0 && ratti == 0 && gram == 0) {
      ref.read(goldResultNotifierProvider.notifier).clearResults();
      return;
    }

    final double totalGrams = WeightConverter.totalGrams(
      tola: tola,
      masha: masha,
      ana: ana,
      ratti: ratti,
      gram: gram,
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

    String newResultText = resultBuffer.toString();
    String? newPriceText;

    double rate = _getDouble(goldRateController);
    if (rate > 0) {
      final goldRateUnit = ref.read(rateUnitProvider);
      final double gramRate = WeightConverter.ratePerGram(rate, goldRateUnit);
      double price = totalGrams * gramRate;

      final currencyFormat = ref.read(currencyProvider).numberFormat;
      final String priceFormatted = currencyFormat.format(price);
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

    if (resultText != newResultText) {
      goldResultNotifier.setGoldWeights(newResultText);
    }
    if (priceText != newPriceText) {
      goldResultNotifier.setGoldPrice(newPriceText);
    }

    // if (resultText != newResultText || priceText != newPriceText) {
    //   setState(() {
    //     resultText = newResultText;
    //     priceText = newPriceText;
    //   });
    // }
  }

  // Public method for button presses (includes unfocus)
  void calculateAll() {
    FocusScope.of(context).unfocus();

    final double tola = _getDouble(tolaController);
    final double masha = _getDouble(mashaController);
    final double ana = _getDouble(anaController);
    final double ratti = _getDouble(rattiController);
    final double gram = _getDouble(gramController);
    final double rate = _getDouble(goldRateController);
    final bool hasInput =
        tola > 0 || masha > 0 || ana > 0 || ratti > 0 || gram > 0;

    _calculate();

    if (hasInput) {
      final List<String> inputUnitsUsed = <String>[
        if (tola > 0) 'tola',
        if (masha > 0) 'masha',
        if (ana > 0) 'ana',
        if (ratti > 0) 'ratti',
        if (gram > 0) 'gram',
      ];
      final UnitEnum rateUnit = ref.read(rateUnitProvider);
      final double totalGrams = WeightConverter.totalGrams(
        tola: tola,
        masha: masha,
        ana: ana,
        ratti: ratti,
        gram: gram,
      );

      AnalyticsService.trackConversionCompleted(
        inputUnitsUsed: inputUnitsUsed,
        rateUnit: switch (rateUnit) {
          UnitEnum.tola => 'tola',
          UnitEnum.tenGram => 'ten_gram',
          UnitEnum.oneGram => 'one_gram',
        },
        hasGoldRate: rate > 0,
        totalGrams: double.parse(totalGrams.toStringAsFixed(4)),
      );
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

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

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

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text(
          AppLocalizations.of(context)!.appTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: 0.2,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
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
      onDrawerChanged: (isOpened) {
        if (isOpened) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
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
              top: -120,
              left: -80,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondary.withValues(alpha: 0.18),
                ),
              ),
            ),
            Positioned(
              right: -90,
              top: 180,
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
                        Container(
                          padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: isDark
                                ? scheme.surfaceContainer.withValues(
                                    alpha: 0.95,
                                  )
                                : Colors.white.withValues(alpha: 0.95),
                            border: Border.all(
                              color: isDark
                                  ? scheme.outlineVariant
                                  : AppColors.cardBorder.withValues(alpha: 0.9),
                              width: 1.4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isDark
                                    ? Colors.black.withValues(alpha: 0.26)
                                    : AppColors.primaryDark.withValues(
                                        alpha: 0.12,
                                      ),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              GoldTextField(
                                label: AppLocalizations.of(context)!.tolaLabel,
                                info: AppLocalizations.of(context)!.tolaInfo,
                                controller: tolaController,
                                semanticLabel: AppLocalizations.of(
                                  context,
                                )!.tolaSemanticLabel,
                                validator: _validateInput,
                                onChanged: _calculate,
                                hintText: AppLocalizations.of(
                                  context,
                                )!.tolaHint,
                              ),
                              GoldTextField(
                                label: AppLocalizations.of(context)!.mashaLabel,
                                info: AppLocalizations.of(context)!.mashaInfo,
                                controller: mashaController,
                                semanticLabel: AppLocalizations.of(
                                  context,
                                )!.mashaSemanticLabel,
                                validator: _validateInput,
                                onChanged: _calculate,
                                hintText: AppLocalizations.of(
                                  context,
                                )!.mashaHint,
                              ),
                              GoldTextField(
                                label: AppLocalizations.of(context)!.anaLabel,
                                info: AppLocalizations.of(context)!.anaInfo,
                                controller: anaController,
                                semanticLabel: AppLocalizations.of(
                                  context,
                                )!.anaSemanticLabel,
                                validator: _validateInput,
                                onChanged: _calculate,
                                hintText: AppLocalizations.of(context)!.anaHint,
                              ),
                              GoldTextField(
                                label: AppLocalizations.of(context)!.rattiLabel,
                                info: AppLocalizations.of(context)!.rattiInfo,
                                controller: rattiController,
                                semanticLabel: AppLocalizations.of(
                                  context,
                                )!.rattiSemanticLabel,
                                validator: _validateInput,
                                onChanged: _calculate,
                                hintText: AppLocalizations.of(
                                  context,
                                )!.rattiHint,
                              ),
                              GoldTextField(
                                label: AppLocalizations.of(context)!.gramLabel,
                                info: AppLocalizations.of(context)!.gramInfo,
                                controller: gramController,
                                semanticLabel: AppLocalizations.of(
                                  context,
                                )!.gramSemanticLabel,
                                validator: _validateInput,
                                onChanged: _calculate,
                                hintText: AppLocalizations.of(
                                  context,
                                )!.gramHint,
                              ),
                              Consumer(
                                builder: (context, ref, child) {
                                  final selectedUnit = ref.watch(
                                    rateUnitProvider,
                                  );

                                  return GoldTextField(
                                    label: AppLocalizations.of(
                                      context,
                                    )!.goldRateLabel,
                                    info: AppLocalizations.of(
                                      context,
                                    )!.goldRateInfo,
                                    controller: goldRateController,
                                    semanticLabel: AppLocalizations.of(
                                      context,
                                    )!.goldRateSemanticLabel,
                                    validator: _validateInput,
                                    onChanged: _calculate,
                                    hintText: AppLocalizations.of(
                                      context,
                                    )!.goldRateHint,
                                    hasDropdown: true,
                                    dropdownValue: selectedUnit.name,
                                    dropdownItems: UnitEnum.values
                                        .map<String>((e) => e.name)
                                        .toList(),
                                    onDropdownChanged: (value) {
                                      if (value == null) return;

                                      final UnitEnum newUnit =
                                          UnitEnum.fromString(value);
                                      ref
                                          .read(rateUnitProvider.notifier)
                                          .setRateUnit(newUnit);
                                      _calculate();
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: 10),
                              _buildCalculateAndClearButtons(),
                              Consumer(
                                builder: (context, ref, child) {
                                  final resultText = ref.watch(
                                    goldResultNotifierProvider.select(
                                      (model) => model.weightsText,
                                    ),
                                  );

                                  if (resultText == null ||
                                      resultText.isEmpty) {
                                    return const SizedBox.shrink();
                                  }

                                  return _buildWeightsResultSection(resultText);
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

                                  return _buildPriceResultSection(priceText);
                                },
                              ),
                            ],
                          ),
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

  Widget _buildCalculateAndClearButtons() {
    return Row(
      children: [
        Expanded(
          child: Semantics(
            button: true,
            label: AppLocalizations.of(context)!.calculateSemanticLabel,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [AppColors.primaryDark, AppColors.primary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryDark.withValues(alpha: 0.24),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: calculateAll,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calculate, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.calculateButton,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Semantics(
            button: true,
            label: AppLocalizations.of(context)!.clearAllSemanticLabel,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primaryDark.withValues(alpha: 0.55),
                  width: 1.5,
                ),
                color: AppColors.clearButtonBackground,
              ),
              child: ElevatedButton(
                onPressed: _clearAll,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: AppColors.primaryDark,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.clear_all, size: 20),
                    const SizedBox(width: 8),
                    Flexible(
                      child: FittedBox(
                        child: Text(
                          AppLocalizations.of(context)!.clearAllButton,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _shareableConverterText(String weightsText) {
    final String? priceText = ref.read(goldResultNotifierProvider).priceText;
    if (priceText == null || priceText.isEmpty) return weightsText.trim();
    return '${weightsText.trim()}\n\n${priceText.trim()}';
  }

  Widget _buildWeightsResultSection(String resultText) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: isDark
              ? [scheme.surfaceContainerHigh, scheme.surfaceContainer]
              : [AppColors.resultCardStart, AppColors.resultCardEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: isDark
              ? scheme.outlineVariant
              : AppColors.cardBorder.withValues(alpha: 0.9),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.18)
                : AppColors.primaryDark.withValues(alpha: 0.11),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics_outlined,
                color: AppColors.primaryDark,
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.conversionDetails,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurface,
                  ),
                ),
              ),
              ResultActions(
                text: _shareableConverterText(resultText),
                screen: 'converter',
              ),
            ],
          ),
          const SizedBox(height: 12),
          SelectableText(
            resultText,
            style: TextStyle(
              fontSize: 14,
              color: scheme.onSurface,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceResultSection(String priceText) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: isDark
              ? [
                  scheme.primaryContainer.withValues(alpha: 0.62),
                  scheme.surfaceContainerHigh,
                ]
              : [AppColors.priceCardStart, AppColors.priceCardEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: isDark
              ? scheme.outlineVariant
              : AppColors.primaryDark.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.22)
                : AppColors.primaryDark.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.monetization_on,
            color: AppColors.goldDeep,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              priceText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
