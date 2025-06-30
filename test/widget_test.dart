// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gold_weight_converter/main.dart';

void main() {
  testWidgets('Gold converter app loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is displayed.
    expect(find.text('Gold Weight Converter'), findsOneWidget);

    // Verify that input field labels are present.
    expect(find.text('Tola'), findsAtLeastNWidgets(1));
    expect(find.text('Masha'), findsAtLeastNWidgets(1));
    expect(find.text('Ana'), findsAtLeastNWidgets(1));
    expect(find.text('Ratti'), findsAtLeastNWidgets(1));
    expect(find.text('Gram'), findsAtLeastNWidgets(1));

    // Verify that buttons are present.
    expect(find.text('Calculate'), findsOneWidget);
    expect(find.text('Clear All'), findsOneWidget);
  });

  testWidgets('Calculate button works with tola input', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Enter 1 in tola field
    await tester.enterText(find.byType(TextFormField).first, '1');
    
    // Verify conversion result appears automatically due to onChanged
    await tester.pump();
    expect(find.text('Conversion Details'), findsOneWidget);
    expect(find.textContaining('Total Weight:'), findsOneWidget);
  });

  testWidgets('Input validation works', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Enter invalid text
    await tester.enterText(find.byType(TextFormField).first, 'invalid');
    
    // Trigger validation
    await tester.pump();
    
    // Should not show conversion results for invalid input
    expect(find.text('Conversion Details'), findsNothing);
  });
}
