import 'package:coffee_strike/models/ingredient.dart';
import 'package:coffee_strike/models/result.dart';

class Drink {
  int? _id;
  String? _name;
  String? _imageLink;
  String? _description;
  String? _recipe;
  List<String>? _volumes;
  List<Ingredient>? _ingredients;
  int? _cookingTime;

  Drink(this._id, this._name, this._imageLink, this._description, this._recipe,
      this._volumes, this._ingredients, this._cookingTime);

  Drink.fromJson(Map<String, dynamic> json) {
    _id = int.parse(json['id']);
    _name = json["name"];
    _imageLink = json["imageLink"];
    _description = json["description"];
    _recipe = json["recipe"];
    _cookingTime = json["cookingTime"];
    _volumes = json["volumes"].cast<String>();
    if (json['ingredients'] != null) {
      _ingredients = <Ingredient>[];
      json['ingredients'].forEach((v) => _ingredients!.add(Ingredient.fromJson(v)));
    }
  }

  int? get cookingTime => _cookingTime;
  List<Ingredient>? get ingredients => _ingredients;
  List<String>? get volumes => _volumes;
  String? get recipe => _recipe;
  String? get description => _description;
  String? get imageLink => _imageLink;
  String? get name => _name;
  int? get id => _id;
}

class DrinkList {
  final List<Drink> drinks = [];

  DrinkList.fromJson(List<dynamic> jsonItems) {
    jsonItems.forEach((d) => drinks.add(Drink.fromJson(d)));
  }
}

class DrinkResultSuccess extends ResultSuccess {
  final DrinkList drinkList;
  DrinkResultSuccess(this.drinkList);
}