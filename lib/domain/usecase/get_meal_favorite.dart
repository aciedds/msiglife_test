import 'package:injectable/injectable.dart';
import 'package:msiglife_test/domain/entity/meal_data/meal_data.dart';
import 'package:msiglife_test/domain/repository/meal_repository.dart';
import 'package:msiglife_test/state/data_state/data_state.dart';

@lazySingleton
class GetMealFavoriteUc {
  final MealRepository _repository;

  const GetMealFavoriteUc(this._repository);

  Future<DataState<List<MealDataEntity>>> call() async {
    return await _repository.getFavoriteList();
  }
}
