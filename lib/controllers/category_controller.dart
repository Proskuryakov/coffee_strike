import 'package:coffee_strike/data/repository.dart';
import 'package:coffee_strike/models/category.dart';
import 'package:coffee_strike/models/result.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CategoryController extends ControllerMVC {
  final Repository repository = Repository();

  Result currentState = ResultLoading();

  void init() async {
    try {
      final categories = await repository.loadCategories();
      setState(() => currentState = CategoryResultSuccess(categories));
    } catch (error) {
      setState(() => currentState = ResultFailure("Ошибка загрузки категорий"));
    }
  }

}