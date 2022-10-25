import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_fauzan/data/model/user_account.dart';

import '../data/api/api_service.dart';

class RegisterProvider extends ChangeNotifier {
  final ApiService apiService;

  RegisterProvider({required this.apiService}) {
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

  Future<dynamic> register(String name, String email, String password) async {
    try {
      final user = await apiService.register(name, email, password);
      if (user.data == null) {
        _message = 'Failed';
        notifyListeners();
      } else {
        return _user = user;
      }
    } catch (e) {
      _message = '$e';
      notifyListeners();
    }
  }
}
