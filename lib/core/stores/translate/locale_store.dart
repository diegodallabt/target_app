import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../modules/login/services/preferences_service.dart';
import '../../errors/preferences_exception.dart';

part 'locale_store.g.dart';

class LocaleStore = _LocaleStore with _$LocaleStore;

abstract class _LocaleStore with Store {
  final PreferencesService _preferencesService = PreferencesService();
  String? _currentUserId;

  @observable
  Locale locale = const Locale('pt', 'BR');

  @observable
  String? errorMessage;

  @action
  Future<void> loadLocale(String userId) async {
    _currentUserId = userId;
    errorMessage = null;
    try {
      final preferences = await _preferencesService.loadPreferences(userId);
      locale = Locale(preferences.languageCode, preferences.countryCode);
    } on PreferencesException catch (e) {
      errorMessage = e.code;
      locale = const Locale('pt', 'BR');
    } catch (e) {
      errorMessage = 'LOCALE_LOAD_ERROR';
      locale = const Locale('pt', 'BR');
    }
  }

  @action
  Future<void> setLocale(Locale newLocale) async {
    locale = newLocale;
    errorMessage = null;
    if (_currentUserId != null) {
      try {
        await _preferencesService.updateLocale(
          _currentUserId!,
          newLocale.languageCode,
          newLocale.countryCode,
        );
      } on PreferencesException catch (e) {
        errorMessage = e.code;
      } catch (e) {
        errorMessage = 'LOCALE_SAVE_ERROR';
      }
    }
  }

  @action
  Future<void> toggleLocale() async {
    if (locale.languageCode == 'pt') {
      locale = const Locale('en');
    } else {
      locale = const Locale('pt', 'BR');
    }
    
    errorMessage = null;
    if (_currentUserId != null) {
      try {
        await _preferencesService.updateLocale(
          _currentUserId!,
          locale.languageCode,
          locale.countryCode,
        );
      } on PreferencesException catch (e) {
        errorMessage = e.code;
      } catch (e) {
        errorMessage = 'LOCALE_SAVE_ERROR';
      }
    }
  }

  @action
  void resetToDefault() {
    _currentUserId = null;
    locale = const Locale('pt', 'BR');
  }
}
