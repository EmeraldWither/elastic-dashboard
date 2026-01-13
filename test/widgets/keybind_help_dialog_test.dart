import 'package:elastic_dashboard/pages/dashboard/dashboard_keybinds_window.dart';
import 'package:elastic_dashboard/widgets/keybinds_dialog.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import '../test_util.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();


  final List<DisplayableKeybindCategory> testKeybinds = [
    DisplayableKeybindCategory('Test Category 1', [
      DisplayableHotkey(['CTRL', 'A'], 'Select All'),
      DisplayableHotkey(['CTRL', 'DEL'], 'Delete Everything'),
      DisplayableHotkey(['CTRL', 'ALT', 'DEL'], 'Escape the Field'),
    ]),
    DisplayableKeybindCategory('Test Category 2', [
      DisplayableHotkey(['CTRL', 'H'], 'Open Help'),
      DisplayableHotkey(['CTRL', 'S'], 'Save Layout'),
      DisplayableHotkey(['CTRL', 'SHIFT', 'M'], 'Print Out'),
    ]),
  ];

  int totalKeybinds = 0;
  for(var cat in testKeybinds) {
    totalKeybinds += cat.keybinds.length;
  }

  testWidgets('Keybinds Dialog Basic Layout', (widgetTester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KeybindsDialog(
            keybindCategories: testKeybinds,
          ),
        ),
      ),
    );

    await widgetTester.pumpAndSettle();

    expect(find.text('Keyboard Shortcuts'), findsOneWidget);

    final closeButton = find.widgetWithText(TextButton, 'Close');

    expect(closeButton, findsOneWidget);

    await widgetTester.tap(closeButton);
    await widgetTester.pumpAndSettle();
  });

  testWidgets('Keybinds Dialog Correct Categories', (widgetTester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KeybindsDialog(
            keybindCategories: testKeybinds,
          ),
        ),
      ),
    );
    await widgetTester.pumpAndSettle();
    // verify amount
    expect(find.byType(KeybindCategoryWidget), findsNWidgets(testKeybinds.length), reason: 'There are not exactly ${testKeybinds.length} categories on the keybinds dialog.');
    for (var category in testKeybinds) {
      expect(find.text(category.name), findsOneWidget);
    }
  });

  testWidgets('Keybinds Dialog Correct Keybinds', (widgetTester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: KeybindsDialog(
            keybindCategories: testKeybinds,
          ),
        ),
      ),
    );
    await widgetTester.pumpAndSettle();
    expect(find.byType(KeybindWidget), findsNWidgets(totalKeybinds), reason: 'There are not exactly $totalKeybinds keybinds on the keybinds dialog.');

    var categories = find.byType(KeybindCategoryWidget);
    //iterate through each category
    for (int i = 0; i < testKeybinds.length; i++) {
      final category = categories.at(i);
      var keybindsAmount = (widgetTester.widget<KeybindCategoryWidget>(category)).keybinds.length;

      //child keybinds of a category
      var keybinds = find.descendant(of: category, matching: find.byType(KeybindWidget));
      expect(keybinds, findsNWidgets(keybindsAmount));

      //check that each keybind is correct
      for (int j = 0; j < keybindsAmount; j++) {
        final keybindFinder = keybinds.at(j); //KeybindWidget
        var keyDesc = (widgetTester.widget<KeybindWidget>(keybindFinder)).description;
        var keys = (widgetTester.widget<KeybindWidget>(keybindFinder)).keys;
        for(var key in keys) {
          expect(find.descendant(of: keybindFinder, matching: find.widgetWithText(Chip, key)), findsOneWidget);
        }
        expect(find.descendant(of: keybindFinder, matching: find.text('+')), findsNWidgets((keys.length - 1).toInt()), reason: 'You have too many \'+\'s in the keybind widget');
        expect(find.descendant(of: keybindFinder, matching: find.text('-')), findsOneWidget);
        expect(find.descendant(of: keybindFinder, matching: find.text(keyDesc)), findsOneWidget);
      }
    }

  });


}
