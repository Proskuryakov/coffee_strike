import 'package:coffee_strike/controllers/drink_controller.dart';
import 'package:coffee_strike/models/card_item.dart';
import 'package:coffee_strike/models/category.dart';
import 'package:coffee_strike/models/drink.dart';
import 'package:coffee_strike/models/result.dart';
import 'package:coffee_strike/pages/common/card_widget.dart';
import 'package:coffee_strike/pages/drink/drink_detail_page.dart';
import 'package:coffee_strike/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class DrinkListPage extends StatefulWidget {

  final Category category;

  DrinkListPage(this.category);

  @override
  _DrinkListPageState createState() => _DrinkListPageState();
}

class _DrinkListPageState extends StateMVC<DrinkListPage> {

  late DrinkController _controller;

  _DrinkListPageState() : super(DrinkController()) {
    _controller = controller as DrinkController;
  }

  @override
  void initState() {
    super.initState();
    _controller.loadDrinks(widget.category.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name!.capitalize()),
        centerTitle: true,
        backgroundColor: Colors.black12,
      ),
      body: _buildContent()
    );
  }

  Widget _buildContent() {
    final state = _controller.currentState;
    if (state is ResultLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is ResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.red)
        ),
      );
    } else {
      final drinks = (state as DrinkResultSuccess).drinkList.drinks;
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: drinks.length,
          itemBuilder: (context, index) {
            return CardWidget(CardItem.fromDrink(drinks[index]), DrinkDetailPage(drinks[index]));
          },
        )
      );
    }
  }

}