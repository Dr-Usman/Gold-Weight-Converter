import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'utils/number_formatter.dart';
import 'widgets/gold_text_field.dart';

class GoldConverterScreen extends StatefulWidget {
  const GoldConverterScreen({super.key});

  @override
  State<GoldConverterScreen> createState() => _GoldConverterScreenState();
}

class _GoldConverterScreenState extends State<GoldConverterScreen> {
  final TextEditingController tolaController = TextEditingController();
  final TextEditingController mashaController = TextEditingController();
  final TextEditingController anaController = TextEditingController();
  final TextEditingController rattiController = TextEditingController();
  final TextEditingController gramController = TextEditingController();
  final TextEditingController goldRateController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  String goldRateUnit = 'Tola';
  String resultText = '';
  String priceText = '';

  final double tolaToGram = 11.66;
  final double mashaToGram = 0.972;
  final double anaToGram = 0.72875;
  final double rattiToGram = 0.1215;

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
    setState(() {
      resultText = '';
      priceText = '';
    });
  }

  double _getDouble(TextEditingController controller) {
    double? value = NumberHelper.parseFormattedNumber(controller.text.trim());
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

  // Private method for calculations without unfocusing (used by onChanged)
  void _calculate() {
    final tola = _getDouble(tolaController);
    final masha = _getDouble(mashaController);
    final ana = _getDouble(anaController);
    final ratti = _getDouble(rattiController);
    final gram = _getDouble(gramController);

    if (tola == 0 && masha == 0 && ana == 0 && ratti == 0 && gram == 0) {
      setState(() {
        resultText = '';
        priceText = '';
      });
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
    String newPriceText = '';

    double rate = _getDouble(goldRateController);
    if (rate > 0) {
      double gramRate =
          (goldRateUnit == 'Tola')
              ? (rate / tolaToGram)
              : (goldRateUnit == '10 Gram')
              ? (rate / 10)
              : rate;
      double price = totalGrams * gramRate;

      final priceFormatted = currencyFormat.format(price);

      newPriceText =
          'Gold Price: $priceFormatted\n(Rate: ${currencyFormat.format(rate)} per $goldRateUnit)';
    }

    if (resultText != newResultText || priceText != newPriceText) {
      setState(() {
        resultText = newResultText;
        priceText = newPriceText;
      });
    }
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
        title: const Text(
          'Gold Weight Converter',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber[600],
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.amber[400]!,
                Colors.amber[600]!,
                Colors.amber[800]!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[50],
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber[50]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              GoldTextField(
                label: 'Tola',
                info: '1 Tola = 11.66 grams = 12 Masha = 16 Ana = 96 Ratti',
                controller: tolaController,
                semanticLabel: 'Tola weight input field',
                validator: _validateInput,
                onChanged: _calculate,
                hintText: 'e.g. 2.5',
              ),
              GoldTextField(
                label: 'Masha',
                info: '1 Masha = 0.972 grams = 1.333 Ana = 8 Ratti',
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
              GoldTextField(
                label: 'Gold Rate',
                info: 'Current market rate per unit',
                controller: goldRateController,
                semanticLabel: 'Gold rate input field',
                validator: _validateInput,
                onChanged: _calculate,
                hintText: 'e.g. 150,000',
                hasDropdown: true,
                dropdownValue: goldRateUnit,
                dropdownItems: const ['Tola', '10 Gram', '1 Gram'],
                onDropdownChanged: (value) {
                  setState(() {
                    goldRateUnit = value!;
                  });
                  _calculate();
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Semantics(
                      button: true,
                      label: 'Calculate gold weight conversion',
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [Colors.amber[400]!, Colors.amber[600]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.withValues(alpha: 0.3),
                              blurRadius: 8,
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
                            color: Colors.red[300]!,
                            width: 1.5,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: _clearAll,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.red[600],
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
              ),
              if (resultText.isNotEmpty) ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [Colors.amber[50]!, Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(color: Colors.amber[200]!, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withValues(alpha: 0.1),
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
                            color: Colors.amber[700],
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Conversion Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber[800],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SelectableText(
                        resultText,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (priceText.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [Colors.green[50]!, Colors.green[100]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(color: Colors.green[300]!, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.monetization_on,
                        color: Colors.green[700],
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          priceText,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
