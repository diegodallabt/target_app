// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LocaleStore on _LocaleStore, Store {
  late final _$localeAtom = Atom(name: '_LocaleStore.locale', context: context);

  @override
  Locale get locale {
    _$localeAtom.reportRead();
    return super.locale;
  }

  @override
  set locale(Locale value) {
    _$localeAtom.reportWrite(value, super.locale, () {
      super.locale = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_LocaleStore.errorMessage', context: context);

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

  late final _$loadLocaleAsyncAction =
      AsyncAction('_LocaleStore.loadLocale', context: context);

  @override
  Future<void> loadLocale(String userId) {
    return _$loadLocaleAsyncAction.run(() => super.loadLocale(userId));
  }

  late final _$setLocaleAsyncAction =
      AsyncAction('_LocaleStore.setLocale', context: context);

  @override
  Future<void> setLocale(Locale newLocale) {
    return _$setLocaleAsyncAction.run(() => super.setLocale(newLocale));
  }

  late final _$toggleLocaleAsyncAction =
      AsyncAction('_LocaleStore.toggleLocale', context: context);

  @override
  Future<void> toggleLocale() {
    return _$toggleLocaleAsyncAction.run(() => super.toggleLocale());
  }

  late final _$_LocaleStoreActionController =
      ActionController(name: '_LocaleStore', context: context);

  @override
  void resetToDefault() {
    final _$actionInfo = _$_LocaleStoreActionController.startAction(
        name: '_LocaleStore.resetToDefault');
    try {
      return super.resetToDefault();
    } finally {
      _$_LocaleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
locale: ${locale},
errorMessage: ${errorMessage}
    ''';
  }
}
