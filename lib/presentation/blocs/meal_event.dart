part of 'meal_bloc.dart';

@freezed
class MealEvent with _$MealEvent {
  const factory MealEvent.getMealsCategory() = _GetMealsCategory;

  const factory MealEvent.getMealsListByCategory({
    required String category,
  }) = GetMealsListByCategory;

  const factory MealEvent.getDetailMealById({
    required String idMeal,
  }) = GetDetailMealById;

  const factory MealEvent.addToFavorite({
    required MealDataEntity data,
  }) = AddToFavoriteEvent;

  const factory MealEvent.getExistInFavoriteList({
    required String id,
  }) = GetHasExistInFavoriteEvent;

  const factory MealEvent.removeFromFavorite({
    required String id,
  }) = RemoveFromFavoriteEvent;

  const factory MealEvent.getMealFavorite() = GetMealFavoriteEvent;
}
