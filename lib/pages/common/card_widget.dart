import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_strike/models/card_item.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final CardItem cardItem;
  final StatefulWidget nextWidget;

  CardWidget(this.cardItem, this.nextWidget);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        splashColor: Colors.grey,
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => nextWidget));
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                    color: Colors.grey.withOpacity(0.5), width: 0.3)),
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: CachedNetworkImage(
                    imageUrl: cardItem.imageLink!,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                      child: Text(
                    cardItem.name!,
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
                ),
              ],
            )),
      ),
    );
  }
}
