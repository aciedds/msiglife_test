import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msiglife_test/di/injection.dart';
import 'package:msiglife_test/presentation/blocs/meal_bloc.dart';
import 'package:msiglife_test/presentation/view/meal_category_detail_view.dart';
import 'package:msiglife_test/presentation/widget/meal_card_horizontal.dart';
import 'package:msiglife_test/presentation/widget/meal_card_horizontal_loading.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<MealBloc, MealState>(
            bloc: inject<MealBloc>()..add(const MealEvent.getMealsCategory()),
            builder: (context, state) => state.mealsCategoryState.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              loading: () => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: .65,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                itemCount: 20,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const MealCardHorizontalLoading();
                },
              ),
              success: (data) => GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: .65,
                ),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MealCategoryDetailView(
                        category: data[index].strCategory,
                      ),
                    ),
                  ),
                  child: MealCardHorizontal(
                    title: data[index].strCategory,
                    image: data[index].strMealThumb,
                  ),
                ),
              ),
            ),
            // listener: (BuildContext context, MealState state) {
            //   state.mealsListByCategoryState.maybeWhen(
            //     orElse: () => const SizedBox.shrink(),
            //     error: (message) => ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(
            //         content: Text(message),
            //       ),
            //     ),
            //   );
            // },
          ),
        ),
      ),
    );
  }
}
