import 'dart:io';
import 'package:coffee_strike/models/profile.dart';
import 'package:coffee_strike/models/result.dart';
import 'package:http/http.dart' as http;
import 'package:coffee_strike/config/values.dart';
import 'package:coffee_strike/models/category.dart';
import 'package:coffee_strike/models/drink.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class Repository {

  static Repository? repo;

  static Repository getInstance() {
    repo ??= Repository();
    return repo!;
  }



  Map<String, String> headers = {};

  Future<CategoryList> loadCategories() async {
    final url = Uri.parse("$API/category");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return CategoryList.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception("failed request");
    }
  }

  Future<Result?> createCategory(File file, String name) async {
    final url = Uri.parse("$API/category");

    var request = http.MultipartRequest("POST", url);
    request.fields['params'] = json.encode({"name": name});
    request.files.add(http.MultipartFile.fromBytes('file', file.readAsBytesSync(), contentType: MediaType('image', 'jpeg')));
    request.headers.addAll(headers);

    return request.send().then((response) {
      if (response.statusCode == 200) {
        return ResultSuccess();
      } else {
        return ResultFailure("Fail");
      }
    }
    );
  }

  Future<DrinkList> loadDrinksByCategoryId(int categoryId) async {
    final url = Uri.parse("$API/drink/category/$categoryId");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return DrinkList.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception("failed request");
    }
  }

  Future<User> login(LoginRequest request) async {
    final url = Uri.parse("$API/login");

    final response = await http.post(url, body: request.toJson());
    if (response.statusCode == 200) {
      _parseCookie(response.headers['set-cookie']);
      return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception("failed request");
    }
  }

  void _parseCookie(String? cookie) {
    if (cookie != null) {
      headers['cookie'] = cookie.split(';').first.trim();
    }
  }

  void logout() async {
    final url = Uri.parse("$API/logout");
    headers.remove('cookie');
    await http.post(url);
  }

}