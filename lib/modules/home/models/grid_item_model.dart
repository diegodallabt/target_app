import 'package:hive/hive.dart';

part 'grid_item_model.g.dart';

@HiveType(typeId: 1)
class GridItemModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final int iconCodePoint;

  GridItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.iconCodePoint,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'iconCodePoint': iconCodePoint,
    };
  }

  factory GridItemModel.fromJson(Map<String, dynamic> json) {
    return GridItemModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      iconCodePoint: json['iconCodePoint'] as int,
    );
  }
}
