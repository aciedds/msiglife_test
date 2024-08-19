part of 'meal_bloc.dart';

@freezed
class MealState with _$MealState {
  const factory MealState({
    // Meals Category
    required List<MealCategoryEntity> mealsCategory,
    required ViewState<List<MealCategoryEntity>> mealsCategoryState,

    // Meals List by Category
    required List<MealFilteredDataEntity> mealsListByCategory,
    required ViewState<List<MealFilteredDataEntity>> mealsListByCategoryState,

    // Meals List by Category
    required MealDataEntity? mealData,
    required ViewState<MealDataEntity> mealsDataState,
    required bool isExistInFavorite,

    // Meals List Favorite
    required List<MealDataEntity> favoriteList,
    required ViewState<List<MealDataEntity>> favoriteListState,
  }) = _MealState;

  factory MealState.initial() => MealState(
        mealsCategory: [],
        mealsCategoryState: ViewState.initial(),
        mealsListByCategory: [],
        mealsListByCategoryState: ViewState.initial(),
        mealData: null,
        mealsDataState: ViewState.initial(),
        favoriteList: [],
        favoriteListState: ViewState.initial(),
        isExistInFavorite: false,
      );
}
