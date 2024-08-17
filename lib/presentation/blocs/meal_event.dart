part of 'meal_bloc.dart';

@freezed
class MealEvent with _$MealEvent {
  const factory MealEvent.getMealsCategory() = _GetMealsCategory;

  const factory MealEvent.getMealsListByCategory({required String category}) =
      GetMealsListByCategory;

  const factory MealEvent.getDetailMealById({required String idMeal}) =
      GetDetailMealById;
}
