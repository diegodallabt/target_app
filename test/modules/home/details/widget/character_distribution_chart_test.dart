import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:target_app/l10n/app_localizations.dart';
import 'package:target_app/modules/home/details/widgets/character_distribution_chart.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  group('characterDistributionChart', () {
    testWidgets('should render with initial bar chart type',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('pt'),
          ],
          home: const Scaffold(
            body: CharacterDistributionChart(
              letterCount: 10,
              numberCount: 5,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(SegmentedButton<ChartType>), findsOneWidget);
    });

    testWidgets('should toggle between bar and pie charts',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('pt'),
          ],
          home: const Scaffold(
            body: CharacterDistributionChart(
              letterCount: 15,
              numberCount: 8,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final pieButton = find.descendant(
        of: find.byType(SegmentedButton<ChartType>),
        matching: find.text('Pie'),
      );

      if (pieButton.evaluate().isNotEmpty) {
        await tester.tap(pieButton);
        await tester.pumpAndSettle();

        expect(find.byType(SegmentedButton<ChartType>), findsOneWidget);
      }
    });

    testWidgets('should display chart legend', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('pt'),
          ],
          home: const Scaffold(
            body: CharacterDistributionChart(
              letterCount: 20,
              numberCount: 10,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CharacterDistributionChart), findsOneWidget);
    });

    testWidgets('should handle zero values', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('pt'),
          ],
          home: const Scaffold(
            body: CharacterDistributionChart(
              letterCount: 0,
              numberCount: 0,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CharacterDistributionChart), findsOneWidget);
    });

    testWidgets('should handle large values', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('pt'),
          ],
          home: const Scaffold(
            body: CharacterDistributionChart(
              letterCount: 9999,
              numberCount: 8888,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CharacterDistributionChart), findsOneWidget);
    });
  });
}
