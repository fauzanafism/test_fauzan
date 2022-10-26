import 'package:flutter/material.dart';
import 'package:test_fauzan/data/model/user_account.dart';

import '../data/api/api_service.dart';

class LoginProvider extends ChangeNotifier {
  final ApiService apiService;

  LoginProvider({required this.apiService});

  String _message = '';
  String get message => _message;

  late UserAccount _user;
  UserAccount get user => _user;

  Future<dynamic> login(String email, String password) async {
    try {
      final user = await apiService.login(email, password);
      return _user = user;
    } catch (e) {
      _message = '$e';
      notifyListeners();
      throw Exception();
    }
  }
}
