import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_fauzan/data/model/user_account.dart';

import '../data/api/api_service.dart';

class LoginProvider extends ChangeNotifier {
  final ApiService apiService;

  LoginProvider({required this.apiService}) {
    getLoginInfo();
  }

  void getLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    _isLogin = prefs.getBool('isLogin') ?? _isLogin;
  }

  void saveLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', _isLogin);
  }

  bool _isLogin = false;
  bool get isLogin => _isLogin;

  String _message = '';
  String get message => _message;

  late UserAccount _user;
  UserAccount get user => _user;

  Future<String> login(String email, String password) async {
    try {
      final user = await apiService.login(email, password);

      return _message = user;
    } catch (e) {
      _message = '$e';
      notifyListeners();
      throw Exception();
    }
  }
}
