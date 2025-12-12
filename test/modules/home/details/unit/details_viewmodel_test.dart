import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:target_app/modules/home/details/viewmodels/details_viewmodel.dart';
import 'package:target_app/modules/home/viewmodels/home_viewmodel.dart';

void main() {
  late DetailsViewModel viewModel;

  setUp(() {
    final items = <GridItem>[
      GridItem(
        id: '1',
        name: 'ABC123',
        description: '',
        icon: Icons.home,
        editCount: 5,
      ),
      GridItem(
        id: '2',
        name: 'XYZ789',
        description: '',
        icon: Icons.star,
        editCount: 3,
      ),
      GridItem(
        id: '3',
        name: 'Test!@#',
        description: '',
        icon: Icons.favorite,
        editCount: 0,
      ),
    ];
    viewModel = DetailsViewModel(items: items, gridColumns: 2);
  });

  group('detailsViewModel', () {
    test('should calculate total edit count correctly', () {
      expect(viewModel.totalEditCount, equals(8));
    });

    test('should calculate total edit count as 0 when no items', () {
      final emptyViewModel = DetailsViewModel(items: [], gridColumns: 2);
      expect(emptyViewModel.totalEditCount, equals(0));
    });

    test('should calculate total characters correctly', () {
      expect(viewModel.totalCharacters, equals(19));
    });

    test('should count letters correctly', () {
      expect(viewModel.letterCount, equals(10));
    });

    test('should count numbers correctly', () {
      expect(viewModel.numberCount, equals(6));
    });

    test('should handle empty items list', () {
      final emptyViewModel = DetailsViewModel(items: [], gridColumns: 2);
      expect(emptyViewModel.totalCharacters, equals(0));
      expect(emptyViewModel.letterCount, equals(0));
      expect(emptyViewModel.numberCount, equals(0));
    });

    test('should handle items with special characters only', () {
      final items = <GridItem>[
        GridItem(
          id: '1',
          name: '!@#\$%^&*()',
          description: '',
          icon: Icons.star,
          editCount: 0,
        ),
      ];
      final specialViewModel = DetailsViewModel(items: items, gridColumns: 2);
      expect(specialViewModel.totalCharacters, equals(10));
      expect(specialViewModel.letterCount, equals(0));
      expect(specialViewModel.numberCount, equals(0));
    });

    test('should count accented letters correctly', () {
      final items = <GridItem>[
        GridItem(
          id: '1',
          name: 'Café São José',
          description: '',
          icon: Icons.coffee,
          editCount: 0,
        ),
      ];
      final accentViewModel = DetailsViewModel(items: items, gridColumns: 2);
      expect(accentViewModel.letterCount, equals(11));
    });

    test('should handle mixed content correctly', () {
      final items = <GridItem>[
        GridItem(
          id: '1',
          name: 'Hello123World',
          description: '',
          icon: Icons.person,
          editCount: 2,
        ),
      ];
      final mixedViewModel = DetailsViewModel(items: items, gridColumns: 2);
      expect(mixedViewModel.totalCharacters, equals(13));
      expect(mixedViewModel.letterCount, equals(10));
      expect(mixedViewModel.numberCount, equals(3));
    });
  });
}
