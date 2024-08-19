import 'package:injectable/injectable.dart';
import 'package:msiglife_test/domain/repository/meal_repository.dart';
import 'package:msiglife_test/state/data_state/data_state.dart';

@lazySingleton
class GetMealExistedFromFavoriteUc {
  final MealRepository _repository;

  GetMealExistedFromFavoriteUc(this._repository);

  Future<DataState<bool>> call(String idMeal) async {
    return await _repository.getHasExistInFavorite(idMeal);
  }
}
