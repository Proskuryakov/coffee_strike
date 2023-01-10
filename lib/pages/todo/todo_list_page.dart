import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Здесь все довольно очевидно
class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage > {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ToDo List Page"),
        ),
        body: Container()
    );
  }
}