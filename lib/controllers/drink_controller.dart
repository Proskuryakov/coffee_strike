import 'package:coffee_strike/data/repository.dart';
import 'package:coffee_strike/models/drink.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/result.dart';

class DrinkController extends ControllerMVC {
  final Repository repository = Repository.getInstance();

  Result currentState = ResultLoading();

  void loadDrinks(int categoryId) async {
    try {
      final drinks = await repository.loadDrinksByCategoryId(categoryId);
      setState(() => currentState = DrinkResultSuccess(drinks));
    } catch (error) {
      setState(() => currentState = ResultFailure("Ошибка загрузки напитков"));
    }
  }

}