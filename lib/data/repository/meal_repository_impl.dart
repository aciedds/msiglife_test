import 'package:injectable/injectable.dart';
import 'package:msiglife_test/data/repository/source/local/meal_local.dart';
import 'package:msiglife_test/data/repository/source/remote/meal_remote.dart';
import 'package:msiglife_test/domain/entity/meal_category/meal_category_entity.dart';
import 'package:msiglife_test/domain/entity/meal_data/meal_data.dart';
import 'package:msiglife_test/domain/entity/meal_filtered_data/meal_filtered_data_entiy.dart';
import 'package:msiglife_test/domain/mapper/meal_category_mapper.dart';
import 'package:msiglife_test/domain/mapper/meal_data_mapper.dart';
import 'package:msiglife_test/domain/mapper/meal_filtered_data_mapper.dart';
import 'package:msiglife_test/domain/repository/meal_repository.dart';
import 'package:msiglife_test/state/data_state/data_state.dart';

@LazySingleton(as: MealRepository)
class MealRepositoryImpl implements MealRepository {
  final MealRemote _remote;
  final MealLocal _local;
  final MealCategoryMapper _categoryMapper;
  final MealFilteredDataMapper _filteredDataMapper;
  final MealDataMapper _dataMapper;

  MealRepositoryImpl(
    this._remote,
    this._local,
    this._categoryMapper,
    this._filteredDataMapper,
    this._dataMapper,
  );

  @override
  Future<DataState<List<MealFilteredDataEntity>>> getListMealByCategory({
    required String category,
  }) async {
    final result = await _remote.getListMealByCategory(category: category);
    return result.when(
      success: (data) {
        return DataState.success(
          data: data.map((e) => _filteredDataMapper.toEntity(e)).toList(),
        );
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          exception: exception,
          stackTrace: stackTrace,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<List<MealFilteredDataEntity>>> getListMealByFirstLetter({
    required String firstLetter,
  }) async {
    final result =
        await _remote.getListMealByFirstLetter(firstLetter: firstLetter);
    return result.when(
      success: (data) {
        return DataState.success(
          data: data.map((e) => _filteredDataMapper.toEntity(e)).toList(),
        );
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          exception: exception,
          stackTrace: stackTrace,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<MealDataEntity>> getMealById({
    required String idMeal,
  }) async {
    final result = await _remote.getMealById(idMeal: idMeal);
    return result.when(
      success: (data) {
        return DataState.success(
          data: _dataMapper.fromModelToEntity(data),
        );
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          exception: exception,
          stackTrace: stackTrace,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<List<MealCategoryEntity>>> getMealCategory() async {
    final result = await _remote.getMealCategory();
    return result.when(
      success: (data) {
        return DataState.success(
          data: data.map((e) => _categoryMapper.fromModelToEntity(e)).toList(),
        );
      },
      error: (message, data, exception, stackTrace, statusCode) {
        return DataState.error(
          message: message,
          exception: exception,
          stackTrace: stackTrace,
          statusCode: statusCode,
        );
      },
    );
  }

  @override
  Future<DataState<bool>> addToFavorite(data) async {
    try {
      final result =
          await _local.insertMealData(_dataMapper.fromEntityToDb(data));
      if (result == 0) {
        return const DataState.success(data: false);
      } else {
        return const DataState.success(data: true);
      }
    } catch (e) {
      return DataState.error(message: e.toString());
    }
  }

  @override
  Future<DataState<bool>> getHasExistInFavorite(String idMeal) async {
    try {
      final result = await _local.getExistMealData(idMeal);
      return DataState.success(data: result);
    } catch (e) {
      return DataState.error(message: e.toString());
    }
  }

  @override
  Future<DataState<bool>> removeFromFavorite(String idMeal) async {
    try {
      final result = await _local.deleteMealData(idMeal);
      if (result == 0) {
        return const DataState.success(data: false);
      } else {
        return const DataState.success(data: true);
      }
    } catch (e) {
      return DataState.error(message: e.toString());
    }
  }

  @override
  Future<DataState<List<MealDataEntity>>> getFavoriteList() async {
    try {
      final result = await _local.getAllMealRepo();
      return DataState.success(
        data: result.map((e) => _dataMapper.fromDbToEntity(e)).toList(),
      );
    } catch (e) {
      return DataState.error(message: e.toString());
    }
  }
}
