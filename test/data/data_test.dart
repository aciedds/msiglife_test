import './model/meal_category_model.dart' as meal_category_model;
import './model/meal_filtered_data_model.dart' as meal_filtered_data_model;
import './model/meal_data_model.dart' as meal_data_model;
import './repository/source/local/meal_local_test.dart' as meal_local;
import './repository/source/remote/meal_remote_test.dart' as meal_remote;

void main() {
  meal_category_model.main();
  meal_filtered_data_model.main();
  meal_data_model.main();
  meal_local.main();
  meal_remote.main();
}