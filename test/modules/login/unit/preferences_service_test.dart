import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:target_app/modules/login/services/preferences_service.dart';
import 'package:target_app/modules/home/models/grid_item_model.dart';
import 'package:target_app/modules/login/models/user_preferences.dart';
import 'package:target_app/modules/login/models/user.dart';

void main() {
  late PreferencesService preferencesService;

  setUpAll(() async {
    Hive.init('./test/hive_test');
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(UserPreferencesAdapter());
    Hive.registerAdapter(GridItemModelAdapter());
  });

  setUp(() {
    preferencesService = PreferencesService();
  });

  tearDownAll(() async {
    await Hive.deleteFromDisk();
  });

  group('preferencesService', () {
    test('should create default preferences for new user', () async {
      final userId = 'user123';
      
      final preferences = await preferencesService.loadPreferences(userId);
      expect(preferences.userId, equals(userId));
      expect(preferences.isDarkMode, isFalse);
      expect(preferences.languageCode, equals('pt'));
      expect(preferences.countryCode, equals('BR'));
      expect(preferences.gridColumns, equals(3));
    });

    test('should persist and load preferences correctly', () async {
      final userId = 'user456';
      
      await preferencesService.updateTheme(userId, true);
      final preferences = await preferencesService.loadPreferences(userId);
      expect(preferences.isDarkMode, isTrue);
    });

    test('should update locale preference', () async {
      final userId = 'user789';
      
      await preferencesService.updateLocale(userId, 'en', null);
      final preferences = await preferencesService.loadPreferences(userId);
      expect(preferences.languageCode, equals('en'));
    });

    test('should update grid columns preference', () async {
      final userId = 'user101';
      
      await preferencesService.updateGridColumns(userId, 2);
      final preferences = await preferencesService.loadPreferences(userId);
      expect(preferences.gridColumns, equals(2));
    });

    test('should update grid items', () async {
      final userId = 'user202';
      final items = [
        GridItemModel(
          id: '1',
          name: 'Test Item',
          description: 'Test Description',
          iconCodePoint: 0xe88a,
        ),
      ];
      
      await preferencesService.updateGridItems(userId, items);
      final preferences = await preferencesService.loadPreferences(userId);
      expect(preferences.gridItems.length, equals(1));
      expect(preferences.gridItems.first.name, equals('Test Item'));
    });

    test('should clear preferences', () async {
      final userId = 'user303';
      
      // Cria preferências primeiro
      await preferencesService.updateGridItems(userId, [
        GridItemModel(
          id: '1',
          name: 'Item',
          description: 'Desc',
          iconCodePoint: 0xe88a,
        ),
      ]);
      
      await preferencesService.clearPreferences(userId);
      final preferences = await preferencesService.loadPreferences(userId);
      expect(preferences.gridItems, isEmpty);
    });
  });
}
