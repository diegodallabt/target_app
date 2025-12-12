import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:target_app/modules/home/details/widgets/stat_card.dart';

void main() {
  group('statCard', () {
    testWidgets('should display title and value correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StatCard(
              title: 'Test Title',
              value: '42',
              icon: Icons.check,
              color: Colors.blue,
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('42'), findsOneWidget);
    });

    testWidgets('should display icon with correct color',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StatCard(
              title: 'Test',
              value: '10',
              icon: Icons.star,
              color: Colors.orange,
            ),
          ),
        ),
      );

      final iconWidget = tester.widget<Icon>(find.byIcon(Icons.star));
      expect(iconWidget.icon, equals(Icons.star));
      expect(iconWidget.color, equals(Colors.orange));
    });

    testWidgets('should render with different values',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                StatCard(
                  title: 'Count 1',
                  value: '0',
                  icon: Icons.abc,
                  color: Colors.red,
                ),
                StatCard(
                  title: 'Count 2',
                  value: '999',
                  icon: Icons.numbers,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Count 1'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
      expect(find.text('Count 2'), findsOneWidget);
      expect(find.text('999'), findsOneWidget);
    });

    testWidgets('should have elevated card appearance',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StatCard(
              title: 'Test',
              value: '1',
              icon: Icons.info,
              color: Colors.purple,
            ),
          ),
        ),
      );

      final card = tester.widget<Card>(find.byType(Card));
      expect(card.elevation, greaterThan(0));
    });
  });
}
