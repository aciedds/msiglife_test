import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:msiglife_test/data/model/meal_category/meal_category_model.dart';
import 'package:msiglife_test/data/model/meal_filtered_data/meal_filtered_data_model.dart';
import 'package:msiglife_test/data/repository/source/remote/meal_remote.dart';
import 'package:msiglife_test/state/data_state/data_state.dart';

import 'meal_remote_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late MealRemote mealRemote;

  setUp(() {
    mockDio = MockDio();
    mealRemote = MealRemote(mockDio);
  });

  group('MealRemote', () {
    test('getMealCategory should return a list of MealCategoryModel on success',
        () async {
      final mockResponse = {
        'categories': [
          {
            'idCategory': '1',
            'strCategory': 'Beef',
            'strCategoryThumb': 'https://example.com/beef.jpg',
            'strCategoryDescription': 'Beef meals',
          },
        ]
      };

      when(mockDio.get('categories.php')).thenAnswer((_) async => Response(
            data: mockResponse,
            statusCode: 200,
            requestOptions: RequestOptions(path: 'categories.php'),
          ));

      final result = await mealRemote.getMealCategory();
      result.when(
        success: (data) {
          expect(data, isA<List<MealCategoryModel>>());
          expect(data.length, 1);
          expect(data.first.strCategory, 'Beef');
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('getMealCategory should return error DataState on DioException',
        () async {
      when(mockDio.get('categories.php')).thenThrow(DioException(
        requestOptions: RequestOptions(path: 'categories.php'),
        message: 'Failed to fetch data',
      ));

      final result = await mealRemote.getMealCategory();
      result.when(
        success: (data) {},
        error: (message, data, exception, stackTrace, statusCode) {
          expect(message, 'Failed to fetch data');
        },
      );
    });

    test(
        'getListMealByCategory should return a list of MealFilteredDataModel on success',
        () async {
      final mockResponse = {
        'meals': [
          {
            'idMeal': '52772',
            'strMeal': 'Beef and Mustard Pie',
            'strMealThumb': 'https://example.com/beef_mustard_pie.jpg',
          },
        ]
      };

      when(mockDio.get('filter.php', queryParameters: {'c': 'Beef'}))
          .thenAnswer((_) async => Response(
                data: mockResponse,
                statusCode: 200,
                requestOptions: RequestOptions(path: 'filter.php'),
              ));

      final result = await mealRemote.getListMealByCategory(category: 'Beef');

      expect(result, isA<DataState<List<MealFilteredDataModel>>>());
      expect(result.data!.length, 1);
      expect(result.data!.first.strMeal, 'Beef and Mustard Pie');
    });

    test('getListMealByCategory should return error DataState on DioException',
        () async {
      when(mockDio.get('filter.php', queryParameters: {'c': 'Beef'}))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: 'filter.php'),
        message: 'Failed to fetch data',
      ));

      final result = await mealRemote.getListMealByCategory(category: 'Beef');

      result.when(
        success: (data) {},
        error: (message, data, exception, stackTrace, statusCode) {
          expect(message, 'Failed to fetch data');
        },
      );
    });

    test(
        'getListMealByFirstLetter should return a list of MealFilteredDataModel on success',
        () async {
      final mockResponse = {
        'meals': [
          {
            'idMeal': '52772',
            'strMeal': 'Beef and Mustard Pie',
            'strMealThumb': 'https://example.com/beef_mustard_pie.jpg',
          },
        ]
      };

      when(mockDio.get('filter.php', queryParameters: {'f': 'b'}))
          .thenAnswer((_) async => Response(
                data: mockResponse,
                statusCode: 200,
                requestOptions: RequestOptions(path: 'filter.php'),
              ));

      final result =
          await mealRemote.getListMealByFirstLetter(firstLetter: 'b');

      expect(result, isA<DataState<List<MealFilteredDataModel>>>());
      expect(result.data!.length, 1);
      expect(result.data!.first.strMeal, 'Beef and Mustard Pie');
    });

    test(
        'getListMealByFirstLetter should return error DataState on DioException',
        () async {
      when(mockDio.get('filter.php', queryParameters: {'f': 'b'}))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: 'filter.php'),
        message: 'Failed to fetch data',
      ));

      final result =
          await mealRemote.getListMealByFirstLetter(firstLetter: 'b');
      result.when(
        success: (data) {},
        error: (message, data, exception, stackTrace, statusCode) {
          expect(message, 'Failed to fetch data');
        },
      );
    });
  });
}
