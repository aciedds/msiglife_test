import 'package:flutter_test/flutter_test.dart';
import 'package:msiglife_test/data/model/meal_category/meal_category_model.dart';

void main() {
  group('MealCategoryModel', () {
    test('MealCategoryModel.fromJson creates a model from a valid JSON map',
        () {
      final json = {
        'idCategory': '52772',
        'strMeal': 'Teriyaki Chicken Casserole',
        'strCategoryThumb':
            'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg',
        'strCategoryDescription': 'A delicious casserole with teriyaki chicken.'
      };

      final model = MealCategoryModel.fromJson(json);

      expect(model.idCategory, '52772');
      expect(model.strCategory, 'Teriyaki Chicken Casserole');
      expect(model.strCategoryThumb,
          'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg');
      expect(model.strCategoryDescription,
          'A delicious casserole with teriyaki chicken.');
    });

    test('MealCategoryModel.toJson converts a model to a JSON map', () {
      final model = MealCategoryModel(
          idCategory: '52772',
          strCategory: 'Teriyaki Chicken Casserole',
          strCategoryThumb:
              'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg',
          strCategoryDescription:
              'A delicious casserole with teriyaki chicken.');

      final json = model.toJson();

      expect(json['idCategory'], '52772');
      expect(json['strMeal'], 'Teriyaki Chicken Casserole');
      expect(json['strCategoryThumb'],
          'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg');
      expect(json['strCategoryDescription'],
          'A delicious casserole with teriyaki chicken.');
    });
  });
}
