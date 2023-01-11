import 'package:coffee_strike/controllers/category_controller.dart';
import 'package:coffee_strike/models/card_item.dart';
import 'package:coffee_strike/models/category.dart';
import 'package:coffee_strike/models/result.dart';
import 'package:coffee_strike/pages/category/category_add_page.dart';
import 'package:coffee_strike/pages/common/card_widget.dart';
import 'package:coffee_strike/pages/drink/drink_list_page.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CategoryListPage extends StatefulWidget {
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends StateMVC {

  late CategoryController _controller;

  _CategoryListPageState() : super(CategoryController()) {
    _controller = controller as CategoryController;
  }

  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Категории"),
        centerTitle: true,
        backgroundColor: Colors.black12,
      ),
      body: _buildContent(),
      floatingActionButton: _buildActionButton()
    );
  }

  Widget _buildContent() {
    final state = _controller.currentState;
    if (state == null || state is ResultLoading) {
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
      final categories = (state as CategoryResultSuccess).categoryList.categories;
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CardWidget(CardItem.fromCategory(categories[index]), DrinkListPage(categories[index]));
          },
        )
      );
    }
  }

  Widget? _buildActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.black,
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CategoryAddPage()
        )).then((value) {
          if (value is ResultSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Категория успешно создана"))
            );
          }
        });
      },
    );
  }

}