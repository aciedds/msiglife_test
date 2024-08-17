import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:msiglife_test/data/model/meal_category/meal_category_model.dart';
import 'package:msiglife_test/data/model/meal_data/meal_data_model.dart';
import 'package:msiglife_test/data/model/meal_filtered_data/meal_filtered_data_model.dart';
import 'package:msiglife_test/state/data_state/data_state.dart';

@lazySingleton
class MealRemote {
  final Dio _dio;

  MealRemote(this._dio);

  Future<DataState<List<MealCategoryModel>>> getMealCategory() async {
    try {
      final response = await _dio.get('categories.php');

      final result = (response.data['categories'] as List)
          .map((e) => MealCategoryModel.fromJson(e))
          .toList();
      return DataState.success(data: result);
    } on DioException catch (e) {
      return DataState.error(
        message: e.message ?? 'Unknown error',
        stackTrace: e.stackTrace,
        exception: e.error,
      );
    }
  }

  Future<DataState<List<MealFilteredDataModel>>> getListMealByCategory({
    required String category,
  }) async {
    try {
      final response = await _dio.get('filter.php', queryParameters: {
        'c': category,
      });
      final result = (response.data['meals'] as List)
          .map((e) => MealFilteredDataModel.fromJson(e))
          .toList();
      return DataState.success(data: result);
    } on DioException catch (e) {
      return DataState.error(
        message: e.message ?? 'Unknown error',
        stackTrace: e.stackTrace,
        exception: e.error,
      );
    }
  }

  Future<DataState<List<MealFilteredDataModel>>> getListMealByFirstLetter({
    required String firstLetter,
  }) async {
    try {
      final response = await _dio.get('filter.php', queryParameters: {
        'f': firstLetter,
      });
      final result = (response.data['meals'] as List)
          .map((e) => MealFilteredDataModel.fromJson(e))
          .toList();
      return DataState.success(data: result);
    } on DioException catch (e) {
      return DataState.error(
        message: e.message ?? 'Unknown error',
        stackTrace: e.stackTrace,
        exception: e.error,
      );
    }
  }

  Future<DataState<MealDataModel>> getMealById({required String idMeal}) async {
    try {
      final response = await _dio.get('lookup.php', queryParameters: {
        'i': idMeal,
      });
      final result = MealDataModel.fromJson(response.data['meals'][0]);
      return DataState.success(data: result);
    } on DioException catch (e) {
      return DataState.error(
        message: e.message ?? 'Unknown error',
        stackTrace: e.stackTrace,
        exception: e.error,
      );
    }
  }
}
