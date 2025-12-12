import 'package:mobx/mobx.dart';
import '../../viewmodels/home_viewmodel.dart';

part 'details_viewmodel.g.dart';

class DetailsViewModel = _DetailsViewModel with _$DetailsViewModel;

abstract class _DetailsViewModel with Store {
  final List<GridItem> items;
  final int gridColumns;

  _DetailsViewModel({
    required this.items,
    required this.gridColumns,
  });

  @computed
  int get totalEditCount {
    return items.fold<int>(0, (sum, item) => sum + item.editCount);
  }

  @computed
  int get totalCharacters {
    return items.fold<int>(
      0,
      (sum, item) => sum + item.name.length + item.description.length,
    );
  }

  @computed
  int get letterCount {
    int count = 0;
    for (var item in items) {
      final text = item.name + item.description;
      count += text.runes.where((rune) {
        final char = String.fromCharCode(rune);
        return RegExp(r'[a-zA-ZÀ-ÿ]').hasMatch(char);
      }).length;
    }
    return count;
  }

  @computed
  int get numberCount {
    int count = 0;
    for (var item in items) {
      final text = item.name + item.description;
      count += text.runes.where((rune) {
        final char = String.fromCharCode(rune);
        return RegExp(r'[0-9]').hasMatch(char);
      }).length;
    }
    return count;
  }
}
