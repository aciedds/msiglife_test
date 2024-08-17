import 'package:flutter_test/flutter_test.dart';
import 'package:msiglife_test/data/model/meal_data/meal_data_model.dart';

void main() {
  group('MealDataModel', () {
    test('MealDataModel.fromJson creates a model from a valid JSON map', () {
      final json = {
        'idMeal': '52772',
        'strMeal': 'Teriyaki Chicken Casserole',
        'strDrinkAlternate': null,
        'strCategory': 'Chicken',
        'strArea': 'Japanese',
        'strInstructions': 'Instructions go here...',
        'strMealThumb':
            'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg',
        'strTags': 'Chicken,Casserole,Teriyaki',
        'strYoutube': 'https://www.youtube.com/watch?v=someVideoId',
        'strIngredient1': 'Chicken',
        'strIngredient2': 'Soy Sauce',
        // ... other ingredients
        'strIngredient20': 'Water',
        'strMeasure1': '1 lb',
        'strMeasure2': '1/4 cup',
        // ... other measures
        'strMeasure20': '1/2 cup',
        'strSource': 'https://www.example.com/recipe',
        'strImageSource': null,
        'strCreativeCommonsConfirmed': null,
        'dateModified': null
      };

      final model = MealDataModel.fromJson(json);

      expect(model.idMeal, '52772');
      expect(model.strMeal, 'Teriyaki Chicken Casserole');
      expect(model.strDrinkAlternate, isNull);
      expect(model.strCategory, 'Chicken');
      expect(model.strArea, 'Japanese');
      expect(model.strInstructions, 'Instructions go here...');
      expect(model.strMealThumb,
          'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg');
      expect(model.strTags, 'Chicken,Casserole,Teriyaki');
      expect(model.strYoutube, 'https://www.youtube.com/watch?v=someVideoId');
      expect(model.strIngredient1, 'Chicken');
      expect(model.strIngredient2, 'Soy Sauce');
      // ... verify other ingredient properties
      expect(model.strIngredient20, 'Water');
      expect(model.strMeasure1, '1 lb');
      expect(model.strMeasure2, '1/4 cup');
      // ... verify other measure properties
      expect(model.strMeasure20, '1/2 cup');
      expect(model.strSource, 'https://www.example.com/recipe');
      expect(model.strImageSource, isNull);
      expect(model.strCreativeCommonsConfirmed, isNull);
      expect(model.dateModified, isNull);
    });

    test('MealDataModel.toJson converts a model to a JSON map', () {
      final model = MealDataModel(
          idMeal: '52772',
          strMeal: 'Teriyaki Chicken Casserole',
          strDrinkAlternate: null,
          strCategory: 'Chicken',
          strArea: 'Japanese',
          strInstructions: 'Instructions go here...',
          strMealThumb:
              'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg',
          strTags: 'Chicken,Casserole,Teriyaki',
          strYoutube: 'https://www.youtube.com/watch?v=someVideoId',
          strIngredient1: 'Chicken',
          strIngredient2: 'Soy Sauce',
          // ... set other ingredient properties
          strIngredient20: 'Water',
          strMeasure1: '1 lb',
          strMeasure2: '1/4 cup',
          // ... set other measure properties
          strMeasure20: '1/2 cup',
          strSource: 'https://www.example.com/recipe',
          strImageSource: null,
          strCreativeCommonsConfirmed: null,
          dateModified: null);
      final json = model.toJson();

      expect(json['idMeal'], '52772');
      expect(json['strMeal'], 'Teriyaki Chicken Casserole');
      expect(json['strDrinkAlternate'], null);
      expect(json['strCategory'], 'Chicken');
      expect(json['strArea'], 'Japanese');
      expect(json['strInstructions'], 'Instructions go here...');
      expect(json['strMealThumb'],
          'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg');
      expect(json['strTags'], 'Chicken,Casserole,Teriyaki');
      expect(json['strYoutube'], 'https://www.youtube.com/watch?v=someVideoId');
      expect(json['strIngredient1'], 'Chicken');
      expect(json['strIngredient2'], 'Soy Sauce');
      // ... verify other ingredient properties in JSON
      expect(json['strIngredient20'], 'Water');
      expect(json['strMeasure1'], '1 lb');
      expect(json['strMeasure2'], '1/4 cup');
      // ... verify other measure properties in JSON
      expect(json['strMeasure20'], '1/2 cup');
      expect(json['strSource'], 'https://www.example.com/recipe');
      expect(json['strImageSource'], null);
      expect(json['strCreativeCommonsConfirmed'], null);
      expect(json['dateModified'], null);
    });
  });
}
