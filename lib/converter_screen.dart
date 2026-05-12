import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gold_weight_converter/constants/app_colors.dart';
import 'package:gold_weight_converter/constants/unit_enum.dart';
import 'package:gold_weight_converter/providers/unit_provider.dart';
import 'package:gold_weight_converter/providers/weight_provider.dart';
import 'package:gold_weight_converter/utils/number_helper.dart';
import 'package:intl/intl.dart';

import 'widgets/gold_text_field.dart';

class GoldConverterScreen extends ConsumerStatefulWidget {
  const GoldConverterScreen({super.key});

  @override
  ConsumerState<GoldConverterScreen> createState() =>
      _GoldConverterScreenState();
}

class _GoldConverterScreenState extends ConsumerState<GoldConverterScreen> {
  final TextEditingController tolaController = TextEditingController();
  final TextEditingController mashaController = TextEditingController();
  final TextEditingController anaController = TextEditingController();
  final TextEditingController rattiController = TextEditingController();
  final TextEditingController gramController = TextEditingController();
  final TextEditingController goldRateController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // String goldRateUnit = 'Tola'; // Unused - now using State Provider
  // String resultText = ''; // Unused - now using Notifier Provider
  // String priceText = ''; // Unused - now using Notifier Provider

  static const double tolaToGram = 11.66;
  static const double mashaToGram = 0.972;
  static const double anaToGram = 0.72875;
  static const double rattiToGram = 0.1215;

