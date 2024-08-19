import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msiglife_test/di/injection.dart';
import 'package:msiglife_test/presentation/blocs/meal_bloc.dart';
import 'package:msiglife_test/presentation/view/home_view.dart';

void main() async {
  await configureDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => inject<MealBloc>(),
      child: const MaterialApp(
        home: HomeView(),
      ),
    );
  }
}
