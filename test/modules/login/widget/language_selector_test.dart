import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:target_app/core/widgets/language_selector.dart';
import 'package:target_app/core/stores/translate/locale_store.dart';

void main() {
  group('languageSelector', () {
    testWidgets('should display current locale flag', (WidgetTester tester) async {
      final localeStore = LocaleStore();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LanguageSelector(
              localeStore: localeStore,
            ),
          ),
        ),
      );

      expect(find.text('🇧🇷'), findsOneWidget);
    });

    testWidgets('should display US flag when locale is English', (WidgetTester tester) async {
      final localeStore = LocaleStore();
      localeStore.setLocale(const Locale('en'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LanguageSelector(
              localeStore: localeStore,
            ),
          ),
        ),
      );

      expect(find.text('🇺🇸'), findsOneWidget);
    });

    testWidgets('should open popup menu when tapped', (WidgetTester tester) async {
      final localeStore = LocaleStore();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LanguageSelector(
              localeStore: localeStore,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PopupMenuButton<Locale>));
      await tester.pumpAndSettle();

      expect(find.text('Brasil'), findsOneWidget);
      expect(find.text('United States'), findsOneWidget);
    });

    testWidgets('should change locale when menu item is selected', (WidgetTester tester) async {
      final localeStore = LocaleStore();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LanguageSelector(
              localeStore: localeStore,
            ),
          ),
        ),
      );

      expect(localeStore.locale.languageCode, equals('pt'));

      await tester.tap(find.byType(PopupMenuButton<Locale>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('United States'));
      await tester.pumpAndSettle();

      expect(localeStore.locale.languageCode, equals('en'));
    });

    testWidgets('should update flag icon when locale changes', (WidgetTester tester) async {
      final localeStore = LocaleStore();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LanguageSelector(
              localeStore: localeStore,
            ),
          ),
        ),
      );

      expect(find.text('🇧🇷'), findsOneWidget);

      await tester.tap(find.byType(PopupMenuButton<Locale>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('United States'));
      await tester.pumpAndSettle();

      expect(find.text('🇺🇸'), findsOneWidget);
      expect(find.text('🇧🇷'), findsNothing);
    });
  });
}
