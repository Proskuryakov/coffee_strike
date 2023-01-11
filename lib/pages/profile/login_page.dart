import 'package:coffee_strike/controllers/profile_controller.dart';
import 'package:coffee_strike/models/profile.dart';
import 'package:coffee_strike/models/result.dart';
import 'package:coffee_strike/pages/common/button.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

// не забываем поменять на StateMVC
class _LoginPageState extends StateMVC {

  bool _isAuth = false;
  String? _username;

  late ProfileController _controller;

  _LoginPageState() : super(ProfileController()) {
    _controller = controller as ProfileController;
  }

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final username = await _controller.getUsername();
    setState(() {
      _isAuth = username != null && username.isNotEmpty;
      _username = username;
    });
  }

  // TextEditingController'ы позволят нам получить текст из полей формы
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // _formKey нужен для валидации формы
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Профиль"),
        centerTitle: true,
        backgroundColor: Colors.black12,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (_isAuth) {
     return _buildUserInfo();
    } else {
      return _buildLoginForm();
    }
  }

  Widget _buildUserInfo() {
    return Column (
      children: [
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                      "Пользователь: $_username",
                      style: TextStyle(fontSize: 28),
                    )
                )
              ],
            ),
          ),
        ),
        Material(
          child: InkWell(
              splashColor: Colors.grey,
              onTap: () {
                _logoutPressed();
              },
              child: Button("Выход")
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                        hintText: "Логин"
                    ),
                    controller: loginController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Логин пустой";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.key),
                        hintText: "Пароль"
                    ),
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Пароль пустой";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          Material(
            child: InkWell(
                splashColor: Colors.grey,
                onTap: () {
                  _loginPressed();
                },
                child: Button("ВХОД")
            ),
          ),
        ],
      ),
    );
  }

  void _loginPressed() {
    if (_formKey.currentState!.validate()) {

      final req = LoginRequest(
          loginController.text.trim(), passwordController.text.trim()
      );
      _controller.login(req, (status) {
        if (status is ResultSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Вход выполнен успешно"))
          );
          loginController.clear();
          passwordController.clear();
          _checkAuth();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Ошибка аутентификации"))
          );
        }
      });
    }
  }

  void _logoutPressed() {
    _controller.logout();
    _checkAuth();
  }

}