import 'package:flutter/material.dart';

class CommonAppBar {

  final String title;

  CommonAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.black12,
    );
  }

}
