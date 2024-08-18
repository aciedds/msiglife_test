import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:msiglife_test/domain/entity/meal_category/meal_category_entity.dart';
import 'package:msiglife_test/domain/entity/meal_data/meal_data.dart';
import 'package:msiglife_test/domain/entity/meal_filtered_data/meal_filtered_data_entiy.dart';
import 'package:msiglife_test/domain/usecase/add_meal_to_favorite.dart';
import 'package:msiglife_test/domain/usecase/get_detail_meal_by_id.dart';
import 'package:msiglife_test/domain/usecase/get_meal_by_category.dart';
import 'package:msiglife_test/domain/usecase/get_meal_category.dart';
import 'package:msiglife_test/domain/usecase/get_meal_existed_from_favorite.dart';
import 'package:msiglife_test/domain/usecase/get_meal_favorite.dart';
import 'package:msiglife_test/domain/usecase/remove_meal_from_favorite.dart';
import 'package:msiglife_test/state/view_state/view_state.dart';

part 'meal_bloc.freezed.dart';
part 'meal_event.dart';
part 'meal_state.dart';

@injectable
class MealBloc extends Bloc<MealEvent, MealState> {
  final GetMealCategoryUc _getMealCategory;
  final GetMealByCategoryUc _getMealByCategory;
  final GetDetailMealByIdUc _getDetailMealById;
  final AddMealToFavoriteUc _addToFavoriteUc;
  final GetMealExistedFromFavoriteUc _getMealExistedFromFavoriteUc;
  final RemoveMealFromFavoriteUc _removeMealFromFavoriteUc;
  final GetMealFavoriteUc _getMealFavoriteUc;

  MealBloc(
    this._getMealCategory,
    this._getMealByCategory,
    this._getDetailMealById,
    this._addToFavoriteUc,
    this._getMealExistedFromFavoriteUc,
    this._removeMealFromFavoriteUc,
    this._getMealFavoriteUc,
  ) : super(MealState.initial()) {
    on<MealEvent>(_mapToEvent);
  }

  Future<void> _mapToEvent(MealEvent events, Emitter<MealState> emit) async {
    await events.map(
      getMealsCategory: (value) async => await getMealsCategory(value, emit),
      getMealsListByCategory: (value) async =>
          await getMealsListByCategory(value, emit),
      getDetailMealById: (value) async => await getDetailMealById(value, emit),
      addToFavorite: (value) async => await addToFavorite(value, emit),
      getExistInFavoriteList: (value) async =>
          await getExistInFavoriteList(value, emit),
      removeFromFavorite: (value) async => removeFromFavorite(value, emit),
      getMealFavorite: (value) => getMealFavorite(value, emit),
    );
  }

  Future<void> getMealsCategory(
    MealEvent event,
    Emitter<MealState> emit,
  ) async {
    emit(state.copyWith(mealsCategoryState: const ViewState.loading()));

    final result = await _getMealCategory();
    result.when(
      success: (data) {
        emit(state.copyWith(
          mealsCategory: data,
          mealsCategoryState: ViewState.success(data: data),
        ));
      },
      error: (message, data, exception, stackTrace, statusCode) {
        emit(state.copyWith(
          mealsCategoryState: ViewState.error(message: message),
        ));
      },
    );
  }

  Future<void> getMealsListByCategory(
    GetMealsListByCategory event,
    Emitter<MealState> emit,
  ) async {
    emit(state.copyWith(
      mealsListByCategoryState: const ViewState.loading(),
    ));

    final result = await _getMealByCategory(category: event.category);
    result.when(
      success: (data) {
        emit(state.copyWith(
          mealsListByCategory: data,
          mealsListByCategoryState: ViewState.success(data: data),
        ));
      },
      error: (message, data, exception, stackTrace, statusCode) {
        emit(state.copyWith(
          mealsListByCategoryState: ViewState.error(message: message),
        ));
      },
    );
  }

  Future<void> getDetailMealById(
    GetDetailMealById event,
    Emitter<MealState> emit,
  ) async {
    emit(state.copyWith(
      mealsDataState: const ViewState.loading(),
    ));
    final result = await _getDetailMealById(idMeal: event.idMeal);

    result.when(
      success: (data) {
        emit(state.copyWith(
          mealData: data,
          mealsDataState: ViewState.success(data: data),
        ));
      },
      error: (message, data, exception, stackTrace, statusCode) {
        emit(state.copyWith(
          mealsDataState: ViewState.error(message: message),
        ));
      },
    );
  }

  Future<void> addToFavorite(
    AddToFavoriteEvent event,
    Emitter<MealState> emit,
  ) async {
    await _addToFavoriteUc(event.data);
  }

  Future<void> getExistInFavoriteList(
    GetHasExistInFavoriteEvent event,
    Emitter<MealState> emit,
  ) async {
    final result = await _getMealExistedFromFavoriteUc(event.id);
    result.when(
      success: (status) => emit(
        state.copyWith(isExistInFavorite: status),
      ),
      error: (message, data, exception, stackTrace, error) {
        emit(state.copyWith(isExistInFavorite: false));
      },
    );
  }

  Future<void> removeFromFavorite(
    RemoveFromFavoriteEvent event,
    Emitter<MealState> emit,
  ) async {
    await _removeMealFromFavoriteUc(event.id);
  }

  Future<void> getMealFavorite(
    GetMealFavoriteEvent event,
    Emitter<MealState> emit,
  ) async {
    emit(state.copyWith(favoriteListState: const ViewState.loading()));
    final result = await _getMealFavoriteUc();
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            favoriteList: data,
            favoriteListState: ViewState.success(data: data),
          ),
        );
      },
      error: (message, data, exception, stackTrace, statusCode) {
        emit(state.copyWith(
          favoriteListState: ViewState.error(message: message),
        ));
      },
    );
  }
}
