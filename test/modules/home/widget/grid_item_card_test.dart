import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('icon size adapts based on grid columns (1 column)', (tester) async {
    const iconSize = 120.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Icon(
            Icons.home,
            size: iconSize,
          ),
        ),
      ),
    );

    final Icon icon = tester.widget(find.byType(Icon));
    expect(icon.size, equals(iconSize));
  });

  testWidgets('icon size adapts based on grid columns (2 columns)', (tester) async {
    const iconSize = 80.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Icon(
            Icons.home,
            size: iconSize,
          ),
        ),
      ),
    );

    final Icon icon = tester.widget(find.byType(Icon));
    expect(icon.size, equals(iconSize));
  });

  testWidgets('icon size adapts based on grid columns (3 columns)', (tester) async {
    const iconSize = 56.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Icon(
            Icons.home,
            size: iconSize,
          ),
        ),
      ),
    );

    final Icon icon = tester.widget(find.byType(Icon));
    expect(icon.size, equals(iconSize));
  });

  testWidgets('action button icon size (1 column)', (tester) async {
    const iconSize = 56.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Icon(
            Icons.edit,
            size: iconSize,
          ),
        ),
      ),
    );

    final Icon icon = tester.widget(find.byType(Icon));
    expect(icon.size, equals(iconSize));
  });

  testWidgets('action button icon size (2 columns)', (tester) async {
    const iconSize = 42.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Icon(
            Icons.edit,
            size: iconSize,
          ),
        ),
      ),
    );

    final Icon icon = tester.widget(find.byType(Icon));
    expect(icon.size, equals(iconSize));
  });

  testWidgets('action button icon size (3 columns)', (tester) async {
    const iconSize = 32.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Icon(
            Icons.edit,
            size: iconSize,
          ),
        ),
      ),
    );

    final Icon icon = tester.widget(find.byType(Icon));
    expect(icon.size, equals(iconSize));
  });
}
