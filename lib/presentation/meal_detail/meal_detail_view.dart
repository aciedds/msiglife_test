import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msiglife_test/di/injection.dart';
import 'package:msiglife_test/presentation/blocs/meal_bloc.dart';

class MealDetailView extends StatelessWidget {
  final String mealId;

  const MealDetailView({
    super.key,
    required this.mealId,
  });

  // void _onPress(BuildContext context, bool isExistedInWatchlist) {
  //   if (!isExistedInWatchlist) {
  //     context.read<FilmBloc>().add(AddToWatchlistEvent(type: type, film: film));
  //   } else {
  //     context
  //         .read<FilmBloc>()
  //         .add(RemoveFilmFromWatchlistEvent(type: type, id: film.id));
  //   }
  //
  //   context.read<FilmBloc>()
  //     ..add(GetWatchlistEvent(type: type))
  //     ..add(WatchlistCheckEvent(thisFilm: film));
  // }

  @override
  Widget build(BuildContext context) {
    // bool isExistedInWatchlist =
    //     context.watch<FilmBloc>().state.isExistedInWatchlist;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<MealBloc, MealState>(
        bloc: inject<MealBloc>()
          ..add(MealEvent.getDetailMealById(idMeal: mealId)),
        builder: (context, state) => state.mealsDataState.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error) => Text(error),
          success: (data) => Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                data.strMealThumb,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 200),
                child: DraggableScrollableSheet(
                  minChildSize: 0.4,
                  builder: (context, scrollController) {
                    return Container(
                      color: Colors.black87,
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  height: 5,
                                  width: 80,
                                  margin: const EdgeInsetsDirectional.only(
                                      bottom: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white54,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              Text(
                                data.strMeal,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  // onPressed: () =>
                                  //     _onPress(context, isExistedInWatchlist),
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all(Colors.white30),
                                  ),
                                  icon: Icon(
                                    // isExistedInWatchlist ? Icons.check : Icons.add,
                                    Icons.add,
                                  ),
                                  label: Text(
                                    // '${isExistedInWatchlist ? 'Added' : 'Add'} To Watchlist',
                                    'Add To Favorite',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text('Instructions'),
                              const SizedBox(height: 8),
                              Text(data.strInstructions),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
