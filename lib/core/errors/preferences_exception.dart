abstract class PreferencesException implements Exception {
  final String message;
  final String _code;

  PreferencesException(this.message, this._code);

  String get code => _code;

  @override
  String toString() => 'PreferencesException($code): $message';
}

class PreferencesLoadException extends PreferencesException {
  PreferencesLoadException()
      : super(
          'Erro ao carregar as preferências do usuário',
          'PREFERENCES_LOAD_ERROR',
        );
}

class PreferencesSaveException extends PreferencesException {
  PreferencesSaveException()
      : super(
          'Erro ao salvar as preferências do usuário',
          'PREFERENCES_SAVE_ERROR',
        );
}

class PreferencesStorageException extends PreferencesException {
  PreferencesStorageException()
      : super(
          'Erro ao acessar o armazenamento de preferências',
          'PREFERENCES_STORAGE_ERROR',
        );
}

class GridItemsLoadException extends PreferencesException {
  GridItemsLoadException()
      : super(
          'Erro ao carregar os itens do grid',
          'GRID_ITEMS_LOAD_ERROR',
        );
}

class GridItemsSaveException extends PreferencesException {
  GridItemsSaveException()
      : super(
          'Erro ao salvar os itens do grid',
          'GRID_ITEMS_SAVE_ERROR',
        );
}

class ThemeLoadException extends PreferencesException {
  ThemeLoadException()
      : super(
          'Erro ao carregar as preferências de tema',
          'THEME_LOAD_ERROR',
        );
}

class ThemeSaveException extends PreferencesException {
  ThemeSaveException()
      : super(
          'Erro ao salvar as preferências de tema',
          'THEME_SAVE_ERROR',
        );
}

class LocaleLoadException extends PreferencesException {
  LocaleLoadException()
      : super(
          'Erro ao carregar as preferências de idioma',
          'LOCALE_LOAD_ERROR',
        );
}

class LocaleSaveException extends PreferencesException {
  LocaleSaveException()
      : super(
          'Erro ao salvar as preferências de idioma',
          'LOCALE_SAVE_ERROR',
        );
}

class GridColumnsLoadException extends PreferencesException {
  GridColumnsLoadException()
      : super(
          'Erro ao carregar as preferências de layout',
          'GRID_COLUMNS_LOAD_ERROR',
        );
}

class GridColumnsSaveException extends PreferencesException {
  GridColumnsSaveException()
      : super(
          'Erro ao salvar as preferências de layout',
          'GRID_COLUMNS_SAVE_ERROR',
        );
}
