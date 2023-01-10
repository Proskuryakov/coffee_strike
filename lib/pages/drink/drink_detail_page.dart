import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_strike/controllers/drink_controller.dart';
import 'package:coffee_strike/models/drink.dart';
import 'package:coffee_strike/models/ingredient.dart';
import 'package:coffee_strike/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class DrinkDetailPage extends StatefulWidget {
  final Drink drink;

  DrinkDetailPage(this.drink);

  @override
  _DrinkDetailPageState createState() => _DrinkDetailPageState();
}

class _DrinkDetailPageState extends StateMVC<DrinkDetailPage> {
  late DrinkController _controller;
  String? selectedValue;

  _DrinkDetailPageState() : super(DrinkController()) {
    _controller = controller as DrinkController;
  }

  @override
  void initState() {
    super.initState();
    selectedValue = widget.drink.volumes![0];
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry commonMargin = const EdgeInsets.only(bottom: 20);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drink.name!.capitalize()),
        centerTitle: true,
        backgroundColor: Colors.black12,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration:
                  const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),
                margin: commonMargin,
                child: CachedNetworkImage(
                  imageUrl: widget.drink.imageLink!,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Container(
                margin: commonMargin,
                child: Row(
                  children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            const TextSpan(
                              text: 'Описание: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: widget.drink.description!),
                          ],
                        ),
                      )
                    )
                  ],
                )
              ),
              Container(
                margin: commonMargin,
                child: Row(
                  children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            const TextSpan(
                              text: 'Время приготовления: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: widget.drink.cookingTime!.toString()),
                            TextSpan(text: " мин")
                          ],
                        ),
                      )
                    )
                  ],
                )
              ),

              Container(
                margin: commonMargin,
                child: Row(
                  children: [
                    const Text("Объем:", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    DropdownButton(
                      value: selectedValue,
                      items: _dropdownItems(widget.drink.volumes!),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                    )
                  ],
                )
              ),
              Container(
                margin: commonMargin,
                child: Table(
                  border: TableBorder.all(),
                  children: _getRows(widget.drink.ingredients!, selectedValue!),
                )
              ),Container(
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: const Center(
                            child: Text("Рецепт", style: TextStyle(fontSize: 18)),
                          )
                      ),
                      Row(
                        children: [Flexible(child: Text(widget.drink.recipe!))],
                      )
                    ],
                  )
              ),
            ],
          )),
      ));
  }

  List<DropdownMenuItem<String>> _dropdownItems(List<String> items) {
    List<DropdownMenuItem<String>> menuItems = <DropdownMenuItem<String>>[];
    for (var item in items) {
      menuItems.add(DropdownMenuItem(value: item, child: Text("$item мл")));
    }
    return menuItems;
  }

  List<TableRow> _getRows(List<Ingredient> ingredients, String currentVolume) {
    List<TableRow> rows = <TableRow>[];
    rows.add(const TableRow(children: [
      Padding(
        padding: EdgeInsets.all(5),
        child: Text(
            'ПРОДУКТ',
            textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)
        )
      ),
      Padding(
        padding: EdgeInsets.all(5),
        child: Text(
            'КОЛ-ВО',
            textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)
        )
      )
    ]));
    for (var ingredient in ingredients) {
      rows.add(TableRow(children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: Text(ingredient.name!)),
        Padding(
          padding: EdgeInsets.all(5),
          child: Text("${ingredient.amount![currentVolume]} ${ingredient.unit}"))
      ]));
    }
    return rows;
  }
}
