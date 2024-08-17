import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_category_entity.freezed.dart';

@freezed
class MealCategoryEntity with _$MealCategoryEntity {
  factory MealCategoryEntity({
    required String idCategory,
    required String strCategory,
    required String strMealThumb,
    required String strCategoryDescription,
  }) = _MealCategoryEntity;
}
