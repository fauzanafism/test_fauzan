import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_fauzan/data/model/user_account.dart';

class UserAccountProvider extends ChangeNotifier {
  UserAccountProvider() {
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

  late UserAccount _user;
}
