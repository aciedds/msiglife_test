import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_filtered_data_entiy.freezed.dart';

@freezed
class MealFilteredDataEntity with _$MealFilteredDataEntity {
  factory MealFilteredDataEntity({
    required String idMeal,
    required String strMeal,
    required String strMealThumb,
  }) = _MealFilteredDataEntity;
}
