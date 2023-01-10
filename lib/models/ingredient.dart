import 'dart:convert';

class Ingredient {
  String? _name;
  String? _unit;
  Map<String, double>? _amount;

  Ingredient(this._name, this._unit, this._amount);

  Ingredient.fromJson(Map<String, dynamic> jsonObject) {
    _name = jsonObject['name'];
    _unit = jsonObject['unit'];
    _amount = Map.castFrom(jsonObject['amount']);
  }

  String? get name => _name;
  String? get unit => _unit;
  Map<String, double>? get amount => _amount;
}