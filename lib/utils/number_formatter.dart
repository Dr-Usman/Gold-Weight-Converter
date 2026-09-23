import 'dart:math';
import 'package:flutter/services.dart';

/// A robust, high-performance [TextInputFormatter] that formats numeric input
/// with thousands separators (commas) while preserving full decimal precision,
/// trailing zeros after decimal points (e.g., `0.0`, `2.00`), and accurate caret positioning.
class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  /// Maximum allowed digits in the integer part (default: 12).
  final int maxIntegerDigits;

  /// Maximum allowed digits in the fractional part (default: 5).
  final int maxFractionDigits;

  const ThousandsSeparatorInputFormatter({
    this.maxIntegerDigits = 12,
    this.maxFractionDigits = 5,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 1. If the input is completely cleared, return empty immediately.
    if (newValue.text.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // 2. Handle backspacing over a comma separator.
    // When the user hits Backspace while the caret is directly after a comma
    // (e.g. in "1,|234" pressing backspace yields "1|234"), their intent was
    // to delete the digit preceding the comma ('1').
    String rawText = newValue.text;
    int rawCursor = newValue.selection.baseOffset;
    bool isBackspaceOverComma = false;

    if (oldValue.text.length - newValue.text.length == 1 &&
        oldValue.selection.isCollapsed &&
        newValue.selection.isCollapsed &&
        newValue.selection.baseOffset >= 0 &&
        newValue.selection.baseOffset < oldValue.text.length &&
        oldValue.text[newValue.selection.baseOffset] == ',') {
      isBackspaceOverComma = true;
      final int commaIndex = newValue.selection.baseOffset;
      if (commaIndex > 0) {
        // Delete the digit before the comma
        rawText = rawText.substring(0, commaIndex - 1) +
            rawText.substring(commaIndex);
        rawCursor = commaIndex - 1;
      }
    }

    if (rawText.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // 3. Filter characters: keep only digits and the first decimal point.
    // Also track how many "significant" characters precede the caret in rawText.
    final StringBuffer sanitizedBuffer = StringBuffer();
    bool hasDot = false;
    int sigCharsBeforeCursor = 0;
    final int safeRawCursor = rawCursor.clamp(0, rawText.length);

    for (int i = 0; i < rawText.length; i++) {
      final String char = rawText[i];
      final bool isDigit = char.codeUnitAt(0) >= 48 && char.codeUnitAt(0) <= 57;
      final bool isFirstDot = char == '.' && !hasDot;

      if (isDigit || isFirstDot) {
        if (isFirstDot) {
          hasDot = true;
        }
        sanitizedBuffer.write(char);
        if (i < safeRawCursor) {
          sigCharsBeforeCursor++;
        }
      }
    }

    String cleanText = sanitizedBuffer.toString();

    // If no valid digits or dot were found (e.g. user typed letters or '-'), reject.
    if (cleanText.isEmpty) {
      return oldValue.text.isEmpty
          ? const TextEditingValue(
              text: '',
              selection: TextSelection.collapsed(offset: 0),
            )
          : oldValue;
    }

    // 4. Handle leading decimal point: e.g. "." -> "0.", ".5" -> "0.5".
    if (cleanText.startsWith('.')) {
      cleanText = '0$cleanText';
      sigCharsBeforeCursor++;
    }

    // 5. Separate integer and fractional parts.
    final int dotIndex = cleanText.indexOf('.');
    String intPart = dotIndex != -1 ? cleanText.substring(0, dotIndex) : cleanText;
    String? fracPart = dotIndex != -1 ? cleanText.substring(dotIndex + 1) : null;

    // 6. Normalize leading zeros in integer part.
    // - "00" or "000" -> "0"
    // - "05" or "007" -> "5" or "7" (strip leading zeros before non-zero digits)
    if (intPart.length > 1 && intPart.startsWith('0')) {
      final String nonZeroPart = intPart.replaceFirst(RegExp(r'^0+'), '');
      if (nonZeroPart.isEmpty) {
        // Was all zeros (e.g., "00", "000") -> collapse to single "0"
        final int stripped = intPart.length - 1;
        intPart = '0';
        sigCharsBeforeCursor = max(0, sigCharsBeforeCursor - stripped);
      } else {
        // Was "05" or "007" -> strip leading zeros
        final int stripped = intPart.length - nonZeroPart.length;
        intPart = nonZeroPart;
        sigCharsBeforeCursor = max(0, sigCharsBeforeCursor - stripped);
      }
    }

    // 7. Enforce digit limits (maxIntegerDigits and maxFractionDigits).
    // If user typed an extra digit exceeding limits, reject and retain oldValue.
    final bool isSingleCharAddition =
        newValue.text.length - oldValue.text.length == 1;

    if (intPart.length > maxIntegerDigits) {
      if (isSingleCharAddition && oldValue.text.isNotEmpty) {
        return oldValue;
      }
      intPart = intPart.substring(0, maxIntegerDigits);
    }

    if (fracPart != null && fracPart.length > maxFractionDigits) {
      if (isSingleCharAddition && oldValue.text.isNotEmpty) {
        return oldValue;
      }
      fracPart = fracPart.substring(0, maxFractionDigits);
    }

    // 8. Format integer part with thousands separators (commas).
    final String formattedInt = _formatThousands(intPart);

    // 9. Reassemble the formatted number without modifying fractional precision.
    final String formattedText =
        fracPart != null ? '$formattedInt.$fracPart' : formattedInt;

    // 10. Calculate caret position.
    // If user was at the very end of input, place caret at the end of formatted output.
    final bool isAtEnd =
        safeRawCursor >= rawText.length || cleanText.length <= 1;

    int newCursor;
    if (isAtEnd && !isBackspaceOverComma) {
      newCursor = formattedText.length;
    } else {
      newCursor = _calculateCursorPosition(
        formattedText: formattedText,
        targetSigChars: sigCharsBeforeCursor,
        isInsertion: newValue.text.length > oldValue.text.length,
      );
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: newCursor.clamp(0, formattedText.length),
      ),
    );
  }

  /// Groups digits with thousands separators from right to left.
  static String _formatThousands(String digits) {
    if (digits.length <= 3) return digits;

    final StringBuffer buffer = StringBuffer();
    final int remainder = digits.length % 3;

    if (remainder > 0) {
      buffer.write(digits.substring(0, remainder));
    }

    for (int i = remainder; i < digits.length; i += 3) {
      if (buffer.isNotEmpty) {
        buffer.write(',');
      }
      buffer.write(digits.substring(i, i + 3));
    }

    return buffer.toString();
  }

  /// Calculates the new caret position in [formattedText] based on the number
  /// of significant characters (digits + first decimal point) that should precede it.
  static int _calculateCursorPosition({
    required String formattedText,
    required int targetSigChars,
    required bool isInsertion,
  }) {
    if (targetSigChars <= 0) return 0;

    int cursor = 0;
    int sigCount = 0;

    while (cursor < formattedText.length && sigCount < targetSigChars) {
      final String char = formattedText[cursor];
      if ((char.codeUnitAt(0) >= 48 && char.codeUnitAt(0) <= 57) ||
          char == '.') {
        sigCount++;
      }
      cursor++;
    }

    // If typing/inserting and cursor lands right before a comma, advance past the comma.
    if (isInsertion &&
        cursor < formattedText.length &&
        formattedText[cursor] == ',') {
      cursor++;
    }

    return cursor;
  }
}
