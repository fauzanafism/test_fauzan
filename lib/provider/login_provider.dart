import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_fauzan/data/model/user_account.dart';

import '../data/api/api_service.dart';

enum LoginState { loading, failed, success, error }

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

  late LoginState _loginState;
  LoginState get loginState => _loginState;

  late UserAccount _user;
  UserAccount get user => _user;

  Future<dynamic> login(String email, String password) async {
    try {
      _loginState = LoginState.loading;
      notifyListeners();
      final user = await apiService.login(email, password);
      if (user.data == null) {
        _loginState = LoginState.failed;
        notifyListeners();
        return _message = 'Failed';
      } else {
        _loginState = LoginState.success;
        notifyListeners();
        return _user = user;
      }
    } catch (e) {
      _loginState = LoginState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
