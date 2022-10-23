import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_fauzan/data/model/user.dart';

class ApiService {
  static const String _baseUrl = "http://restapi.adequateshop.com/";

  Future<UserResult> getListUser() async {
    final response = await http.get(Uri.parse("${_baseUrl}api/users?page=1"));
    if (response.statusCode == 200) {
      return UserResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
