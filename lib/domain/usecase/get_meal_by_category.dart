import 'package:injectable/injectable.dart';
import 'package:msiglife_test/domain/entity/meal_filtered_data/meal_filtered_data_entiy.dart';
import 'package:msiglife_test/domain/repository/meal_repository.dart';
import 'package:msiglife_test/state/data_state/data_state.dart';

@lazySingleton
class GetMealByCategoryUc {
  final MealRepository _repository;

  GetMealByCategoryUc(this._repository);

  Future<DataState<List<MealFilteredDataEntity>>> call({
    required String category,
  }) async {
    return _repository.getListMealByCategory(category: category);
  }
}