  final currencyFormat = NumberFormat.currency(
    locale: 'en_PK',
    symbol: 'Rs. ',
    decimalDigits: 2,
  );

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
      return 'Please enter a valid number';
    }
    if (number < 0) {
      return 'Please enter a positive number';
    }
    return null;
  }

  // Private method for calculations without Unfocus (used by onChanged)
  void _calculate() {
    final double tola = _getDouble(tolaController);
    final double masha = _getDouble(mashaController);
    final double ana = _getDouble(anaController);
    final double ratti = _getDouble(rattiController);
    final double gram = _getDouble(gramController);

    if (tola == 0 && masha == 0 && ana == 0 && ratti == 0 && gram == 0) {
      ref.read(goldResultNotifierProvider.notifier).clearResults();

      // setState(() {
      //   resultText = '';
      //   priceText = '';
      // });
      return;
    }

    double totalGrams = 0;
    StringBuffer resultBuffer = StringBuffer();

    if (tola > 0) {
      totalGrams += tola * tolaToGram;
      resultBuffer.writeln(
        'Tola: $tola × $tolaToGram = ${(tola * tolaToGram).toStringAsFixed(4)} grams',
      );
    }
    if (masha > 0) {
      totalGrams += masha * mashaToGram;
      resultBuffer.writeln(
        'Masha: $masha × $mashaToGram = ${(masha * mashaToGram).toStringAsFixed(4)} grams',
      );
    }
    if (ana > 0) {
      totalGrams += ana * anaToGram;
      resultBuffer.writeln(
        'Ana: $ana × $anaToGram = ${(ana * anaToGram).toStringAsFixed(4)} grams',
      );
    }
    if (ratti > 0) {
      totalGrams += ratti * rattiToGram;
      resultBuffer.writeln(
        'Ratti: $ratti × $rattiToGram = ${(ratti * rattiToGram).toStringAsFixed(4)} grams',
      );
    }
    if (gram > 0) {
      totalGrams += gram;
      resultBuffer.writeln('Gram: $gram grams');
    }

    resultBuffer.writeln(
      '\nTotal Weight: ${totalGrams.toStringAsFixed(4)} grams',
    );

    double tolaResult = totalGrams / tolaToGram;
    double mashaResult = totalGrams / mashaToGram;
    double anaResult = totalGrams / anaToGram;
    double rattiResult = totalGrams / rattiToGram;

    resultBuffer.writeln('\nConverted to:');
    resultBuffer.writeln('Tola: ${tolaResult.toStringAsFixed(4)}');
    resultBuffer.writeln('Masha: ${mashaResult.toStringAsFixed(4)}');
    resultBuffer.writeln('Ana: ${anaResult.toStringAsFixed(4)}');
    resultBuffer.writeln('Ratti: ${rattiResult.toStringAsFixed(4)}');

    String newResultText = resultBuffer.toString();
    String? newPriceText;

    double rate = _getDouble(goldRateController);
    if (rate > 0) {
      final goldRateUnit = ref.read(rateUnitProvider);
      double gramRate = rate;
      if ((goldRateUnit == UnitEnum.tola)) {
        gramRate = (rate / tolaToGram);
      } else if ((goldRateUnit == UnitEnum.tenGram)) {
        gramRate = (rate / 10);
      } else {
        gramRate = rate;
      }
      double price = totalGrams * gramRate;

      final priceFormatted = currencyFormat.format(price);

      newPriceText =
          'Gold Price: $priceFormatted '
          '\n(Rate: ${currencyFormat.format(rate)} per ${goldRateUnit.name})';
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
    _calculate();

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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: const Text(
          'Gold Weight Converter',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 21,
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
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
                            color: Colors.white.withValues(alpha: 0.95),
                            border: Border.all(
                              color: AppColors.cardBorder.withValues(
                                alpha: 0.9,
                              ),
                              width: 1.4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryDark.withValues(
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
                                label: 'Tola',
                                info:
                                    '1 Tola = 11.66 grams = 12 Masha = 16 Ana = 96 Ratti',
                                controller: tolaController,
                                semanticLabel: 'Tola weight input field',
                                validator: _validateInput,
                                onChanged: _calculate,
                                hintText: 'e.g. 2.5',
                              ),
                              GoldTextField(
                                label: 'Masha',
                                info:
                                    '1 Masha = 0.972 grams = 1.333 Ana = 8 Ratti',
                                controller: mashaController,
                                semanticLabel: 'Masha weight input field',
                                validator: _validateInput,
                                onChanged: _calculate,
                                hintText: 'e.g. 12.5',
                              ),
                              GoldTextField(
                                label: 'Ana',
                                info: '1 Ana = 0.72875 grams = 6 Ratti',
                                controller: anaController,
                                semanticLabel: 'Ana weight input field',
                                validator: _validateInput,
                                onChanged: _calculate,
                                hintText: 'e.g. 16.25',
                              ),
                              GoldTextField(
                                label: 'Ratti',
                                info: '1 Ratti = 0.1215 grams',
                                controller: rattiController,
                                semanticLabel: 'Ratti weight input field',
                                validator: _validateInput,
                                onChanged: _calculate,
                                hintText: 'e.g. 96.75',
                              ),
                              GoldTextField(
                                label: 'Gram',
                                info: 'Direct gram input',
                                controller: gramController,
                                semanticLabel: 'Gram weight input field',
                                validator: _validateInput,
                                onChanged: _calculate,
                                hintText: 'e.g. 11.66',
                              ),
                              Consumer(
                                builder: (context, ref, child) {
                                  final selectedUnit = ref.watch(
                                    rateUnitProvider,
                                  );

                                  return GoldTextField(
                                    label: 'Gold Rate',
                                    info: 'Current market rate per unit',
                                    controller: goldRateController,
                                    semanticLabel: 'Gold rate input field',
                                    validator: _validateInput,
                                    onChanged: _calculate,
                                    hintText: 'e.g. 150,000',
                                    hasDropdown: true,
                                    dropdownValue: selectedUnit.name,
                                    dropdownItems:
                                        UnitEnum.values
                                            .map<String>((e) => e.name)
                                            .toList(),
                                    onDropdownChanged: (value) {
                                      if (value == null) return;

                                      final UnitEnum newUnit =
                                          UnitEnum.fromString(value);
                                      ref
                                          .read(rateUnitProvider.notifier)
                                          .state = newUnit;
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
            label: 'Calculate gold weight conversion',
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calculate, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Calculate',
                      style: TextStyle(
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
            label: 'Clear all input fields',
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.clear_all, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Clear All',
                      style: TextStyle(
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
      ],
    );
  }

  Widget _buildWeightsResultSection(String resultText) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [AppColors.resultCardStart, AppColors.resultCardEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: AppColors.cardBorder.withValues(alpha: 0.9),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.11),
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
              Text(
                'Conversion Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.ink,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SelectableText(
            resultText,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.ink,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceResultSection(String priceText) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [AppColors.priceCardStart, AppColors.priceCardEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: AppColors.primaryDark.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.2),
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
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
