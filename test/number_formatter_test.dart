import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gold_weight_converter/utils/number_formatter.dart';

void main() {
  const formatter = ThousandsSeparatorInputFormatter();

  /// Helper to simulate updating from [oldText] (with cursor at [oldOffset])
  /// to [newText] (with cursor at [newOffset]).
  TextEditingValue format({
    required String oldText,
    required int oldOffset,
    required String newText,
    required int newOffset,
  }) {
    return formatter.formatEditUpdate(
      TextEditingValue(
        text: oldText,
        selection: TextSelection.collapsed(offset: oldOffset),
      ),
      TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newOffset),
      ),
    );
  }

  /// Helper to simulate sequential typing of characters from empty field.
  TextEditingValue typeSequence(String input) {
    TextEditingValue current = TextEditingValue.empty;
    for (int i = 0; i < input.length; i++) {
      final char = input[i];
      final newText = current.text + char;
      current = formatter.formatEditUpdate(
        current,
        TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        ),
      );
    }
    return current;
  }

  group('Category 1: Zero & Leading Zero Edge Cases', () {
    test('1. Type 0 -> "0", End (1)', () {
      final result = format(oldText: '', oldOffset: 0, newText: '0', newOffset: 1);
      expect(result.text, '0');
      expect(result.selection.baseOffset, 1);
    });

    test('2. Type 0 then 0 -> "0", End (1)', () {
      final step1 = format(oldText: '', oldOffset: 0, newText: '0', newOffset: 1);
      final step2 = format(oldText: step1.text, oldOffset: 1, newText: '00', newOffset: 2);
      expect(step2.text, '0');
      expect(step2.selection.baseOffset, 1);
    });

    test('3. Type 0 then 0 then 0 -> "0", End (1)', () {
      final result = typeSequence('000');
      expect(result.text, '0');
      expect(result.selection.baseOffset, 1);
    });

    test('4. Type 0 then 5 -> "5", End (1)', () {
      final step1 = format(oldText: '', oldOffset: 0, newText: '0', newOffset: 1);
      final step2 = format(oldText: step1.text, oldOffset: 1, newText: '05', newOffset: 2);
      expect(step2.text, '5');
      expect(step2.selection.baseOffset, 1);
    });

    test('5. Type 0 then 0 then 7 -> "7", End (1)', () {
      final result = typeSequence('007');
      expect(result.text, '7');
      expect(result.selection.baseOffset, 1);
    });

    test('6. Type 0 then . -> "0.", End (2)', () {
      final step1 = format(oldText: '', oldOffset: 0, newText: '0', newOffset: 1);
      final step2 = format(oldText: step1.text, oldOffset: 1, newText: '0.', newOffset: 2);
      expect(step2.text, '0.');
      expect(step2.selection.baseOffset, 2);
    });

    test('7. Type . directly on empty field -> "0.", End (2)', () {
      final result = format(oldText: '', oldOffset: 0, newText: '.', newOffset: 1);
      expect(result.text, '0.');
      expect(result.selection.baseOffset, 2);
    });

    test('8. Type . then 5 on empty field -> "0.5", End (3)', () {
      final step1 = format(oldText: '', oldOffset: 0, newText: '.', newOffset: 1);
      final step2 = format(oldText: step1.text, oldOffset: 2, newText: '0.5', newOffset: 3);
      expect(step2.text, '0.5');
      expect(step2.selection.baseOffset, 3);
    });

    test('9. Type . then 0 on empty field -> "0.0", End (3)', () {
      final step1 = format(oldText: '', oldOffset: 0, newText: '.', newOffset: 1);
      final step2 = format(oldText: step1.text, oldOffset: 2, newText: '0.0', newOffset: 3);
      expect(step2.text, '0.0');
      expect(step2.selection.baseOffset, 3);
    });
  });

  group('Category 2: Decimal Entry & Trailing Zero Preservation', () {
    test('10. In "0.", type 0 -> "0.0", End (3)', () {
      final result = format(oldText: '0.', oldOffset: 2, newText: '0.0', newOffset: 3);
      expect(result.text, '0.0');
      expect(result.selection.baseOffset, 3);
    });

    test('11. In "0.0", type 0 -> "0.00", End (4)', () {
      final result = format(oldText: '0.0', oldOffset: 3, newText: '0.00', newOffset: 4);
      expect(result.text, '0.00');
      expect(result.selection.baseOffset, 4);
    });

    test('12. In "0.00", type 0 -> "0.000", End (5)', () {
      final result = format(oldText: '0.00', oldOffset: 4, newText: '0.000', newOffset: 5);
      expect(result.text, '0.000');
      expect(result.selection.baseOffset, 5);
    });

    test('13. In "0.00", type 5 -> "0.005", End (5)', () {
      final result = format(oldText: '0.00', oldOffset: 4, newText: '0.005', newOffset: 5);
      expect(result.text, '0.005');
      expect(result.selection.baseOffset, 5);
    });

    test('14. In "2.", type 0 -> "2.0", End (3)', () {
      final result = format(oldText: '2.', oldOffset: 2, newText: '2.0', newOffset: 3);
      expect(result.text, '2.0');
      expect(result.selection.baseOffset, 3);
    });

    test('15. In "2.0", type 0 -> "2.00", End (4)', () {
      final result = format(oldText: '2.0', oldOffset: 3, newText: '2.00', newOffset: 4);
      expect(result.text, '2.00');
      expect(result.selection.baseOffset, 4);
    });

    test('16. In "2.0", type 5 -> "2.05", End (4)', () {
      final result = format(oldText: '2.0', oldOffset: 3, newText: '2.05', newOffset: 4);
      expect(result.text, '2.05');
      expect(result.selection.baseOffset, 4);
    });

    test('17. In "100.", type 0 -> "100.0", End (5)', () {
      final result = format(oldText: '100.', oldOffset: 4, newText: '100.0', newOffset: 5);
      expect(result.text, '100.0');
      expect(result.selection.baseOffset, 5);
    });

    test('18. In "100.0", type 0 -> "100.00", End (6)', () {
      final result = format(oldText: '100.0', oldOffset: 5, newText: '100.00', newOffset: 6);
      expect(result.text, '100.00');
      expect(result.selection.baseOffset, 6);
    });
  });

  group('Category 3: Intermediate Zeros & Gold-Specific Units', () {
    test('19. Type 3.5005 -> "3.5005", End (6)', () {
      final result = typeSequence('3.5005');
      expect(result.text, '3.5005');
      expect(result.selection.baseOffset, 6);
    });

    test('20. Type 0.72875 (1 Ana in grams) -> "0.72875", End (7)', () {
      final result = typeSequence('0.72875');
      expect(result.text, '0.72875');
      expect(result.selection.baseOffset, 7);
    });

    test('21. Type 0.1166 (1 Lal in grams) -> "0.1166", End (6)', () {
      final result = typeSequence('0.1166');
      expect(result.text, '0.1166');
      expect(result.selection.baseOffset, 6);
    });

    test('22. Type 0.1215 (1 Ratti in grams) -> "0.1215", End (6)', () {
      final result = typeSequence('0.1215');
      expect(result.text, '0.1215');
      expect(result.selection.baseOffset, 6);
    });

    test('23. Type 0.972 (1 Masha in grams) -> "0.972", End (5)', () {
      final result = typeSequence('0.972');
      expect(result.text, '0.972');
      expect(result.selection.baseOffset, 5);
    });

    test('24. Type 11.66 (1 Tola in grams) -> "11.66", End (5)', () {
      final result = typeSequence('11.66');
      expect(result.text, '11.66');
      expect(result.selection.baseOffset, 5);
    });

    test('25. Type 10.08 -> "10.08", End (5)', () {
      final result = typeSequence('10.08');
      expect(result.text, '10.08');
      expect(result.selection.baseOffset, 5);
    });

    test('26. Type 1,250.0001 -> "1,250.0001", End (10)', () {
      final result = typeSequence('1250.0001');
      expect(result.text, '1,250.0001');
      expect(result.selection.baseOffset, 10);
    });
  });

  group('Category 4: Thousands Separator Progression (Grouping)', () {
    test('27. Type 999 -> "999", End (3)', () {
      final result = typeSequence('999');
      expect(result.text, '999');
      expect(result.selection.baseOffset, 3);
    });

    test('28. In "999", type 1 -> "9,991", End (5)', () {
      final result = format(oldText: '999', oldOffset: 3, newText: '9991', newOffset: 4);
      expect(result.text, '9,991');
      expect(result.selection.baseOffset, 5);
    });

    test('29. In "9,991", type 2 -> "99,912", End (6)', () {
      final result = format(oldText: '9,991', oldOffset: 5, newText: '9,9912', newOffset: 6);
      expect(result.text, '99,912');
      expect(result.selection.baseOffset, 6);
    });

    test('30. In "99,912", type 3 -> "999,123", End (7)', () {
      final result = format(oldText: '99,912', oldOffset: 6, newText: '99,9123', newOffset: 7);
      expect(result.text, '999,123');
      expect(result.selection.baseOffset, 7);
    });

    test('31. In "999,123", type 4 -> "9,991,234", End (9)', () {
      final result = format(oldText: '999,123', oldOffset: 7, newText: '999,1234', newOffset: 8);
      expect(result.text, '9,991,234');
      expect(result.selection.baseOffset, 9);
    });

    test('32. Type 150000 -> "150,000", End (7)', () {
      final result = typeSequence('150000');
      expect(result.text, '150,000');
      expect(result.selection.baseOffset, 7);
    });

    test('33. Type 2500000 -> "2,500,000", End (9)', () {
      final result = typeSequence('2500000');
      expect(result.text, '2,500,000');
      expect(result.selection.baseOffset, 9);
    });

    test('34. Type 1000000.5 -> "1,000,000.5", End (11)', () {
      final result = typeSequence('1000000.5');
      expect(result.text, '1,000,000.5');
      expect(result.selection.baseOffset, 11);
    });
  });

  group('Category 5: Multiple Decimal Points & Malformed Inputs', () {
    test('35. Type . then . (..) -> "0.", End (2)', () {
      final step1 = format(oldText: '', oldOffset: 0, newText: '.', newOffset: 1);
      final step2 = format(oldText: step1.text, oldOffset: 2, newText: '0..', newOffset: 3);
      expect(step2.text, '0.');
      expect(step2.selection.baseOffset, 2);
    });

    test('36. In "2.5", type . -> "2.5", At dot (3)', () {
      final result = format(oldText: '2.5', oldOffset: 3, newText: '2.5.', newOffset: 4);
      expect(result.text, '2.5');
      expect(result.selection.baseOffset, 3);
    });

    test('37. In "12.34", paste "5.67" -> "12.34567", End (8)', () {
      final result = format(oldText: '12.34', oldOffset: 5, newText: '12.345.67', newOffset: 9);
      expect(result.text, '12.34567');
      expect(result.selection.baseOffset, 8);
    });

    test('38. Type letters abc -> "", 0', () {
      final result = format(oldText: '', oldOffset: 0, newText: 'abc', newOffset: 3);
      expect(result.text, '');
      expect(result.selection.baseOffset, 0);
    });

    test('39. In "12", type x -> "12", At end (2)', () {
      final result = format(oldText: '12', oldOffset: 2, newText: '12x', newOffset: 3);
      expect(result.text, '12');
      expect(result.selection.baseOffset, 2);
    });

    test('40. Type negative sign - -> "", 0', () {
      final result = format(oldText: '', oldOffset: 0, newText: '-', newOffset: 1);
      expect(result.text, '');
      expect(result.selection.baseOffset, 0);
    });

    test('41. Type spaces 1 000 -> "1,000", End (5)', () {
      final result = format(oldText: '', oldOffset: 0, newText: '1 000', newOffset: 5);
      expect(result.text, '1,000');
      expect(result.selection.baseOffset, 5);
    });
  });

  group('Category 6: Boundaries & Digit Limits', () {
    test('42. Type 12 integer digits (123456789012) -> "123,456,789,012", End (15)', () {
      final result = typeSequence('123456789012');
      expect(result.text, '123,456,789,012');
      expect(result.selection.baseOffset, 15);
    });

    test('43. In 12-digit number, type 13th digit -> "123,456,789,012", Unchanged', () {
      final result = format(
        oldText: '123,456,789,012',
        oldOffset: 15,
        newText: '123,456,789,0123',
        newOffset: 16,
      );
      expect(result.text, '123,456,789,012');
      expect(result.selection.baseOffset, 15);
    });

    test('44. Type 5 decimals (0.12345) -> "0.12345", End (7)', () {
      final result = typeSequence('0.12345');
      expect(result.text, '0.12345');
      expect(result.selection.baseOffset, 7);
    });

    test('45. In 5-decimal number, type 6th decimal -> "0.12345", At end (7)', () {
      final result = format(
        oldText: '0.12345',
        oldOffset: 7,
        newText: '0.123456',
        newOffset: 8,
      );
      expect(result.text, '0.12345');
      expect(result.selection.baseOffset, 7);
    });

    test('46. In "999,999,999,999.99999", type any digit -> unchanged', () {
      final result = format(
        oldText: '999,999,999,999.99999',
        oldOffset: 21,
        newText: '999,999,999,999.999999',
        newOffset: 22,
      );
      expect(result.text, '999,999,999,999.99999');
      expect(result.selection.baseOffset, 21);
    });
  });

  group('Category 7: Backspacing & Caret Position Mechanics', () {
    test('47. In "1,234", cursor after , (offset 2), press Backspace -> "234", 0', () {
      final result = format(
        oldText: '1,234',
        oldOffset: 2,
        newText: '1234',
        newOffset: 1,
      );
      expect(result.text, '234');
      expect(result.selection.baseOffset, 0);
    });

    test('48. In "12,345", cursor after , (offset 3), press Backspace -> "1,345", 1', () {
      final result = format(
        oldText: '12,345',
        oldOffset: 3,
        newText: '12345',
        newOffset: 2,
      );
      expect(result.text, '1,345');
      expect(result.selection.baseOffset, 1);
    });

    test('49. In "2.", cursor after . (offset 2), press Backspace -> "2", 1', () {
      final result = format(
        oldText: '2.',
        oldOffset: 2,
        newText: '2',
        newOffset: 1,
      );
      expect(result.text, '2');
      expect(result.selection.baseOffset, 1);
    });

    test('50. In "0.", cursor after . (offset 2), press Backspace -> "0", 1', () {
      final result = format(
        oldText: '0.',
        oldOffset: 2,
        newText: '0',
        newOffset: 1,
      );
      expect(result.text, '0');
      expect(result.selection.baseOffset, 1);
    });

    test('51. In "0", cursor at offset 1, press Backspace -> "", 0', () {
      final result = format(
        oldText: '0',
        oldOffset: 1,
        newText: '',
        newOffset: 0,
      );
      expect(result.text, '');
      expect(result.selection.baseOffset, 0);
    });

    test('52. In "1,234.56", insert 9 between 1, and 2 -> "19,234.56", After 9 (offset 3)', () {
      final result = format(
        oldText: '1,234.56',
        oldOffset: 2,
        newText: '1,9234.56',
        newOffset: 3,
      );
      expect(result.text, '19,234.56');
      expect(result.selection.baseOffset, 3);
    });

    test('53. In "1,234.56", delete 2 in the middle -> "134.56", Offset 1', () {
      final result = format(
        oldText: '1,234.56',
        oldOffset: 3,
        newText: '1,34.56',
        newOffset: 2,
      );
      expect(result.text, '134.56');
      expect(result.selection.baseOffset, 1);
    });
  });

  group('Category 8: Paste & Bulk Text Insertion', () {
    test('54. Paste pre-formatted "1,234,567.89" -> "1,234,567.89", End (12)', () {
      final result = format(
        oldText: '',
        oldOffset: 0,
        newText: '1,234,567.89',
        newOffset: 12,
      );
      expect(result.text, '1,234,567.89');
      expect(result.selection.baseOffset, 12);
    });

    test('55. Paste messy currency "\$ 250,000.50" -> "250,000.50", End (10)', () {
      final result = format(
        oldText: '',
        oldOffset: 0,
        newText: r'$ 250,000.50',
        newOffset: 13,
      );
      expect(result.text, '250,000.50');
      expect(result.selection.baseOffset, 10);
    });
  });

  group('Category 9: Step-by-Step Sequential Typing & Deletion Workflows', () {
    test('Sequential typing of "3.5005" character-by-character', () {
      TextEditingValue val = TextEditingValue.empty;
      const sequence = ['3', '.', '5', '0', '0', '5'];
      final expectedTexts = ['3', '3.', '3.5', '3.50', '3.500', '3.5005'];

      for (int i = 0; i < sequence.length; i++) {
        val = formatter.formatEditUpdate(
          val,
          TextEditingValue(
            text: val.text + sequence[i],
            selection: TextSelection.collapsed(offset: val.text.length + 1),
          ),
        );
        expect(val.text, expectedTexts[i], reason: 'Step $i (${sequence[i]})');
        expect(val.selection.baseOffset, expectedTexts[i].length);
      }
    });

    test('Sequential backspacing: "0.005" -> "0.00" -> "0.0" -> "0." -> "0" -> ""', () {
      TextEditingValue val = const TextEditingValue(
        text: '0.005',
        selection: TextSelection.collapsed(offset: 5),
      );

      final expectedBackspaces = ['0.00', '0.0', '0.', '0', ''];
      final expectedOffsets = [4, 3, 2, 1, 0];

      for (int i = 0; i < expectedBackspaces.length; i++) {
        val = formatter.formatEditUpdate(
          val,
          TextEditingValue(
            text: val.text.substring(0, val.text.length - 1),
            selection: TextSelection.collapsed(offset: val.text.length - 1),
          ),
        );
        expect(val.text, expectedBackspaces[i], reason: 'Backspace step $i');
        expect(val.selection.baseOffset, expectedOffsets[i]);
      }
    });

    test('Custom formatter limits: maxIntegerDigits = 4, maxFractionDigits = 2', () {
      const customFormatter = ThousandsSeparatorInputFormatter(
        maxIntegerDigits: 4,
        maxFractionDigits: 2,
      );

      // Integer limit (4 digits max)
      final val1 = customFormatter.formatEditUpdate(
        const TextEditingValue(text: '9,999', selection: TextSelection.collapsed(offset: 5)),
        const TextEditingValue(text: '9,9991', selection: TextSelection.collapsed(offset: 6)),
      );
      expect(val1.text, '9,999'); // 5th integer digit rejected

      // Fraction limit (2 decimals max)
      final val2 = customFormatter.formatEditUpdate(
        const TextEditingValue(text: '12.34', selection: TextSelection.collapsed(offset: 5)),
        const TextEditingValue(text: '12.345', selection: TextSelection.collapsed(offset: 6)),
      );
      expect(val2.text, '12.34'); // 3rd decimal digit rejected
    });

    test('Insertion in the middle of thousands number shifts commas and caret cleanly', () {
      // Starting with "100,000", cursor between '1' and '0' (offset 1: "1|00,000")
      // User types '5' -> "1500000" formatted as "1,500,000"
      final val = formatter.formatEditUpdate(
        const TextEditingValue(
          text: '100,000',
          selection: TextSelection.collapsed(offset: 1),
        ),
        const TextEditingValue(
          text: '1500,000',
          selection: TextSelection.collapsed(offset: 2),
        ),
      );
      expect(val.text, '1,500,000');
      // Cursor should be after '5' (offset 3)
      expect(val.selection.baseOffset, 3);
    });
  });
}

