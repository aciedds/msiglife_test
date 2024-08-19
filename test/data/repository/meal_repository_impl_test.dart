import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:msiglife_test/data/model/meal_category/meal_category_model.dart';
import 'package:msiglife_test/data/model/meal_data/meal_data_model.dart';
import 'package:msiglife_test/data/model/meal_filtered_data/meal_filtered_data_model.dart';
import 'package:msiglife_test/data/repository/meal_repository_impl.dart';
import 'package:msiglife_test/data/repository/source/local/meal_local.dart';
import 'package:msiglife_test/data/repository/source/remote/meal_remote.dart';
import 'package:msiglife_test/domain/entity/meal_category/meal_category_entity.dart';
import 'package:msiglife_test/domain/entity/meal_data/meal_data.dart';
import 'package:msiglife_test/domain/entity/meal_filtered_data/meal_filtered_data_entiy.dart';
import 'package:msiglife_test/domain/mapper/meal_category_mapper.dart';
import 'package:msiglife_test/domain/mapper/meal_data_mapper.dart';
import 'package:msiglife_test/domain/mapper/meal_filtered_data_mapper.dart';
import 'package:msiglife_test/state/data_state/data_state.dart';

import 'meal_repository_impl_test.mocks.dart';

@GenerateMocks([
  MealRemote,
  MealLocal,
  MealCategoryMapper,
  MealFilteredDataMapper,
  MealDataMapper,
])
void main() {
  late MealRepositoryImpl mealRepository;
  late MockMealRemote mockMealRemote;
  late MockMealLocal mockMealLocal;
  late MockMealCategoryMapper mockMealCategoryMapper;
  late MockMealFilteredDataMapper mockMealFilteredDataMapper;
  late MockMealDataMapper mockMealDataMapper;

  setUp(() {
    mockMealRemote = MockMealRemote();
    mockMealLocal = MockMealLocal();
    mockMealCategoryMapper = MockMealCategoryMapper();
    mockMealFilteredDataMapper = MockMealFilteredDataMapper();
    mockMealDataMapper = MockMealDataMapper();

    mealRepository = MealRepositoryImpl(
      mockMealRemote,
      mockMealLocal,
      mockMealCategoryMapper,
      mockMealFilteredDataMapper,
      mockMealDataMapper,
    );
  });

  group('getListMealByCategory', () {
    test('should return DataState.success when remote call is successful',
        () async {
      final mealModelList = [
        MealFilteredDataModel(
          idMeal: '1',
          strMeal: 'Beef',
          strMealThumb: 'https://example.com/beef.jpg',
        ),
        MealFilteredDataModel(
          idMeal: '2',
          strMeal: 'Chicken',
          strMealThumb: 'https://example.com/chicken.jpg',
        ),
      ];

      when(mockMealRemote.getListMealByCategory(category: anyNamed('category')))
          .thenAnswer((_) async => DataState.success(data: mealModelList));
      when(mockMealFilteredDataMapper.toEntity(any))
          .thenReturn(MealFilteredDataEntity(
        idMeal: '1',
        strMeal: 'Beef',
        strMealThumb: 'https://example.com/beef.jpg',
      ));

      final result =
          await mealRepository.getListMealByCategory(category: 'Seafood');
      result.when(
          success: (data) {
            expect(data, isA<List<MealFilteredDataEntity>>());
            expect(data.length, 2);
          },
          error: (message, data, exception, stackTrace, statusCode) {});
    });

    test('should return DataState.error when remote call fails', () async {
      when(mockMealRemote.getListMealByCategory(category: anyNamed('category')))
          .thenAnswer((_) async => const DataState.error(message: 'Error'));

      final result =
          await mealRepository.getListMealByCategory(category: 'Seafood');
      result.when(
          success: (data) {},
          error: (message, data, exception, stackTrace, statusCode) {
            expect(message, 'Error');
          });
    });
  });

  group('getListMealByFirstLetter', () {
    test('should return DataState.success when remote call is successful',
        () async {
      final mealModelList = [
        MealFilteredDataModel(
          idMeal: '1',
          strMeal: 'Beef',
          strMealThumb: 'https://example.com/beef.jpg',
        ),
        MealFilteredDataModel(
          idMeal: '2',
          strMeal: 'Chicken',
          strMealThumb: 'https://example.com/chicken.jpg',
        ),
      ];

      when(mockMealRemote.getListMealByFirstLetter(
              firstLetter: anyNamed('firstLetter')))
          .thenAnswer((_) async => DataState.success(data: mealModelList));
      when(mockMealFilteredDataMapper.toEntity(any)).thenReturn(
        MealFilteredDataEntity(
          idMeal: '1',
          strMeal: 'Beef',
          strMealThumb: 'https://example.com/beef.jpg',
        ),
      );

      final result =
          await mealRepository.getListMealByFirstLetter(firstLetter: 'S');

      result.when(
          success: (data) {
            expect(data, isA<List<MealFilteredDataEntity>>());
            expect(data.length, 2);
          },
          error: (message, data, exception, stackTrace, statusCode) {});
    });

    test('should return DataState.error when remote call fails', () async {
      when(mockMealRemote.getListMealByFirstLetter(
              firstLetter: anyNamed('firstLetter')))
          .thenAnswer((_) async => const DataState.error(message: 'Error'));

      final result =
          await mealRepository.getListMealByFirstLetter(firstLetter: 'S');

      result.when(
          success: (data) {},
          error: (message, data, exception, stackTrace, statusCode) {
            expect(message, 'Error');
          });
    });
  });

  group('getMealById', () {
    test('should return DataState.success when remote call is successful',
        () async {
      final mealModel = MealDataModel(
        idMeal: '123',
        strMeal: 'Beef',
        strDrinkAlternate: "",
        strCategory: 'Beef',
        strArea: 'American',
        strInstructions:
            """Season the beef with salt and pepper. Heat a large skillet over medium-high heat. Add the beef and cook until browned on all sides. Remove beef from the skillet. In the same skillet, add onions and garlic, cooking until softened. Return the beef to the skillet and add beef broth, Worcestershire sauce, and thyme. Simmer until the beef is tender and the sauce has thickened. Serve hot.""",
        strMealThumb: 'https://example.com/beef.jpg',
        strTags: 'Main Course,Beef',
        strYoutube: 'https://www.youtube.com/watch?v=example',
        strIngredient1: 'Beef',
        strIngredient2: 'Onion',
        strIngredient3: 'Garlic',
        strIngredient4: 'Beef broth',
        strIngredient5: 'Worcestershire sauce',
        strIngredient6: 'Thyme',
        strIngredient7: 'Salt',
        strIngredient8: 'Pepper',
        strIngredient9: "",
        strIngredient10: "",
        strIngredient11: "",
        strIngredient12: "",
        strIngredient13: "",
        strIngredient14: "",
        strIngredient15: "",
        strIngredient16: "",
        strIngredient17: "",
        strIngredient18: "",
        strIngredient19: "",
        strIngredient20: "",
        strMeasure1: '500g',
        strMeasure2: '1',
        strMeasure3: '2 cloves',
        strMeasure4: '2 cups',
        strMeasure5: '2 tablespoons',
        strMeasure6: '1 teaspoon',
        strMeasure7: 'To taste',
        strMeasure8: 'To taste',
        strMeasure9: "",
        strMeasure10: "",
        strMeasure11: "",
        strMeasure12: "",
        strMeasure13: "",
        strMeasure14: "",
        strMeasure15: "",
        strMeasure16: "",
        strMeasure17: "",
        strMeasure18: "",
        strMeasure19: "",
        strMeasure20: "",
        strSource: 'https://example-recipe-source.com',
        strImageSource: "",
        strCreativeCommonsConfirmed: "",
        dateModified: "",
      );
      final mealEntity = MealDataEntity(
        idMeal: '123',
        strMeal: 'Beef',
        strDrinkAlternate: "",
        strCategory: 'Beef',
        strArea: 'American',
        strInstructions:
            """Season the beef with salt and pepper. Heat a large skillet over medium-high heat. Add the beef and cook until browned on all sides. Remove beef from the skillet. In the same skillet, add onions and garlic, cooking until softened. Return the beef to the skillet and add beef broth, Worcestershire sauce, and thyme. Simmer until the beef is tender and the sauce has thickened. Serve hot.""",
        strMealThumb: 'https://example.com/beef.jpg',
        strTags: 'Main Course,Beef',
        strYoutube: 'https://www.youtube.com/watch?v=example',
        strIngredient1: 'Beef',
        strIngredient2: 'Onion',
        strIngredient3: 'Garlic',
        strIngredient4: 'Beef broth',
        strIngredient5: 'Worcestershire sauce',
        strIngredient6: 'Thyme',
        strIngredient7: 'Salt',
        strIngredient8: 'Pepper',
        strIngredient9: "",
        strIngredient10: "",
        strIngredient11: "",
        strIngredient12: "",
        strIngredient13: "",
        strIngredient14: "",
        strIngredient15: "",
        strIngredient16: "",
        strIngredient17: "",
        strIngredient18: "",
        strIngredient19: "",
        strIngredient20: "",
        strMeasure1: '500g',
        strMeasure2: '1',
        strMeasure3: '2 cloves',
        strMeasure4: '2 cups',
        strMeasure5: '2 tablespoons',
        strMeasure6: '1 teaspoon',
        strMeasure7: 'To taste',
        strMeasure8: 'To taste',
        strMeasure9: "",
        strMeasure10: "",
        strMeasure11: "",
        strMeasure12: "",
        strMeasure13: "",
        strMeasure14: "",
        strMeasure15: "",
        strMeasure16: "",
        strMeasure17: "",
        strMeasure18: "",
        strMeasure19: "",
        strMeasure20: "",
        strSource: 'https://example-recipe-source.com',
        strImageSource: "",
        strCreativeCommonsConfirmed: "",
        dateModified: "",
      );

      when(mockMealRemote.getMealById(idMeal: anyNamed('idMeal')))
          .thenAnswer((_) async => DataState.success(data: mealModel));
      when(mockMealDataMapper.fromModelToEntity(any)).thenReturn(mealEntity);

      final result = await mealRepository.getMealById(idMeal: '123');
      result.when(
        success: (data) {
          expect(data, isA<MealDataEntity>());
          expect(data, mealEntity);
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('should return DataState.error when remote call fails', () async {
      when(mockMealRemote.getMealById(idMeal: anyNamed('idMeal')))
          .thenAnswer((_) async => const DataState.error(message: 'Error'));

      final result = await mealRepository.getMealById(idMeal: '123');

      result.when(
          success: (data) {},
          error: (message, data, exception, stackTrace, statusCode) {
            expect(message, 'Error');
          });
    });
  });

  group('getMealCategory', () {
    test('should return DataState.success when remote call is successful',
        () async {
      final mealCategoryModelList = [
        MealCategoryModel(
          idCategory: '1',
          strCategory: 'Beef',
          strCategoryDescription: 'Beef',
          strCategoryThumb: 'https://example.com/beef.jpg',
        ),
        MealCategoryModel(
          idCategory: '2',
          strCategory: 'Beef',
          strCategoryDescription: 'Beef',
          strCategoryThumb: 'https://example.com/beef.jpg',
        ),
      ];
      final mealCategoryEntityList = [
        MealCategoryEntity(
          idCategory: '1',
          strCategory: 'Beef',
          strCategoryDescription: 'Beef',
          strMealThumb: 'https://example.com/beef.jpg',
        ),
        MealCategoryEntity(
          idCategory: '1',
          strCategory: 'Beef',
          strCategoryDescription: 'Beef',
          strMealThumb: 'https://example.com/beef.jpg',
        ),
      ];

      when(mockMealRemote.getMealCategory()).thenAnswer(
          (_) async => DataState.success(data: mealCategoryModelList));
      when(mockMealCategoryMapper.fromModelToEntity(any)).thenReturn(
        MealCategoryEntity(
          idCategory: '1',
          strCategory: 'Beef',
          strCategoryDescription: 'Beef',
          strMealThumb: 'https://example.com/beef.jpg',
        ),
      );

      final result = await mealRepository.getMealCategory();
      result.when(
        success: (data) {
          expect(data, isA<List<MealCategoryEntity>>());
          expect(data, mealCategoryEntityList);
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('should return DataState.error when remote call fails', () async {
      when(mockMealRemote.getMealCategory())
          .thenAnswer((_) async => const DataState.error(message: 'Error'));

      final result = await mealRepository.getMealCategory();
      result.when(
        success: (data) {},
        error: (message, data, exception, stackTrace, statusCode) {
          expect(message, 'Error');
        },
      );
    });
  });

  group('addToFavorite', () {
    test('should return DataState.success when local call is successful',
        () async {
      when(mockMealLocal.insertMealData(any)).thenAnswer((_) async => 1);

      final result = await mealRepository.addToFavorite(
        MealDataEntity(
          idMeal: '123',
          strMeal: 'Beef',
          strDrinkAlternate: "",
          strCategory: 'Beef',
          strArea: 'American',
          strInstructions:
              """Season the beef with salt and pepper. Heat a large skillet over medium-high heat. Add the beef and cook until browned on all sides. Remove beef from the skillet. In the same skillet, add onions and garlic, cooking until softened. Return the beef to the skillet and add beef broth, Worcestershire sauce, and thyme. Simmer until the beef is tender and the sauce has thickened. Serve hot.""",
          strMealThumb: 'https://example.com/beef.jpg',
          strTags: 'Main Course,Beef',
          strYoutube: 'https://www.youtube.com/watch?v=example',
          strIngredient1: 'Beef',
          strIngredient2: 'Onion',
          strIngredient3: 'Garlic',
          strIngredient4: 'Beef broth',
          strIngredient5: 'Worcestershire sauce',
          strIngredient6: 'Thyme',
          strIngredient7: 'Salt',
          strIngredient8: 'Pepper',
          strIngredient9: "",
          strIngredient10: "",
          strIngredient11: "",
          strIngredient12: "",
          strIngredient13: "",
          strIngredient14: "",
          strIngredient15: "",
          strIngredient16: "",
          strIngredient17: "",
          strIngredient18: "",
          strIngredient19: "",
          strIngredient20: "",
          strMeasure1: '500g',
          strMeasure2: '1',
          strMeasure3: '2 cloves',
          strMeasure4: '2 cups',
          strMeasure5: '2 tablespoons',
          strMeasure6: '1 teaspoon',
          strMeasure7: 'To taste',
          strMeasure8: 'To taste',
          strMeasure9: "",
          strMeasure10: "",
          strMeasure11: "",
          strMeasure12: "",
          strMeasure13: "",
          strMeasure14: "",
          strMeasure15: "",
          strMeasure16: "",
          strMeasure17: "",
          strMeasure18: "",
          strMeasure19: "",
          strMeasure20: "",
          strSource: 'https://example-recipe-source.com',
          strImageSource: "",
          strCreativeCommonsConfirmed: "",
          dateModified: "",
        ),
      );
      result.when(
        success: (data) {
          expect(data, isA<bool>());
          expect(data, true);
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('should return DataState.error when local call fails', () async {
      when(mockMealLocal.insertMealData(any)).thenThrow(Exception('Error'));

      final result = await mealRepository.addToFavorite(
        MealDataEntity(
          idMeal: '123',
          strMeal: 'Beef',
          strDrinkAlternate: "",
          strCategory: 'Beef',
          strArea: 'American',
          strInstructions:
              """Season the beef with salt and pepper. Heat a large skillet over medium-high heat. Add the beef and cook until browned on all sides. Remove beef from the skillet. In the same skillet, add onions and garlic, cooking until softened. Return the beef to the skillet and add beef broth, Worcestershire sauce, and thyme. Simmer until the beef is tender and the sauce has thickened. Serve hot.""",
          strMealThumb: 'https://example.com/beef.jpg',
          strTags: 'Main Course,Beef',
          strYoutube: 'https://www.youtube.com/watch?v=example',
          strIngredient1: 'Beef',
          strIngredient2: 'Onion',
          strIngredient3: 'Garlic',
          strIngredient4: 'Beef broth',
          strIngredient5: 'Worcestershire sauce',
          strIngredient6: 'Thyme',
          strIngredient7: 'Salt',
          strIngredient8: 'Pepper',
          strIngredient9: "",
          strIngredient10: "",
          strIngredient11: "",
          strIngredient12: "",
          strIngredient13: "",
          strIngredient14: "",
          strIngredient15: "",
          strIngredient16: "",
          strIngredient17: "",
          strIngredient18: "",
          strIngredient19: "",
          strIngredient20: "",
          strMeasure1: '500g',
          strMeasure2: '1',
          strMeasure3: '2 cloves',
          strMeasure4: '2 cups',
          strMeasure5: '2 tablespoons',
          strMeasure6: '1 teaspoon',
          strMeasure7: 'To taste',
          strMeasure8: 'To taste',
          strMeasure9: "",
          strMeasure10: "",
          strMeasure11: "",
          strMeasure12: "",
          strMeasure13: "",
          strMeasure14: "",
          strMeasure15: "",
          strMeasure16: "",
          strMeasure17: "",
          strMeasure18: "",
          strMeasure19: "",
          strMeasure20: "",
          strSource: 'https://example-recipe-source.com',
          strImageSource: "",
          strCreativeCommonsConfirmed: "",
          dateModified: "",
        ),
      );
      result.when(
        success: (data) {},
        error: (message, data, exception, stackTrace, statusCode) {
          expect(message, contains('MissingStubError'));
        },
      );
    });
  });

  group('getHasExistInFavorite', () {
    test('should return DataState.success when local call is successful',
        () async {
      when(mockMealLocal.getExistMealData(any)).thenAnswer((_) async => true);

      final result = await mealRepository.getHasExistInFavorite('123');
      result.when(
        success: (data) {
          expect(data, isA<bool>());
          expect(data, true);
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('should return DataState.error when local call fails', () async {
      when(mockMealLocal.getExistMealData(any)).thenThrow(Exception('Error'));

      final result = await mealRepository.getHasExistInFavorite('123');
      result.when(
        success: (data) {},
        error: (message, data, exception, stackTrace, statusCode) {
          expect(message, contains('Exception'));
        },
      );
    });
  });

  group('removeFromFavorite', () {
    test('should return DataState.success when local call is successful',
        () async {
      when(mockMealLocal.deleteMealData(any)).thenAnswer((_) async => 1);

      final result = await mealRepository.removeFromFavorite('123');
      result.when(
        success: (data) {
          expect(data, isA<bool>());
          expect(data, true);
        },
        error: (message, data, exception, stackTrace, statusCode) {},
      );
    });

    test('should return DataState.error when local call fails', () async {
      when(mockMealLocal.deleteMealData(any)).thenThrow(Exception('Error'));

      final result = await mealRepository.removeFromFavorite('123');
      result.when(
        success: (data) {},
        error: (message, data, exception, stackTrace, statusCode) {
          expect(message, contains('Exception'));
        },
      );
    });
  });

  group('getFavoriteList', () {
    test('should return DataState.success when local call is successful',
        () async {
      Future<List<MealDataDbData>> mealDataModelList = Future.value([
        const MealDataDbData(
          id: 1,
          idMeal: '123',
          strMeal: 'Beef',
          strDrinkAlternate: "",
          strCategory: 'Beef',
          strArea: 'American',
          strInstructions:
              """Season the beef with salt and pepper. Heat a large skillet over medium-high heat. Add the beef and cook until browned on all sides. Remove beef from the skillet. In the same skillet, add onions and garlic, cooking until softened. Return the beef to the skillet and add beef broth, Worcestershire sauce, and thyme. Simmer until the beef is tender and the sauce has thickened. Serve hot.""",
          strMealThumb: 'https://example.com/beef.jpg',
          strTags: 'Main Course,Beef',
          strYoutube: 'https://www.youtube.com/watch?v=example',
          strIngredient1: 'Beef',
          strIngredient2: 'Onion',
          strIngredient3: 'Garlic',
          strIngredient4: 'Beef broth',
          strIngredient5: 'Worcestershire sauce',
          strIngredient6: 'Thyme',
          strIngredient7: 'Salt',
          strIngredient8: 'Pepper',
          strIngredient9: "",
          strIngredient10: "",
          strIngredient11: "",
          strIngredient12: "",
          strIngredient13: "",
          strIngredient14: "",
          strIngredient15: "",
          strIngredient16: "",
          strIngredient17: "",
          strIngredient18: "",
          strIngredient19: "",
          strIngredient20: "",
          strMeasure1: '500g',
          strMeasure2: '1',
          strMeasure3: '2 cloves',
          strMeasure4: '2 cups',
          strMeasure5: '2 tablespoons',
          strMeasure6: '1 teaspoon',
          strMeasure7: 'To taste',
          strMeasure8: 'To taste',
          strMeasure9: "",
          strMeasure10: "",
          strMeasure11: "",
          strMeasure12: "",
          strMeasure13: "",
          strMeasure14: "",
          strMeasure15: "",
          strMeasure16: "",
          strMeasure17: "",
          strMeasure18: "",
          strMeasure19: "",
          strMeasure20: "",
          strSource: 'https://example-recipe-source.com',
          strImageSource: "",
          strCreativeCommonsConfirmed: "",
          dateModified: "",
        )
      ]);
      final mealDataEntityList = [
        MealDataEntity(
          idMeal: '123',
          strMeal: 'Beef',
          strDrinkAlternate: "",
          strCategory: 'Beef',
          strArea: 'American',
          strInstructions:
              """Season the beef with salt and pepper. Heat a large skillet over medium-high heat. Add the beef and cook until browned on all sides. Remove beef from the skillet. In the same skillet, add onions and garlic, cooking until softened. Return the beef to the skillet and add beef broth, Worcestershire sauce, and thyme. Simmer until the beef is tender and the sauce has thickened. Serve hot.""",
          strMealThumb: 'https://example.com/beef.jpg',
          strTags: 'Main Course,Beef',
          strYoutube: 'https://www.youtube.com/watch?v=example',
          strIngredient1: 'Beef',
          strIngredient2: 'Onion',
          strIngredient3: 'Garlic',
          strIngredient4: 'Beef broth',
          strIngredient5: 'Worcestershire sauce',
          strIngredient6: 'Thyme',
          strIngredient7: 'Salt',
          strIngredient8: 'Pepper',
          strIngredient9: "",
          strIngredient10: "",
          strIngredient11: "",
          strIngredient12: "",
          strIngredient13: "",
          strIngredient14: "",
          strIngredient15: "",
          strIngredient16: "",
          strIngredient17: "",
          strIngredient18: "",
          strIngredient19: "",
          strIngredient20: "",
          strMeasure1: '500g',
          strMeasure2: '1',
          strMeasure3: '2 cloves',
          strMeasure4: '2 cups',
          strMeasure5: '2 tablespoons',
          strMeasure6: '1 teaspoon',
          strMeasure7: 'To taste',
          strMeasure8: 'To taste',
          strMeasure9: "",
          strMeasure10: "",
          strMeasure11: "",
          strMeasure12: "",
          strMeasure13: "",
          strMeasure14: "",
          strMeasure15: "",
          strMeasure16: "",
          strMeasure17: "",
          strMeasure18: "",
          strMeasure19: "",
          strMeasure20: "",
          strSource: 'https://example-recipe-source.com',
          strImageSource: "",
          strCreativeCommonsConfirmed: "",
          dateModified: "",
        ),
      ];

      when(mockMealLocal.getAllMealRepo()).thenAnswer((_) => mealDataModelList);
      when(mockMealDataMapper.fromDbToEntity(any)).thenReturn(
        MealDataEntity(
          idMeal: '123',
          strMeal: 'Beef',
          strDrinkAlternate: "",
          strCategory: 'Beef',
          strArea: 'American',
          strInstructions:
              """Season the beef with salt and pepper. Heat a large skillet over medium-high heat. Add the beef and cook until browned on all sides. Remove beef from the skillet. In the same skillet, add onions and garlic, cooking until softened. Return the beef to the skillet and add beef broth, Worcestershire sauce, and thyme. Simmer until the beef is tender and the sauce has thickened. Serve hot.""",
          strMealThumb: 'https://example.com/beef.jpg',
          strTags: 'Main Course,Beef',
          strYoutube: 'https://www.youtube.com/watch?v=example',
          strIngredient1: 'Beef',
          strIngredient2: 'Onion',
          strIngredient3: 'Garlic',
          strIngredient4: 'Beef broth',
          strIngredient5: 'Worcestershire sauce',
          strIngredient6: 'Thyme',
          strIngredient7: 'Salt',
          strIngredient8: 'Pepper',
          strIngredient9: "",
          strIngredient10: "",
          strIngredient11: "",
          strIngredient12: "",
          strIngredient13: "",
          strIngredient14: "",
          strIngredient15: "",
          strIngredient16: "",
          strIngredient17: "",
          strIngredient18: "",
          strIngredient19: "",
          strIngredient20: "",
          strMeasure1: '500g',
          strMeasure2: '1',
          strMeasure3: '2 cloves',
          strMeasure4: '2 cups',
          strMeasure5: '2 tablespoons',
          strMeasure6: '1 teaspoon',
          strMeasure7: 'To taste',
          strMeasure8: 'To taste',
          strMeasure9: "",
          strMeasure10: "",
          strMeasure11: "",
          strMeasure12: "",
          strMeasure13: "",
          strMeasure14: "",
          strMeasure15: "",
          strMeasure16: "",
          strMeasure17: "",
          strMeasure18: "",
          strMeasure19: "",
          strMeasure20: "",
          strSource: 'https://example-recipe-source.com',
          strImageSource: "",
          strCreativeCommonsConfirmed: "",
          dateModified: "",
        ),
      );

      final result = await mealRepository.getFavoriteList();
      result.when(
        success: (data) {
          expect(data, isA<List<MealDataEntity>>());
          expect(data, mealDataEntityList);
        },
        error: (message, data, exception, stackTrace, statusCode) {
          expect(message, 'Error');
        },
      );
    });

    test('should return DataState.error when local call fails', () async {
      when(mockMealLocal.getAllMealRepo()).thenThrow(Exception('Error'));

      final result = await mealRepository.getFavoriteList();
      result.when(
        success: (data) {},
        error: (message, data, exception, stackTrace, statusCode) {
          expect(message, contains('Exception'));
        },
      );
    });
  });
}
