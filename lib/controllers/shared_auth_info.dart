import 'package:shared_preferences/shared_preferences.dart';

Future<String?> loadUsername() async{
  final prefs = await SharedPreferences.getInstance();
  final String? username = prefs.getString('username');
  return username;
}

Future<bool> isAuth() async{
  final prefs = await SharedPreferences.getInstance();
  final String? username = prefs.getString('username');
  return username != null && username.isNotEmpty;
}
