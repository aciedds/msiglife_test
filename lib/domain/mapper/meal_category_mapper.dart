import 'package:injectable/injectable.dart';
import 'package:msiglife_test/data/model/meal_category/meal_category_model.dart';
import 'package:msiglife_test/domain/entity/meal_category/meal_category_entity.dart';

@injectable
class MealCategoryMapper {
  MealCategoryEntity fromModelToEntity(MealCategoryModel model) {
    return MealCategoryEntity(
      idCategory: model.idCategory ?? '',
      strCategory: model.strCategory ?? '',
      strMealThumb: model.strCategoryThumb ?? '',
      strCategoryDescription: model.strCategoryDescription ?? '',
    );
  }

  MealCategoryModel fromEntityToModel(MealCategoryEntity entity) {
    return MealCategoryModel(
      idCategory: entity.idCategory,
      strCategory: entity.strCategory,
      strCategoryThumb: entity.strMealThumb,
      strCategoryDescription: entity.strCategoryDescription,
    );
  }
}
