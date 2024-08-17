import 'package:msiglife_test/domain/entity/meal_category/meal_category_entity.dart';
import 'package:msiglife_test/domain/entity/meal_data/meal_data.dart';
import 'package:msiglife_test/domain/entity/meal_filtered_data/meal_filtered_data_entiy.dart';
import 'package:msiglife_test/state/data_state/data_state.dart';

abstract class MealRepository {
  Future<DataState<List<MealCategoryEntity>>> getMealCategory();

  Future<DataState<List<MealFilteredDataEntity>>> getListMealByCategory({
    required String category,
  });

  Future<DataState<List<MealFilteredDataEntity>>> getListMealByFirstLetter({
    required String firstLetter,
  });

  Future<DataState<MealDataEntity>> getMealById({required String idMeal});
}
