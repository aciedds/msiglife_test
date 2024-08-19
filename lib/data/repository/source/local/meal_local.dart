import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:msiglife_test/domain/db/meal_data_db.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'meal_local.g.dart';

@lazySingleton
@DriftDatabase(tables: [MealDataDb])
class MealLocal extends _$MealLocal {
  MealLocal() : super(_openConnection());

  MealLocal.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  // CRUD Meal
  Future<List<MealDataDbData>> getAllMealRepo() async {
    final result = await select(mealDataDb).get();
    return result;
  }

  Future<bool> getExistMealData(String idMeal) async {
    final result = await (select(mealDataDb)
          ..where((tbl) => tbl.idMeal.equals(idMeal)))
        .getSingleOrNull();

    if (result != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> insertMealData(Insertable<MealDataDbData> meal) async {
    try {
      final result = await into(mealDataDb).insert(meal);
      return result;
    } catch (e) {
      return 0;
    }
  }

  Future<int> deleteMealData(String idMeal) async {
    try {
      final result = await (delete(mealDataDb)
            ..where((tbl) => tbl.idMeal.equals(idMeal)))
          .go();
      return result;
    } catch (e) {
      return 0;
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
