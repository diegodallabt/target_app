import 'package:hive/hive.dart';
import '../../home/models/grid_item_model.dart';

part 'user_preferences.g.dart';

@HiveType(typeId: 2)
class UserPreferences {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final bool isDarkMode;

  @HiveField(2)
  final String languageCode;

  @HiveField(3)
  final String? countryCode;

  @HiveField(4)
  final List<GridItemModel> gridItems;

  @HiveField(5)
  final int gridColumns;

  UserPreferences({
    required this.userId,
    this.isDarkMode = false,
    this.languageCode = 'pt',
    this.countryCode = 'BR',
    this.gridItems = const [],
    this.gridColumns = 3,
  });

  UserPreferences copyWith({
    String? userId,
    bool? isDarkMode,
    String? languageCode,
    String? countryCode,
    List<GridItemModel>? gridItems,
    int? gridColumns,
  }) {
    return UserPreferences(
      userId: userId ?? this.userId,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      languageCode: languageCode ?? this.languageCode,
      countryCode: countryCode ?? this.countryCode,
      gridItems: gridItems ?? this.gridItems,
      gridColumns: gridColumns ?? this.gridColumns,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'isDarkMode': isDarkMode,
      'languageCode': languageCode,
      'countryCode': countryCode,
      'gridItems': gridItems.map((item) => item.toJson()).toList(),
      'gridColumns': gridColumns,
    };
  }

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      userId: json['userId'] as String,
      isDarkMode: json['isDarkMode'] as bool? ?? false,
      languageCode: json['languageCode'] as String? ?? 'pt',
      countryCode: json['countryCode'] as String?,
      gridItems: (json['gridItems'] as List<dynamic>?)
              ?.map((item) => GridItemModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      gridColumns: json['gridColumns'] as int? ?? 3,
    );
  }
}
