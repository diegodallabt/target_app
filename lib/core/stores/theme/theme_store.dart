import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  @observable
  ThemeMode themeMode = ThemeMode.light;

  @computed
  bool get isDarkMode => themeMode == ThemeMode.dark;

  @action
  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  @action
  void setThemeMode(ThemeMode mode) {
    themeMode = mode;
  }
}
