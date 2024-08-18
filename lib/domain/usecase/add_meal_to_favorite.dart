import 'package:injectable/injectable.dart';
import 'package:msiglife_test/domain/entity/meal_data/meal_data.dart';
import 'package:msiglife_test/domain/repository/meal_repository.dart';
import 'package:msiglife_test/state/data_state/data_state.dart';

@injectable
class AddMealToFavoriteUc{
  final MealRepository _repository;
  AddMealToFavoriteUc(this._repository);

  Future<DataState<bool>> call(MealDataEntity data) async {
    return await _repository.addToFavorite(data);
  }
}