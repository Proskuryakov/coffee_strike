import 'package:coffee_strike/controllers/shared_auth_info.dart';
import 'package:coffee_strike/data/repository.dart';
import 'package:coffee_strike/models/profile.dart';
import 'package:coffee_strike/models/result.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends ControllerMVC {
  final Repository repository = Repository.getInstance();

  Result currentState = ResultLoading();

  void login(LoginRequest loginRequest, void Function(Result) callback) async {
    try {
      final result = await repository.login(loginRequest);
      _saveUsername(result.username!);
      callback(LoginSuccess(result));
    } catch (error) {
      callback(ResultFailure("Ошибка аутентификации"));
    }
  }

  void logout() async {
    repository.logout();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
  }

  void _saveUsername(String username) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", username);
  }

  Future<String?> getUsername() async{
    return loadUsername();
  }

}