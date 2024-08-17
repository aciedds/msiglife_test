import 'package:flutter_test/flutter_test.dart';
import 'package:msiglife_test/data/model/meal_filtered_data/meal_filtered_data_model.dart';

void main() {
  group('MealFilteredDataModel', () {
    test('MealFilteredDataModel.fromJson creates a model from a valid JSON map',
        () {
      final json = {
        'idMeal': '52772',
        'strMeal': 'Teriyaki Chicken Casserole',
        'strMealThumb':
            'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg',
      };

      final model = MealFilteredDataModel.fromJson(json);

      expect(model.idMeal, '52772');
      expect(model.strMeal, 'Teriyaki Chicken Casserole');
      expect(model.strMealThumb,
          'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg');
    });

    test('MealFilteredDataModel.toJson converts a model to a JSON map', () {
      final model = MealFilteredDataModel(
        idMeal: '52772',
        strMeal: 'Teriyaki Chicken Casserole',
        strMealThumb:
            'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg',
      );

      final json = model.toJson();

      expect(json['idMeal'], '52772');
      expect(json['strMeal'], 'Teriyaki Chicken Casserole');
      expect(json['strMealThumb'],
          'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg');
    });
  });
}
