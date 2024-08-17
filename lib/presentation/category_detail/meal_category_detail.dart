import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msiglife_test/di/injection.dart';
import 'package:msiglife_test/presentation/blocs/meal_bloc.dart';
import 'package:msiglife_test/presentation/meal_detail/meal_detail_view.dart';
import 'package:msiglife_test/presentation/widget/meal_card_horizontal.dart';
import 'package:msiglife_test/presentation/widget/meal_card_horizontal_loading.dart';

class MealCategoryDetail extends StatelessWidget {
  final String category;

  const MealCategoryDetail({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<MealBloc, MealState>(
            bloc: inject<MealBloc>()
              ..add(
                MealEvent.getMealsListByCategory(category: category),
              ),
            builder: (context, state) =>
                state.mealsListByCategoryState.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              loading: () => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: .65,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                itemCount: 6,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const MealCardHorizontalLoading();
                },
              ),
              success: (data) => GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: .65,
                ),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealDetailView(
                          mealId: data[index].idMeal,
                        ),
                      ),
                    );
                  },
                  child: MealCardHorizontal(
                    title: data[index].strMeal,
                    image: data[index].strMealThumb,
                  ),
                ),
              ),
            ),
            listener: (BuildContext context, MealState state) {
              state.mealsListByCategoryState.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                error: (message) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
