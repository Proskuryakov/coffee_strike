import 'package:http/http.dart' as http;
import 'package:coffee_strike/config/values.dart';
import 'package:coffee_strike/models/category.dart';
import 'package:coffee_strike/models/drink.dart';
import 'dart:convert';

class Repository {

  Future<CategoryList> loadCategories() async {
    final url = Uri.parse("$API/category");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return CategoryList.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception("failed request");
    }
  }

  Future<DrinkList> loadDrinksByCategoryId(int categoryId) async {
    final url = Uri.parse("$API/drink/category/$categoryId");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return DrinkList.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception("failed request");
    }
  }

}