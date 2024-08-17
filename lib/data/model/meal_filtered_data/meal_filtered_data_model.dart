import 'package:freezed_annotation/freezed_annotation.dart' as j;

part 'meal_filtered_data_model.g.dart';

@j.JsonSerializable()
class MealFilteredDataModel {
  final String? idMeal;
  final String? strMeal;
  final String? strMealThumb;

  MealFilteredDataModel({
    required this.idMeal,
    this.strMeal,
    this.strMealThumb,
  });

  factory MealFilteredDataModel.fromJson(Map<String, dynamic> json) =>
      _$MealFilteredDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MealFilteredDataModelToJson(this);
}
