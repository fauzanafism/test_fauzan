import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_fauzan/data/model/list_user.dart';

import '../data/api/api_service.dart';

enum UserListState { loading, failed, success, error }

class HomeProvider extends ChangeNotifier {
  final ApiService apiService;

  HomeProvider({required this.apiService});

  late UserListState _userListState;
  UserListState get userListState => _userListState;

  late ListUser _list;
  ListUser get list => _list;

  String token = '';
  bool _isLogin = false;
  bool get isLogin => _isLogin;
  set isLogin(value) {
    _isLogin = value;
  }

  String _message = '';
  String get message => _message;

  int _page = 1;
  int get page => _page;
  set page(value) {
    if (_page > 0) {
      _page = value;
    } else {
      _page = 1;
    }
  }

  void getLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? token;
    _isLogin = prefs.getBool('isLogin') ?? _isLogin;
  }

  void _saveLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    _isLogin = true;

    prefs.setString('token', token);
    prefs.setBool('isLogin', _isLogin);
  }

  Future<dynamic> getList() async {
    try {
      _userListState = UserListState.loading;
      notifyListeners();
      final user =
          await apiService.getListUser(token: token, page: _page.toString());
      if (user.data.isEmpty) {
        _userListState = UserListState.failed;
        notifyListeners();
        return _message = 'Failed';
      } else {
        _userListState = UserListState.success;
        notifyListeners();
        _saveLoginInfo();
        return _list = user;
      }
    } catch (e) {
      _userListState = UserListState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
