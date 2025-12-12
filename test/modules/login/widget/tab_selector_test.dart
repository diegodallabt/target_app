import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:target_app/core/widgets/tab_selector.dart';

void main() {
  group('tabSelector', () {
    testWidgets('should display tab labels', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TabSelector(
              leftLabel: 'Tab 1',
              rightLabel: 'Tab 2',
              isLeftSelected: true,
              onLeftTap: () {},
              onRightTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Tab 1'), findsOneWidget);
      expect(find.text('Tab 2'), findsOneWidget);
    });

    testWidgets('should call onRightTap when right tab is tapped', (WidgetTester tester) async {
      bool rightTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TabSelector(
              leftLabel: 'Tab 1',
              rightLabel: 'Tab 2',
              isLeftSelected: true,
              onLeftTap: () {},
              onRightTap: () => rightTapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tab 2'));
      expect(rightTapped, isTrue);
    });

    testWidgets('should call onLeftTap when left tab is tapped', (WidgetTester tester) async {
      bool leftTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TabSelector(
              leftLabel: 'Login',
              rightLabel: 'Register',
              isLeftSelected: false,
              onLeftTap: () => leftTapped = true,
              onRightTap: () {},
            ),
          ),
        ),
      );

      await tester.tap(find.text('Login'));
      expect(leftTapped, isTrue);
    });

    testWidgets('should highlight selected tab with animation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TabSelector(
              leftLabel: 'Tab 1',
              rightLabel: 'Tab 2',
              isLeftSelected: true,
              onLeftTap: () {},
              onRightTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(TabSelector), findsOneWidget);
      expect(find.byType(AnimatedAlign), findsOneWidget);
    });
  });
}
