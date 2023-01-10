import 'package:coffee_strike/models/category.dart';
import 'package:coffee_strike/models/drink.dart';

class CardItem {
  final int? _id;
  final String? _imageLink;
  final String? _name;

  int? get id => _id;

  String? get imageLink => _imageLink;

  String? get name => _name;

  CardItem(this._id, this._imageLink, this._name);

  CardItem.fromCategory(Category category)
      : _id = category.id,
        _imageLink = category.imageLink,
        _name = category.name;

  CardItem.fromDrink(Drink drink)
      : _id = drink.id,
        _imageLink = drink.imageLink,
        _name = drink.name;
}