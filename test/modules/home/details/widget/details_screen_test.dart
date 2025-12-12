import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:target_app/l10n/app_localizations.dart';
import 'package:target_app/modules/home/details/views/details_screen.dart';
import 'package:target_app/modules/home/details/widgets/stat_card.dart';
import 'package:target_app/modules/home/details/widgets/character_distribution_chart.dart';
import 'package:target_app/modules/home/viewmodels/home_viewmodel.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  group('detailsScreen', () {
    testWidgets('should render all stat cards', (WidgetTester tester) async {
      final items = <GridItem>[
        GridItem(
          id: '1',
          name: 'Test123',
          description: '',
          icon: Icons.home,
          editCount: 5,
        ),
      ];

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
          home: DetailsScreen(
            items: items,
            gridColumns: 2,
          ),
        ),
      );

      expect(find.byType(StatCard), findsNWidgets(4));
    });

    testWidgets('should display character distribution chart',
        (WidgetTester tester) async {
      final items = <GridItem>[
        GridItem(
          id: '1',
          name: 'ABC123',
          description: '',
          icon: Icons.star,
          editCount: 2,
        ),
      ];

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
          home: DetailsScreen(
            items: items,
            gridColumns: 3,
          ),
        ),
      );

      expect(find.byType(CharacterDistributionChart), findsOneWidget);
    });

    testWidgets('should display correct grid columns value',
        (WidgetTester tester) async {
      final items = <GridItem>[
        GridItem(
          id: '1',
          name: 'Test',
          description: '',
          icon: Icons.check,
          editCount: 0,
        ),
      ];

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
          home: DetailsScreen(
            items: items,
            gridColumns: 4,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('4'), findsAtLeastNWidgets(1));
    });

    testWidgets('should calculate and display total rows correctly',
        (WidgetTester tester) async {
      final items = <GridItem>[
        ...List.generate(
          10,
          (index) => GridItem(
            id: '$index',
            name: 'Item $index',
            description: '',
            icon: Icons.folder,
            editCount: 0,
          ),
        ),
      ];

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
          home: DetailsScreen(
            items: items,
            gridColumns: 2,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('5'), findsAtLeastNWidgets(1));
    });

    testWidgets('should display item details list', (WidgetTester tester) async {
      final items = <GridItem>[
        GridItem(
          id: '1',
          name: 'First Item',
          description: '',
          icon: Icons.first_page,
          editCount: 3,
        ),
        GridItem(
          id: '2',
          name: 'Second Item',
          description: '',
          icon: Icons.favorite,
          editCount: 5,
        ),
      ];

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
          home: DetailsScreen(
            items: items,
            gridColumns: 2,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('First Item'), findsOneWidget);
      expect(find.text('Second Item'), findsOneWidget);
    });

    testWidgets('should handle empty items list', (WidgetTester tester) async {
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
          home: const DetailsScreen(
            items: [],
            gridColumns: 2,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(StatCard), findsNWidgets(4));
      expect(find.text('0'), findsAtLeastNWidgets(1));
    });
  });
}
