import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msiglife_test/domain/entity/meal_data/meal_data.dart';
import 'package:msiglife_test/presentation/blocs/meal_bloc.dart';

class MealDetailView extends StatelessWidget {
  final MealDataEntity data;

  const MealDetailView({super.key, required this.data});

  void _onPress(BuildContext context, bool isExistedInWatchlist) {
    if (!isExistedInWatchlist) {
      context.read<MealBloc>().add(AddToFavoriteEvent(data: data));
    } else {
      context.read<MealBloc>().add(RemoveFromFavoriteEvent(id: data.idMeal));
    }

    context.read<MealBloc>()
      ..add(const GetMealFavoriteEvent())
      ..add(GetHasExistInFavoriteEvent(id: data.idMeal));
  }

  @override
  Widget build(BuildContext context) {
    bool isExistedInFavorite =
        context.watch<MealBloc>().state.isExistInFavorite;

    List<String> instructions = data.strInstructions
        .split('\r\n')
        .map((instruction) =>
            instruction.replaceFirst(RegExp(r'^\d+[\.\-]?\s*'), '').trim())
        .where((instruction) => instruction.isNotEmpty)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.read<MealBloc>()
              ..add(const GetMealFavoriteEvent())
              ..add(const GetMealsCategory());
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
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
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
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
                              margin:
                                  const EdgeInsetsDirectional.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.black26,
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
                          Text("Category: ${data.strCategory}",
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.5, // Line height
                              )),
                          const SizedBox(height: 8),
                          Text("Area: ${data.strArea}",
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.5, // Line height
                              )),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () =>
                                  _onPress(context, isExistedInFavorite),
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.white30),
                              ),
                              icon: Icon(
                                !isExistedInFavorite
                                    ? Icons.star_border
                                    : Icons.star,
                              ),
                              label: Text(
                                '${!isExistedInFavorite ? 'Add To' : 'Remove From'} Favorite',
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Ingredients and Measurements',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Table(
                            border: TableBorder.all(color: Colors.black),
                            children: [
                              const TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Ingredients',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Measures',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              for (int i = 1; i <= 20; i++)
                                if (getMeasure(i) != '' &&
                                    getIngredient(i) != '')
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(getIngredient(i) ?? ''),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(getMeasure(i) ?? ''),
                                      ),
                                    ],
                                  ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Instructions',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Table(
                            columnWidths: const {
                              0: IntrinsicColumnWidth(),
                              1: FlexColumnWidth(),
                            },
                            children: [
                              for (int i = 0; i < instructions.length; i++)
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Step ${i + 1}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        instructions[i],
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
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
    );
  }

  String getIngredient(int index) {
    switch (index) {
      case 1:
        return data.strIngredient1;
      case 2:
        return data.strIngredient2;
      case 3:
        return data.strIngredient3;
      case 4:
        return data.strIngredient4;
      case 5:
        return data.strIngredient5;
      case 6:
        return data.strIngredient6;
      case 7:
        return data.strIngredient7;
      case 8:
        return data.strIngredient8;
      case 9:
        return data.strIngredient9;
      case 10:
        return data.strIngredient10;
      case 11:
        return data.strIngredient11;
      case 12:
        return data.strIngredient12;
      case 13:
        return data.strIngredient13;
      case 14:
        return data.strIngredient14;
      case 15:
        return data.strIngredient15;
      case 16:
        return data.strIngredient16;
      case 17:
        return data.strIngredient17;
      case 18:
        return data.strIngredient18;
      case 19:
        return data.strIngredient19;
      case 20:
        return data.strIngredient20;
      default:
        return "-";
    }
  }

  String getMeasure(int index) {
    switch (index) {
      case 1:
        return data.strMeasure1;
      case 2:
        return data.strMeasure2;
      case 3:
        return data.strMeasure3;
      case 4:
        return data.strMeasure4;
      case 5:
        return data.strMeasure5;
      case 6:
        return data.strMeasure6;
      case 7:
        return data.strMeasure7;
      case 8:
        return data.strMeasure8;
      case 9:
        return data.strMeasure9;
      case 10:
        return data.strMeasure10;
      case 11:
        return data.strMeasure11;
      case 12:
        return data.strMeasure12;
      case 13:
        return data.strMeasure13;
      case 14:
        return data.strMeasure14;
      case 15:
        return data.strMeasure15;
      case 16:
        return data.strMeasure16;
      case 17:
        return data.strMeasure17;
      case 18:
        return data.strMeasure18;
      case 19:
        return data.strMeasure19;
      case 20:
        return data.strMeasure20;
      default:
        return '-';
    }
  }
}
