import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'locale_store.g.dart';

class LocaleStore = _LocaleStore with _$LocaleStore;

abstract class _LocaleStore with Store {
  @observable
  Locale locale = const Locale('pt', 'BR');

  @action
  void setLocale(Locale newLocale) {
    locale = newLocale;
  }

  @action
  void toggleLocale() {
    if (locale.languageCode == 'pt') {
      locale = const Locale('en');
    } else {
      locale = const Locale('pt', 'BR');
    }
  }
}
