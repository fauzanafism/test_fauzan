import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_fauzan/data/model/user_account.dart';
import 'package:test_fauzan/data/model/list_user.dart';

class ApiService {
  static const String _baseUrl = "http://restapi.adequateshop.com";

  Future<UserAccount> register(
      String name, String email, String password) async {
    final response = await http.post(
        Uri.parse("$_baseUrl/api/authaccount/registration"),
        body: {"name": name, "email": email, "password": password});
    if (response.statusCode == 200) {
      return UserAccount.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<UserAccount> login(String email, String password) async {
    final response = await http.post(
        Uri.parse("$_baseUrl/api/authaccount/login"),
        body: {"email": email, "password": password});
    if (response.statusCode == 200) {
      return UserAccount.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<ListUser> getListUser() async {
    final response = await http.get(Uri.parse("${_baseUrl}api/users?page=1"));
    if (response.statusCode == 200) {
      return ListUser.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
