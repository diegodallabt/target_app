import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../modules/login/services/preferences_service.dart';
import '../../errors/preferences_exception.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  final PreferencesService _preferencesService = PreferencesService();
  String? _currentUserId;

  @observable
  ThemeMode themeMode = ThemeMode.light;

  @observable
  String? errorMessage;

  @computed
  bool get isDarkMode => themeMode == ThemeMode.dark;

  @action
  Future<void> loadTheme(String userId) async {
    _currentUserId = userId;
    errorMessage = null;
    try {
      final preferences = await _preferencesService.loadPreferences(userId);
      themeMode = preferences.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    } on PreferencesException catch (e) {
      errorMessage = e.code;
      themeMode = ThemeMode.light;
    } catch (e) {
      errorMessage = 'THEME_LOAD_ERROR';
      themeMode = ThemeMode.light;
    }
  }

  @action
  Future<void> toggleTheme() async {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    errorMessage = null;
    if (_currentUserId != null) {
      try {
        await _preferencesService.updateTheme(_currentUserId!, isDarkMode);
      } on PreferencesException catch (e) {
        errorMessage = e.code;
      } catch (e) {
        errorMessage = 'THEME_SAVE_ERROR';
      }
    }
  }

  @action
  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode = mode;
    errorMessage = null;
    if (_currentUserId != null) {
      try {
        await _preferencesService.updateTheme(_currentUserId!, isDarkMode);
      } on PreferencesException catch (e) {
        errorMessage = e.code;
      } catch (e) {
        errorMessage = 'THEME_SAVE_ERROR';
      }
    }
  }

  @action
  void resetToDefault() {
    _currentUserId = null;
    themeMode = ThemeMode.light;
  }
}
