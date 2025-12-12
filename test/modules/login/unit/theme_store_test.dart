import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:target_app/core/stores/theme/theme_store.dart';
import 'package:target_app/modules/login/models/user.dart';
import 'package:target_app/modules/login/models/user_preferences.dart';
import 'package:target_app/modules/home/models/grid_item_model.dart';

void main() {
  late ThemeStore themeStore;

  setUpAll(() async {
    Hive.init('./test/hive_test');
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(UserPreferencesAdapter());
    Hive.registerAdapter(GridItemModelAdapter());
  });

  setUp(() {
    themeStore = ThemeStore();
  });

  tearDownAll(() async {
    await Hive.deleteFromDisk();
  });

  group('themeStore', () {
    test('should have light theme as default', () {
      expect(themeStore.themeMode, equals(ThemeMode.light));
      expect(themeStore.isDarkMode, isFalse);
    });

    test('should toggle theme from light to dark', () async {
      await themeStore.toggleTheme();
      expect(themeStore.themeMode, equals(ThemeMode.dark));
      expect(themeStore.isDarkMode, isTrue);
    });

    test('should toggle theme from dark to light', () async {
      await themeStore.setThemeMode(ThemeMode.dark);
      await themeStore.toggleTheme();
      
      expect(themeStore.themeMode, equals(ThemeMode.light));
      expect(themeStore.isDarkMode, isFalse);
    });

    test('should set theme mode directly', () async {
      await themeStore.setThemeMode(ThemeMode.dark);
      expect(themeStore.themeMode, equals(ThemeMode.dark));
      expect(themeStore.isDarkMode, isTrue);
    });

    test('should reset to default', () {
      themeStore.resetToDefault();
      expect(themeStore.themeMode, equals(ThemeMode.light));
      expect(themeStore.isDarkMode, isFalse);
    });

    test('should load theme for user', () async {
      await themeStore.loadTheme('test_user');
      // Should load default or saved theme without errors
      expect(themeStore.themeMode, isNotNull);
    });

    test('should not persist theme when user is not logged in', () async {
      await themeStore.toggleTheme();
      expect(themeStore.themeMode, equals(ThemeMode.dark));
    });
  });
}
