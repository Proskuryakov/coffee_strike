import 'dart:convert';

import 'package:coffee_strike/models/result.dart';

class Category {
  final int? _id;
  final String? _imageLink;
  final String? _name;

  int? get id => _id;

  String? get imageLink => _imageLink;

  String? get name => _name;

  Category(this._id, this._imageLink, this._name);

  String toJson() {
    return json.encode({"imageLink": _imageLink, "name": _name});
  }

  Category.fromJson(Map<String, dynamic> json)
      : _id = int.parse(json['id']),
        _imageLink = json["imageLink"],
        _name = json["name"];
}

class CategoryList {
  final List<Category> categories = [];

  CategoryList.fromJson(List<dynamic> jsonItems) {
    for (var jsonItem in jsonItems) {
      categories.add(Category.fromJson(jsonItem));
    }
  }
}

class CategoryResultSuccess extends ResultSuccess {
  final CategoryList categoryList;

  CategoryResultSuccess(this.categoryList);
}
