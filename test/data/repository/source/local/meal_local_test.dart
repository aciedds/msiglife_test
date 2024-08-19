// app_database_test.dart

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:msiglife_test/data/repository/source/local/meal_local.dart';

void main() {
  late MealLocal appDatabase;

  // Opens the database for each test.
  setUp(() {
    appDatabase = MealLocal.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await appDatabase.close();
  });
  test('insertMealData should return 1 on success', () async {
    final result = await appDatabase.insertMealData(const MealDataDbCompanion(
      idMeal: Value("52772"),
      strMeal: Value("Teriyaki Chicken Casserole"),
      strDrinkAlternate: Value(""),
      strCategory: Value("Chicken"),
      strArea: Value("Japanese"),
      strInstructions: Value(
          """Preheat oven to 350° F. Spray a 9x13-inch baking pan with non-stick spray.\r\nCombine soy sauce, ½ cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling.\r\nMeanwhile, stir together the corn starch and 2 tablespoons of water in a separate dish until smooth. Once sauce is boiling, add mixture to the saucepan and stir to combine. Cook until the sauce starts to thicken then remove from heat.\r\nPlace the chicken breasts in the prepared pan. Pour one cup of the sauce over top of chicken. Place chicken in oven and bake 35 minutes or until cooked through. Remove from oven and shred chicken in the dish using two forks.\r\n*Meanwhile, steam or cook the vegetables according to package directions.\r\nAdd the cooked vegetables and rice to the casserole dish with the chicken. Add most of the remaining sauce, reserving a bit to drizzle over the top when serving. Gently toss everything together in the casserole dish until combined. Return to oven and cook 15 minutes. Remove from oven and let stand 5 minutes before serving. Drizzle each serving with remaining sauce. Enjoy!"""),
      strMealThumb: Value(
          "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg"),
      strTags: Value("Meat,Casserole"),
      strYoutube: Value("https://www.youtube.com/watch?v=4aZr5hZXP_s"),
      strIngredient1: Value("soy sauce"),
      strIngredient2: Value("water"),
      strIngredient3: Value("brown sugar"),
      strIngredient4: Value("ground ginger"),
      strIngredient5: Value("minced garlic"),
      strIngredient6: Value("cornstarch"),
      strIngredient7: Value("chicken breasts"),
      strIngredient8: Value("stir-fry vegetables"),
      strIngredient9: Value("brown rice"),
      strIngredient10: Value(""),
      strIngredient11: Value(""),
      strIngredient12: Value(""),
      strIngredient13: Value(""),
      strIngredient14: Value(""),
      strIngredient15: Value(""),
      strIngredient16: Value(""),
      strIngredient17: Value(""),
      strIngredient18: Value(""),
      strIngredient19: Value(""),
      strIngredient20: Value(""),
      strMeasure1: Value("3/4 cup"),
      strMeasure2: Value("1/2 cup"),
      strMeasure3: Value("1/4 cup"),
      strMeasure4: Value("1/2 teaspoon"),
      strMeasure5: Value("1/2 teaspoon"),
      strMeasure6: Value("4 Tablespoons"),
      strMeasure7: Value("2"),
      strMeasure8: Value("1 (12 oz.)"),
      strMeasure9: Value("3 cups"),
      strMeasure10: Value(""),
      strMeasure11: Value(""),
      strMeasure12: Value(""),
      strMeasure13: Value(""),
      strMeasure14: Value(""),
      strMeasure15: Value(""),
      strMeasure16: Value(""),
      strMeasure17: Value(""),
      strMeasure18: Value(""),
      strMeasure19: Value(""),
      strMeasure20: Value(""),
      strSource: Value(""),
      strImageSource: Value(""),
      strCreativeCommonsConfirmed: Value(""),
      dateModified: Value(""),
    ));
    expect(result, 1);
  });

  test('getAllMealRepo should return a list of MealDataDbData on success',
      () async {
    await appDatabase.insertMealData(const MealDataDbCompanion(
      idMeal: Value("52772"),
      strMeal: Value("Teriyaki Chicken Casserole"),
      strDrinkAlternate: Value(""),
      strCategory: Value("Chicken"),
      strArea: Value("Japanese"),
      strInstructions: Value(
          """Preheat oven to 350° F. Spray a 9x13-inch baking pan with non-stick spray.\r\nCombine soy sauce, ½ cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling.\r\nMeanwhile, stir together the corn starch and 2 tablespoons of water in a separate dish until smooth. Once sauce is boiling, add mixture to the saucepan and stir to combine. Cook until the sauce starts to thicken then remove from heat.\r\nPlace the chicken breasts in the prepared pan. Pour one cup of the sauce over top of chicken. Place chicken in oven and bake 35 minutes or until cooked through. Remove from oven and shred chicken in the dish using two forks.\r\n*Meanwhile, steam or cook the vegetables according to package directions.\r\nAdd the cooked vegetables and rice to the casserole dish with the chicken. Add most of the remaining sauce, reserving a bit to drizzle over the top when serving. Gently toss everything together in the casserole dish until combined. Return to oven and cook 15 minutes. Remove from oven and let stand 5 minutes before serving. Drizzle each serving with remaining sauce. Enjoy!"""),
      strMealThumb: Value(
          "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg"),
      strTags: Value("Meat,Casserole"),
      strYoutube: Value("https://www.youtube.com/watch?v=4aZr5hZXP_s"),
      strIngredient1: Value("soy sauce"),
      strIngredient2: Value("water"),
      strIngredient3: Value("brown sugar"),
      strIngredient4: Value("ground ginger"),
      strIngredient5: Value("minced garlic"),
      strIngredient6: Value("cornstarch"),
      strIngredient7: Value("chicken breasts"),
      strIngredient8: Value("stir-fry vegetables"),
      strIngredient9: Value("brown rice"),
      strIngredient10: Value(""),
      strIngredient11: Value(""),
      strIngredient12: Value(""),
      strIngredient13: Value(""),
      strIngredient14: Value(""),
      strIngredient15: Value(""),
      strIngredient16: Value(""),
      strIngredient17: Value(""),
      strIngredient18: Value(""),
      strIngredient19: Value(""),
      strIngredient20: Value(""),
      strMeasure1: Value("3/4 cup"),
      strMeasure2: Value("1/2 cup"),
      strMeasure3: Value("1/4 cup"),
      strMeasure4: Value("1/2 teaspoon"),
      strMeasure5: Value("1/2 teaspoon"),
      strMeasure6: Value("4 Tablespoons"),
      strMeasure7: Value("2"),
      strMeasure8: Value("1 (12 oz.)"),
      strMeasure9: Value("3 cups"),
      strMeasure10: Value(""),
      strMeasure11: Value(""),
      strMeasure12: Value(""),
      strMeasure13: Value(""),
      strMeasure14: Value(""),
      strMeasure15: Value(""),
      strMeasure16: Value(""),
      strMeasure17: Value(""),
      strMeasure18: Value(""),
      strMeasure19: Value(""),
      strMeasure20: Value(""),
      strSource: Value(""),
      strImageSource: Value(""),
      strCreativeCommonsConfirmed: Value(""),
      dateModified: Value(""),
    ));
    final result = await appDatabase.getAllMealRepo();
    expect(result, isA<List<MealDataDbData>>());
    expect(result.length, 1);
  });

  test('getExistMealData should return true on success', () async {
    await appDatabase.insertMealData(const MealDataDbCompanion(
      idMeal: Value("52772"),
      strMeal: Value("Teriyaki Chicken Casserole"),
      strDrinkAlternate: Value(""),
      strCategory: Value("Chicken"),
      strArea: Value("Japanese"),
      strInstructions: Value(
          """Preheat oven to 350° F. Spray a 9x13-inch baking pan with non-stick spray.\r\nCombine soy sauce, ½ cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling.\r\nMeanwhile, stir together the corn starch and 2 tablespoons of water in a separate dish until smooth. Once sauce is boiling, add mixture to the saucepan and stir to combine. Cook until the sauce starts to thicken then remove from heat.\r\nPlace the chicken breasts in the prepared pan. Pour one cup of the sauce over top of chicken. Place chicken in oven and bake 35 minutes or until cooked through. Remove from oven and shred chicken in the dish using two forks.\r\n*Meanwhile, steam or cook the vegetables according to package directions.\r\nAdd the cooked vegetables and rice to the casserole dish with the chicken. Add most of the remaining sauce, reserving a bit to drizzle over the top when serving. Gently toss everything together in the casserole dish until combined. Return to oven and cook 15 minutes. Remove from oven and let stand 5 minutes before serving. Drizzle each serving with remaining sauce. Enjoy!"""),
      strMealThumb: Value(
          "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg"),
      strTags: Value("Meat,Casserole"),
      strYoutube: Value("https://www.youtube.com/watch?v=4aZr5hZXP_s"),
      strIngredient1: Value("soy sauce"),
      strIngredient2: Value("water"),
      strIngredient3: Value("brown sugar"),
      strIngredient4: Value("ground ginger"),
      strIngredient5: Value("minced garlic"),
      strIngredient6: Value("cornstarch"),
      strIngredient7: Value("chicken breasts"),
      strIngredient8: Value("stir-fry vegetables"),
      strIngredient9: Value("brown rice"),
      strIngredient10: Value(""),
      strIngredient11: Value(""),
      strIngredient12: Value(""),
      strIngredient13: Value(""),
      strIngredient14: Value(""),
      strIngredient15: Value(""),
      strIngredient16: Value(""),
      strIngredient17: Value(""),
      strIngredient18: Value(""),
      strIngredient19: Value(""),
      strIngredient20: Value(""),
      strMeasure1: Value("3/4 cup"),
      strMeasure2: Value("1/2 cup"),
      strMeasure3: Value("1/4 cup"),
      strMeasure4: Value("1/2 teaspoon"),
      strMeasure5: Value("1/2 teaspoon"),
      strMeasure6: Value("4 Tablespoons"),
      strMeasure7: Value("2"),
      strMeasure8: Value("1 (12 oz.)"),
      strMeasure9: Value("3 cups"),
      strMeasure10: Value(""),
      strMeasure11: Value(""),
      strMeasure12: Value(""),
      strMeasure13: Value(""),
      strMeasure14: Value(""),
      strMeasure15: Value(""),
      strMeasure16: Value(""),
      strMeasure17: Value(""),
      strMeasure18: Value(""),
      strMeasure19: Value(""),
      strMeasure20: Value(""),
      strSource: Value(""),
      strImageSource: Value(""),
      strCreativeCommonsConfirmed: Value(""),
      dateModified: Value(""),
    ));
    final result = await appDatabase.getExistMealData('52772');
    expect(result, true);
  });

  test('getExistMealData should return false on success', () async {
    await appDatabase.insertMealData(const MealDataDbCompanion(
      idMeal: Value("52772"),
      strMeal: Value("Teriyaki Chicken Casserole"),
      strDrinkAlternate: Value(""),
      strCategory: Value("Chicken"),
      strArea: Value("Japanese"),
      strInstructions: Value(
          """Preheat oven to 350° F. Spray a 9x13-inch baking pan with non-stick spray.\r\nCombine soy sauce, ½ cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling.\r\nMeanwhile, stir together the corn starch and 2 tablespoons of water in a separate dish until smooth. Once sauce is boiling, add mixture to the saucepan and stir to combine. Cook until the sauce starts to thicken then remove from heat.\r\nPlace the chicken breasts in the prepared pan. Pour one cup of the sauce over top of chicken. Place chicken in oven and bake 35 minutes or until cooked through. Remove from oven and shred chicken in the dish using two forks.\r\n*Meanwhile, steam or cook the vegetables according to package directions.\r\nAdd the cooked vegetables and rice to the casserole dish with the chicken. Add most of the remaining sauce, reserving a bit to drizzle over the top when serving. Gently toss everything together in the casserole dish until combined. Return to oven and cook 15 minutes. Remove from oven and let stand 5 minutes before serving. Drizzle each serving with remaining sauce. Enjoy!"""),
      strMealThumb: Value(
          "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg"),
      strTags: Value("Meat,Casserole"),
      strYoutube: Value("https://www.youtube.com/watch?v=4aZr5hZXP_s"),
      strIngredient1: Value("soy sauce"),
      strIngredient2: Value("water"),
      strIngredient3: Value("brown sugar"),
      strIngredient4: Value("ground ginger"),
      strIngredient5: Value("minced garlic"),
      strIngredient6: Value("cornstarch"),
      strIngredient7: Value("chicken breasts"),
      strIngredient8: Value("stir-fry vegetables"),
      strIngredient9: Value("brown rice"),
      strIngredient10: Value(""),
      strIngredient11: Value(""),
      strIngredient12: Value(""),
      strIngredient13: Value(""),
      strIngredient14: Value(""),
      strIngredient15: Value(""),
      strIngredient16: Value(""),
      strIngredient17: Value(""),
      strIngredient18: Value(""),
      strIngredient19: Value(""),
      strIngredient20: Value(""),
      strMeasure1: Value("3/4 cup"),
      strMeasure2: Value("1/2 cup"),
      strMeasure3: Value("1/4 cup"),
      strMeasure4: Value("1/2 teaspoon"),
      strMeasure5: Value("1/2 teaspoon"),
      strMeasure6: Value("4 Tablespoons"),
      strMeasure7: Value("2"),
      strMeasure8: Value("1 (12 oz.)"),
      strMeasure9: Value("3 cups"),
      strMeasure10: Value(""),
      strMeasure11: Value(""),
      strMeasure12: Value(""),
      strMeasure13: Value(""),
      strMeasure14: Value(""),
      strMeasure15: Value(""),
      strMeasure16: Value(""),
      strMeasure17: Value(""),
      strMeasure18: Value(""),
      strMeasure19: Value(""),
      strMeasure20: Value(""),
      strSource: Value(""),
      strImageSource: Value(""),
      strCreativeCommonsConfirmed: Value(""),
      dateModified: Value(""),
    ));
    final result = await appDatabase.getExistMealData('2');
    expect(result, false);
  });
}
