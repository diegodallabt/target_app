// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on _HomeViewModel, Store {
  late final _$itemsAtom = Atom(name: '_HomeViewModel.items', context: context);

  @override
  ObservableList<GridItem> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<GridItem> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$newItemNameAtom =
      Atom(name: '_HomeViewModel.newItemName', context: context);

  @override
  String get newItemName {
    _$newItemNameAtom.reportRead();
    return super.newItemName;
  }

  @override
  set newItemName(String value) {
    _$newItemNameAtom.reportWrite(value, super.newItemName, () {
      super.newItemName = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_HomeViewModel.errorMessage', context: context);

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

  late final _$loadItemsAsyncAction =
      AsyncAction('_HomeViewModel.loadItems', context: context);

  @override
  Future<void> loadItems(String userId) {
    return _$loadItemsAsyncAction.run(() => super.loadItems(userId));
  }

  late final _$_HomeViewModelActionController =
      ActionController(name: '_HomeViewModel', context: context);

  @override
  void setNewItemName(String value) {
    final _$actionInfo = _$_HomeViewModelActionController.startAction(
        name: '_HomeViewModel.setNewItemName');
    try {
      return super.setNewItemName(value);
    } finally {
      _$_HomeViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addItem() {
    final _$actionInfo = _$_HomeViewModelActionController.startAction(
        name: '_HomeViewModel.addItem');
    try {
      return super.addItem();
    } finally {
      _$_HomeViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeItem(String id) {
    final _$actionInfo = _$_HomeViewModelActionController.startAction(
        name: '_HomeViewModel.removeItem');
    try {
      return super.removeItem(id);
    } finally {
      _$_HomeViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editItem(String id, String newName,
      {String? newDescription, IconData? newIcon}) {
    final _$actionInfo = _$_HomeViewModelActionController.startAction(
        name: '_HomeViewModel.editItem');
    try {
      return super.editItem(id, newName,
          newDescription: newDescription, newIcon: newIcon);
    } finally {
      _$_HomeViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items},
newItemName: ${newItemName},
errorMessage: ${errorMessage}
    ''';
  }
}
