import 'package:hive/hive.dart';
import '../models/user_preferences.dart';
import '../../home/models/grid_item_model.dart';
import '../../../core/utils/constants.dart';
import '../../../core/errors/preferences_exception.dart';

class PreferencesService {
  Future<UserPreferences> loadPreferences(String userId) async {
    try {
      final box = await Hive.openBox<UserPreferences>(AppConstants.preferencesBoxName);
      final preferences = box.get(userId);
      
      if (preferences != null) {
        return preferences;
      }
      
      final defaultPreferences = UserPreferences(userId: userId);
      await box.put(userId, defaultPreferences);
      return defaultPreferences;
    } catch (e) {
      throw PreferencesLoadException();
    }
  }

  Future<void> savePreferences(UserPreferences preferences) async {
    try {
      final box = await Hive.openBox<UserPreferences>(AppConstants.preferencesBoxName);
      await box.put(preferences.userId, preferences);
    } catch (e) {
      throw PreferencesSaveException();
    }
  }

  Future<void> updateTheme(String userId, bool isDarkMode) async {
    try {
      final preferences = await loadPreferences(userId);
      final updated = preferences.copyWith(isDarkMode: isDarkMode);
      await savePreferences(updated);
    } catch (e) {
      if (e is PreferencesException) rethrow;
      throw ThemeSaveException();
    }
  }

  Future<void> updateLocale(String userId, String languageCode, String? countryCode) async {
    try {
      final preferences = await loadPreferences(userId);
      final updated = preferences.copyWith(
        languageCode: languageCode,
        countryCode: countryCode,
      );
      await savePreferences(updated);
    } catch (e) {
      if (e is PreferencesException) rethrow;
      throw LocaleSaveException();
    }
  }

  Future<void> updateGridItems(String userId, List<GridItemModel> items) async {
    try {
      final preferences = await loadPreferences(userId);
      final updated = preferences.copyWith(gridItems: items);
      await savePreferences(updated);
    } catch (e) {
      if (e is PreferencesException) rethrow;
      throw GridItemsSaveException();
    }
  }

  Future<void> updateGridColumns(String userId, int columns) async {
    try {
      final preferences = await loadPreferences(userId);
      final updated = preferences.copyWith(gridColumns: columns);
      await savePreferences(updated);
    } catch (e) {
      if (e is PreferencesException) rethrow;
      throw GridColumnsSaveException();
    }
  }

  Future<void> clearPreferences(String userId) async {
    try {
      final box = await Hive.openBox<UserPreferences>(AppConstants.preferencesBoxName);
      await box.delete(userId);
    } catch (e) {
      throw PreferencesStorageException();
    }
  }
}
