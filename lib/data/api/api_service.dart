import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_fauzan/data/model/register_login.dart';
import 'package:test_fauzan/data/model/user.dart';

class ApiService {
  static const String _baseUrl = "http://restapi.adequateshop.com";

  Future<RegisterLogin> register(
      String name, String email, String password) async {
    final response = await http.post(
        Uri.parse("$_baseUrl/api/authaccount/registration"),
        body: {"name": name, "email": email, "password": password});
    if (response.statusCode == 200) {
      return RegisterLogin.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<RegisterLogin> login(String email, String password) async {
    final response = await http.post(
        Uri.parse("$_baseUrl/api/authaccount/login"),
        body: {"email": email, "password": password});
    if (response.statusCode == 200) {
      return RegisterLogin.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<UserResult> getListUser() async {
    final response = await http.get(Uri.parse("${_baseUrl}api/users?page=1"));
    if (response.statusCode == 200) {
      return UserResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
