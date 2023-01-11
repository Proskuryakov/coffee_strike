import 'package:coffee_strike/pages/home/home_page.dart';
import 'package:flutter/material.dart';
// выполнение приложения

// main() является главной функцией с которой начинается
// возвращает виджет приложения
void main() => runApp(MyApp());

// В Flutter все является виджетом (кнопки,списки, текст и т.д.)
// виджет - это отдельный компонент, который может быть отрисован
// на экране (не путать с Android виджетами)
// Наиболее простые виджеты наследуются от StatelessWidget класса
// и не имеют состояния
class MyApp extends StatelessWidget {



  // функция build отвечает за построение иерархии виджетов
  @override
  Widget build(BuildContext context) {
    // виджет MaterialApp - главный виджет приложения, который
    // позволяет настроить тему и использовать
    // Material Design для разработки.
    return MaterialApp(
      // заголовок приложения
      // обычно виден, когда мы сворачиваем приложение
      title: 'CoffeeStrike',
      // убираем баннер
      debugShowCheckedModeBanner: false,
      // настройка темы, мы ещё вернёмся к этому
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // указываем исходную страницу, которую мы создадим позже
      home: HomePage(),
    );
  }
}