import 'dart:io';

import 'package:coffee_strike/data/repository.dart';
import 'package:coffee_strike/models/category.dart';
import 'package:coffee_strike/models/result.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CategoryController extends ControllerMVC {
  final Repository repository = Repository.getInstance();

  Result? currentState;

  void init() async {
    try {
      final categories = await repository.loadCategories();
      setState(() => currentState = CategoryResultSuccess(categories));
    } catch (error) {
      setState(() => currentState = ResultFailure("Ошибка загрузки категорий"));
    }
  }

  void createCategory(File imageFile, String name, Function(Result result) callback) async {
    setState(() => currentState = ResultLoading());
    try {
      Result? result = await repository.createCategory(imageFile, name);
      var res = result ?? ResultFailure("Ошибка создания категории");
      callback(res);
      setState(() => currentState = res);
    } catch (error) {
      setState(() => currentState = ResultFailure("Ошибка создания категории"));
    }
  }

}