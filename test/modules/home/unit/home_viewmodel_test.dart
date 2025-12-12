import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:target_app/modules/home/models/grid_item_model.dart';
import 'package:target_app/modules/home/viewmodels/home_viewmodel.dart';

void main() {
  late HomeViewModel viewModel;

  setUp(() {
    viewModel = HomeViewModel();
  });

  group('homeViewModel', () {
    test('should have initial items', () {
      expect(viewModel.items.length, equals(4));
      expect(viewModel.items[0].name, equals('Home'));
      expect(viewModel.items[1].name, equals('Search'));
    });

    test('should add new item successfully', () {
      viewModel.setNewItemName('New Item');
      viewModel.addItem();
      
      expect(viewModel.items.length, equals(5));
      expect(viewModel.items.last.name, equals('New Item'));
      expect(viewModel.newItemName, isEmpty);
      expect(viewModel.errorMessage, isNull);
    });

    test('should not add empty item', () {
      viewModel.setNewItemName('   ');
      viewModel.addItem();
      
      expect(viewModel.items.length, equals(4));
      expect(viewModel.errorMessage, equals('itemNameEmpty'));
    });

    test('should clear error when setting new item name', () {
      viewModel.errorMessage = 'itemNameEmpty';
      viewModel.setNewItemName('New Item');
      
      expect(viewModel.errorMessage, isNull);
    });

    test('should remove item by id', () {
      final itemId = viewModel.items[0].id;
      viewModel.removeItem(itemId);
      
      expect(viewModel.items.length, equals(3));
      expect(viewModel.items.any((item) => item.id == itemId), isFalse);
    });

    test('should edit item name', () {
      final itemId = viewModel.items[0].id;
      viewModel.editItem(itemId, 'Updated Name');
      
      expect(viewModel.items[0].name, equals('Updated Name'));
    });

    test('should edit item description', () {
      final itemId = viewModel.items[0].id;
      viewModel.editItem(
        itemId,
        'Updated Name',
        newDescription: 'Updated Description',
      );
      
      expect(viewModel.items[0].description, equals('Updated Description'));
    });

    test('should edit item icon', () {
      final itemId = viewModel.items[0].id;
      final newIcon = Icons.star;
      viewModel.editItem(itemId, 'Updated Name', newIcon: newIcon);
      
      expect(viewModel.items[0].icon, equals(newIcon));
    });

    test('should not edit item with empty name', () {
      final itemId = viewModel.items[0].id;
      final originalName = viewModel.items[0].name;
      viewModel.editItem(itemId, '   ');
      
      expect(viewModel.items[0].name, equals(originalName));
    });

    test('should convert GridItem to GridItemModel', () {
      final item = viewModel.items[0];
      final model = item.toModel();
      
      expect(model.id, equals(item.id));
      expect(model.name, equals(item.name));
      expect(model.description, equals(item.description));
      expect(model.iconCodePoint, equals(item.icon.codePoint));
    });

    test('should convert GridItemModel to GridItem', () {
      final model = GridItemModel(
        id: 'test-id',
        name: 'Test Name',
        description: 'Test Description',
        iconCodePoint: Icons.home.codePoint,
      );
      final item = GridItem.fromModel(model);
      
      expect(item.id, equals(model.id));
      expect(item.name, equals(model.name));
      expect(item.description, equals(model.description));
      expect(item.icon.codePoint, equals(model.iconCodePoint));
    });
  });
}
