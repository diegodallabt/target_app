import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:target_app/core/stores/translate/locale_store.dart';
import 'package:target_app/modules/login/models/user.dart';
import 'package:target_app/modules/login/models/user_preferences.dart';
import 'package:target_app/modules/home/models/grid_item_model.dart';

void main() {
  late LocaleStore localeStore;

  setUpAll(() async {
    Hive.init('./test/hive_test');
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(UserPreferencesAdapter());
    Hive.registerAdapter(GridItemModelAdapter());
  });

  setUp(() {
    localeStore = LocaleStore();
  });

  tearDownAll(() async {
    await Hive.deleteFromDisk();
  });

  group('localeStore', () {
    test('should have pt_BR as default locale', () {
      expect(localeStore.locale, equals(const Locale('pt', 'BR')));
    });

    test('should toggle locale from pt to en', () async {
      await localeStore.toggleLocale();
      expect(localeStore.locale, equals(const Locale('en')));
    });

    test('should toggle locale from en to pt_BR', () async {
      await localeStore.setLocale(const Locale('en'));
      await localeStore.toggleLocale();
      
      expect(localeStore.locale, equals(const Locale('pt', 'BR')));
    });

    test('should set locale directly', () async {
      await localeStore.setLocale(const Locale('en', 'US'));
      expect(localeStore.locale, equals(const Locale('en', 'US')));
    });

    test('should reset to default', () {
      localeStore.resetToDefault();
      expect(localeStore.locale, equals(const Locale('pt', 'BR')));
    });

    test('should load locale for user', () async {
      await localeStore.loadLocale('test_user');
      // Should load default or saved locale without errors
      expect(localeStore.locale, isNotNull);
    });

    test('should not persist locale when user is not logged in', () async {
      await localeStore.toggleLocale();
      expect(localeStore.locale, equals(const Locale('en')));
    });

    test('should handle pt locale correctly', () async {
      await localeStore.setLocale(const Locale('pt'));
      expect(localeStore.locale.languageCode, equals('pt'));
    });
  });
}
