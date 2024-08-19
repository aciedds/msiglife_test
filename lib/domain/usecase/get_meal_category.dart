import 'package:injectable/injectable.dart';
import 'package:msiglife_test/domain/entity/meal_category/meal_category_entity.dart';
import 'package:msiglife_test/domain/repository/meal_repository.dart';
import 'package:msiglife_test/state/data_state/data_state.dart';

@lazySingleton
class GetMealCategoryUc {
  final MealRepository _repository;

  GetMealCategoryUc(this._repository);

  Future<DataState<List<MealCategoryEntity>>> call() async {
    return _repository.getMealCategory();
  }
}
