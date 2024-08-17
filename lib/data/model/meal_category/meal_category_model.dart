import 'package:freezed_annotation/freezed_annotation.dart' as j;

part 'meal_category_model.g.dart';

@j.JsonSerializable()
class MealCategoryModel {
  final String? idCategory;
  final String? strCategory;
  final String? strCategoryThumb;
  final String? strCategoryDescription;

  MealCategoryModel({
    required this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  factory MealCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$MealCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$MealCategoryModelToJson(this);
}
