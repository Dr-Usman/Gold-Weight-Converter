import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() => runApp(GoldConverterApp());

class GoldConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gold Weight Converter',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 18),
        ),
      ),
      home: GoldConverterScreen(),
    );
  }
}

class GoldConverterScreen extends StatefulWidget {
  @override
  _GoldConverterScreenState createState() => _GoldConverterScreenState();
}

class _GoldConverterScreenState extends State<GoldConverterScreen> {
  final TextEditingController tolaController = TextEditingController();
  final TextEditingController mashaController = TextEditingController();
  final TextEditingController anaController = TextEditingController();
  final TextEditingController rattiController = TextEditingController();
  final TextEditingController gramController = TextEditingController();
  final TextEditingController goldRateController = TextEditingController();

  String goldRateUnit = 'Tola';
  String resultText = '';
  String priceText = '';

  final double tolaToGram = 11.66;
  final double mashaToGram = 0.972;
  final double anaToGram = 0.72875;
  final double rattiToGram = 0.1215;

  void clearAll() {
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

  double getDouble(TextEditingController controller) {
    String text = controller.text.replaceAll(',', '');
    return double.tryParse(text.trim()) ?? 0.0;
  }

  void calculateAll() {
    final tola = getDouble(tolaController);
    final masha = getDouble(mashaController);
    final ana = getDouble(anaController);
    final ratti = getDouble(rattiController);
    final gram = getDouble(gramController);

    double totalGrams = 0;
    String result = '';

    if (tola > 0) {
      totalGrams += tola * tolaToGram;
      result +=
          'Tola: $tola × $tolaToGram = ${(tola * tolaToGram).toStringAsFixed(4)} grams\n';
    }
    if (masha > 0) {
      totalGrams += masha * mashaToGram;
      result +=
          'Masha: $masha × $mashaToGram = ${(masha * mashaToGram).toStringAsFixed(4)} grams\n';
    }
    if (ana > 0) {
      totalGrams += ana * anaToGram;
      result +=
          'Ana: $ana × $anaToGram = ${(ana * anaToGram).toStringAsFixed(4)} grams\n';
    }
    if (ratti > 0) {
      totalGrams += ratti * rattiToGram;
      result +=
          'Ratti: $ratti × $rattiToGram = ${(ratti * rattiToGram).toStringAsFixed(4)} grams\n';
    }
    if (gram > 0) {
      totalGrams += gram;
      result += 'Gram: $gram grams\n';
    }

    result += '\nTotal Weight: ${totalGrams.toStringAsFixed(4)} grams\n';

    double tolaResult = totalGrams / tolaToGram;
    double mashaResult = totalGrams / mashaToGram;
    double anaResult = totalGrams / anaToGram;
    double rattiResult = totalGrams / rattiToGram;

    result += '\nConverted to:\n';
    result += 'Tola: ${tolaResult.toStringAsFixed(4)}\n';
    result += 'Masha: ${mashaResult.toStringAsFixed(4)}\n';
    result += 'Ana: ${anaResult.toStringAsFixed(4)}\n';
    result += 'Ratti: ${rattiResult.toStringAsFixed(4)}\n';

    double rate = getDouble(goldRateController);
    if (rate > 0) {
      double gramRate =
          (goldRateUnit == 'Tola')
              ? (rate / tolaToGram)
              : (goldRateUnit == '10 Gram')
              ? (rate / 10)
              : rate;
      double price = totalGrams * gramRate;

      final priceFormatted = NumberFormat.currency(
        locale: 'en_PK',
        symbol: 'Rs. ',
        decimalDigits: 2,
      ).format(price);

      priceText =
          'Gold Price: $priceFormatted (at Rs. ${rate.toStringAsFixed(2)} per $goldRateUnit)';
    } else {
      priceText = '';
    }

    setState(() {
      resultText = result;
    });
  }

  Widget buildInput(
    String label,
    TextEditingController controller,
    String info,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(info, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          SizedBox(height: 6),
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.numberWithOptions(decimal: true),

            decoration: InputDecoration(
              hintText: 'Enter $label value',
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPriceInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Gold Rate', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: goldRateController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: 'e.g. 150000',
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
              ),
              SizedBox(width: 12),
              DropdownButton<String>(
                value: goldRateUnit,
                items:
                    ['Tola', '10 Gram', '1 Gram']
                        .map(
                          (unit) => DropdownMenuItem<String>(
                            value: unit,
                            child: Text(unit),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    goldRateUnit = value!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gold Weight Converter'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildInput(
              'Tola',
              tolaController,
              '1 Tola = 11.66 grams = 12 Masha = 96 Ratti = 16 Ana',
            ),
            buildInput(
              'Masha',
              mashaController,
              '1 Masha = 0.972 grams = 8 Ratti',
            ),
            buildInput('Ana', anaController, '1 Ana = 0.72875 grams'),
            buildInput('Ratti', rattiController, '1 Ratti = 0.1215 grams'),
            buildInput('Gram', gramController, 'Direct gram input'),
            buildPriceInput(),
            ElevatedButton(
              onPressed: calculateAll,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text('Calculate', style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: clearAll,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text('Clear All', style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 16),
            if (resultText.isNotEmpty) ...[
              Text(
                'Conversion Details:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),
              SelectableText(
                resultText,
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
            if (priceText.isNotEmpty) ...[
              SizedBox(height: 16),
              Text(
                priceText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
