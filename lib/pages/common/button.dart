import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;

  Button(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 0.3),
      ),
      child: Center(
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 18),),
      ),
    );
  }
}
