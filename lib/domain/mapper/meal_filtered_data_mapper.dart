import 'package:injectable/injectable.dart';
import 'package:msiglife_test/data/model/meal_filtered_data/meal_filtered_data_model.dart';
import 'package:msiglife_test/domain/entity/meal_filtered_data/meal_filtered_data_entiy.dart';

@injectable
class MealFilteredDataMapper {
  MealFilteredDataEntity toEntity(MealFilteredDataModel model) {
    return MealFilteredDataEntity(
      idMeal: model.idMeal ?? '',
      strMeal: model.strMeal ?? '',
      strMealThumb: model.strMealThumb ?? '',
    );
  }

  MealFilteredDataModel toModel(MealFilteredDataEntity entity) {
    return MealFilteredDataModel(
      idMeal: entity.idMeal,
      strMeal: entity.strMeal,
      strMealThumb: entity.strMealThumb,
    );
  }
}
