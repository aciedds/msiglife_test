import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msiglife_test/di/injection.dart';
import 'package:msiglife_test/presentation/blocs/meal_bloc.dart';
import 'package:msiglife_test/presentation/view/meal_detail_view.dart';
import 'package:msiglife_test/presentation/widget/meal_card_vertical.dart';
import 'package:msiglife_test/presentation/widget/meal_card_vertical_loadiing.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Screen"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<MealBloc, MealState>(
            bloc: inject<MealBloc>()..add(const MealEvent.getMealFavorite()),
            builder: (context, state) => state.favoriteListState.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              loading: () => ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                itemCount: 20,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const MealCardVerticalLoading();
                },
              ),
              success: (data) => ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MealDetailView(data: data[index]),
                    ),
                  ),
                  child: MealCardVertical(
                    title: data[index].strMeal,
                    image: data[index].strMealThumb,
                    desc: data[index].strCategory,
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
