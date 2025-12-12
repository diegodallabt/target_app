// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThemeStore on _ThemeStore, Store {
  Computed<bool>? _$isDarkModeComputed;

  @override
  bool get isDarkMode =>
      (_$isDarkModeComputed ??= Computed<bool>(() => super.isDarkMode,
              name: '_ThemeStore.isDarkMode'))
          .value;

  late final _$themeModeAtom =
      Atom(name: '_ThemeStore.themeMode', context: context);

  @override
  ThemeMode get themeMode {
    _$themeModeAtom.reportRead();
    return super.themeMode;
  }

  @override
  set themeMode(ThemeMode value) {
    _$themeModeAtom.reportWrite(value, super.themeMode, () {
      super.themeMode = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_ThemeStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$loadThemeAsyncAction =
      AsyncAction('_ThemeStore.loadTheme', context: context);

  @override
  Future<void> loadTheme(String userId) {
    return _$loadThemeAsyncAction.run(() => super.loadTheme(userId));
  }

  late final _$toggleThemeAsyncAction =
      AsyncAction('_ThemeStore.toggleTheme', context: context);

  @override
  Future<void> toggleTheme() {
    return _$toggleThemeAsyncAction.run(() => super.toggleTheme());
  }

  late final _$setThemeModeAsyncAction =
      AsyncAction('_ThemeStore.setThemeMode', context: context);

  @override
  Future<void> setThemeMode(ThemeMode mode) {
    return _$setThemeModeAsyncAction.run(() => super.setThemeMode(mode));
  }

  late final _$_ThemeStoreActionController =
      ActionController(name: '_ThemeStore', context: context);

  @override
  void resetToDefault() {
    final _$actionInfo = _$_ThemeStoreActionController.startAction(
        name: '_ThemeStore.resetToDefault');
    try {
      return super.resetToDefault();
    } finally {
      _$_ThemeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
themeMode: ${themeMode},
errorMessage: ${errorMessage},
isDarkMode: ${isDarkMode}
    ''';
  }
}
