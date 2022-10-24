import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_fauzan/data/model/user_account.dart';

import '../data/api/api_service.dart';

enum RegisterState { loading, failed, success }

class UserAccountProvider extends ChangeNotifier {
  final ApiService apiService;

  UserAccountProvider({required this.apiService}) {
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

  String _message = '';
  String get message => _message;
  
  bool _isLogin = false;
  bool get isLogin => _isLogin;

  late RegisterState _registerState;
  RegisterState get registerState => _registerState;

  late UserAccount _user;

  Future<dynamic> register(String name, String email, String password) async {
    try {
      notifyListeners();
      final user = await apiService.register(name, email, password);
      if (user.data == null) {
        _registerState = RegisterState.loading
        notifyListeners();
        return _message = 'Empty data';
      } else {
        // _resultState = ResultState.hasData;
        // notifyListeners();
        // return _restoList = resto;
      }
    } catch (_) {
      // _resultState = ResultState.error;
      // notifyListeners();
      // return _message = 'No internet connection';
    }
  }
}
