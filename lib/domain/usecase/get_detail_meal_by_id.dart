import 'package:injectable/injectable.dart';
import 'package:msiglife_test/domain/entity/meal_data/meal_data.dart';
import 'package:msiglife_test/domain/repository/meal_repository.dart';
import 'package:msiglife_test/state/data_state/data_state.dart';

@lazySingleton
class GetDetailMealByIdUc {
  final MealRepository _repository;

  GetDetailMealByIdUc(this._repository);

  Future<DataState<MealDataEntity>> call({required String idMeal}) async {
    return _repository.getMealById(idMeal: idMeal);
  }
}
