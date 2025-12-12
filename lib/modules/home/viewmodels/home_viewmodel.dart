import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../login/services/preferences_service.dart';
import '../models/grid_item_model.dart';
import '../../../core/errors/preferences_exception.dart';

part 'home_viewmodel.g.dart';

class HomeViewModel = _HomeViewModel with _$HomeViewModel;

class GridItem {
  final String id;
  final String name;
  final String description;
  final IconData icon;

  GridItem({
    required this.id,
    required this.name,
    this.description = '',
    required this.icon,
  });

  GridItemModel toModel() {
    return GridItemModel(
      id: id,
      name: name,
      description: description,
      iconCodePoint: icon.codePoint,
    );
  }

  factory GridItem.fromModel(GridItemModel model) {
    return GridItem(
      id: model.id,
      name: model.name,
      description: model.description,
      icon: IconData(model.iconCodePoint, fontFamily: 'MaterialIcons'),
    );
  }
}

final availableIcons = [
  Icons.star,
  Icons.work,
  Icons.shopping_cart,
  Icons.camera,
  Icons.music_note,
  Icons.sports_soccer,
  Icons.local_dining,
  Icons.flight,
  Icons.beach_access,
  Icons.attach_money,
  Icons.home,
  Icons.search,
  Icons.favorite,
  Icons.settings,
  Icons.folder,
  Icons.smartphone,
  Icons.laptop,
  Icons.headphones,
  Icons.videogame_asset,
  Icons.book,
];

abstract class _HomeViewModel with Store {
  final PreferencesService _preferencesService = PreferencesService();
  String? _currentUserId;

  @observable
  ObservableList<GridItem> items = ObservableList<GridItem>.of([
    GridItem(id: '1', name: 'Home', description: 'Home page', icon: Icons.home),
    GridItem(
      id: '2',
      name: 'Search',
      description: 'Search items',
      icon: Icons.search,
    ),
    GridItem(
      id: '3',
      name: 'Favorites',
      description: 'Favorite items',
      icon: Icons.favorite,
    ),
    GridItem(
      id: '4',
      name: 'Settings',
      description: 'App settings',
      icon: Icons.settings,
    ),
  ]);

  @observable
  String newItemName = '';

  @observable
  String? errorMessage;

  @action
  Future<void> loadItems(String userId) async {
    _currentUserId = userId;
    errorMessage = null;
    try {
      final preferences = await _preferencesService.loadPreferences(userId);
      if (preferences.gridItems.isNotEmpty) {
        items.clear();
        items.addAll(preferences.gridItems.map((model) => GridItem.fromModel(model)));
      }
    } on PreferencesException catch (e) {
      errorMessage = e.code;
    } catch (e) {
      errorMessage = 'GRID_ITEMS_LOAD_ERROR';
    }
  }

  Future<void> _saveItems() async {
    if (_currentUserId != null) {
      try {
        final models = items.map((item) => item.toModel()).toList();
        await _preferencesService.updateGridItems(_currentUserId!, models);
        errorMessage = null;
      } on PreferencesException catch (e) {
        errorMessage = e.code;
      } catch (e) {
        errorMessage = 'GRID_ITEMS_SAVE_ERROR';
      }
    }
  }

  @action
  void setNewItemName(String value) {
    newItemName = value;
    if (errorMessage != null) {
      errorMessage = null;
    }
  }

  @action
  void addItem() {
    if (newItemName.trim().isEmpty) {
      errorMessage = 'itemNameEmpty';
      return;
    }

    final randomIcon = availableIcons[items.length % availableIcons.length];

    final newItem = GridItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: newItemName.trim(),
      description: '',
      icon: randomIcon,
    );

    items.add(newItem);
    newItemName = '';
    errorMessage = null;
    _saveItems();
  }

  @action
  void removeItem(String id) {
    items.removeWhere((item) => item.id == id);
    _saveItems();
  }

  @action
  void editItem(
    String id,
    String newName, {
    String? newDescription,
    IconData? newIcon,
  }) {
    final index = items.indexWhere((item) => item.id == id);
    if (index != -1 && newName.trim().isNotEmpty) {
      final item = items[index];
      items[index] = GridItem(
        id: item.id,
        name: newName.trim(),
        description: newDescription ?? item.description,
        icon: newIcon ?? item.icon,
      );
      _saveItems();
    }
  }
}
