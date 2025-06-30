import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static final NumberFormat _formatter = NumberFormat('#,##0.####');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If the new value is empty, return it as is
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove all non-digit and non-decimal characters except the first decimal point
    String cleanText = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');
    
    // Handle multiple decimal points - keep only the first one
    List<String> parts = cleanText.split('.');
    if (parts.length > 2) {
      cleanText = '${parts[0]}.${parts.sublist(1).join('')}';
    }

    // Parse the clean text to double
    double? value = double.tryParse(cleanText);
    if (value == null && cleanText != '.') {
      return oldValue;
    }

    // Format the number with thousand separators
    String formattedText;
    if (cleanText.endsWith('.')) {
      // If user is typing a decimal point, preserve it
      String integerPart = cleanText.substring(0, cleanText.length - 1);
      double? intValue = double.tryParse(integerPart);
      if (intValue != null) {
        String formatted = NumberFormat('#,##0').format(intValue);
        formattedText = '$formatted.';
      } else {
        formattedText = '0.';
      }
    } else if (value != null) {
      formattedText = _formatter.format(value);
    } else {
      formattedText = cleanText;
    }

    // Calculate the new cursor position
    int newCursorPosition = _calculateCursorPosition(
      oldValue.text,
      newValue.text,
      formattedText,
      newValue.selection.baseOffset,
    );

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: newCursorPosition),
    );
  }

  int _calculateCursorPosition(
    String oldText,
    String newText,
    String formattedText,
    int originalCursor,
  ) {
    // If the formatted text is shorter than the cursor position, put cursor at end
    if (originalCursor > formattedText.length) {
      return formattedText.length;
    }

    // Count commas before the cursor in the old and new text
    int oldCommas = _countCommasBefore(oldText, originalCursor);
    int newCommas = _countCommasBefore(formattedText, originalCursor);
    
    // Adjust cursor position based on comma difference
    int adjustment = newCommas - oldCommas;
    int newPosition = originalCursor + adjustment;

    // Ensure cursor is within bounds
    return newPosition.clamp(0, formattedText.length);
  }

  int _countCommasBefore(String text, int position) {
    if (position > text.length) position = text.length;
    return text.substring(0, position).split(',').length - 1;
  }
}

class NumberHelper {
  static final NumberFormat _formatter = NumberFormat('#,##0.####');
  
  /// Formats a number with thousand separators
  static String formatNumber(double number) {
    return _formatter.format(number);
  }
  
  /// Removes formatting and returns clean number string
  static String cleanNumber(String formattedNumber) {
    return formattedNumber.replaceAll(',', '');
  }
  
  /// Parses a formatted number string to double
  static double? parseFormattedNumber(String formattedNumber) {
    String clean = cleanNumber(formattedNumber);
    return double.tryParse(clean);
  }
}