import 'package:flutter/material.dart';
import 'package:test_fauzan/data/model/list_user.dart';

import '../data/api/api_service.dart';

enum UserListState { loading, failed, success, error }

class HomeProvider extends ChangeNotifier {
  final ApiService apiService;

  HomeProvider({required this.apiService});

  String _message = '';
  String get message => _message;

  late UserListState _userListState;
  UserListState get userListState => _userListState;

  late ListUser _list;
  ListUser get list => _list;

  Future<dynamic> getList(String token) async {
    try {
      _userListState = UserListState.loading;
      notifyListeners();
      final user = await apiService.getListUser(token);
      if (user.data.isEmpty) {
        _userListState = UserListState.failed;
        notifyListeners();
        return _message = 'Failed';
      } else {
        _userListState = UserListState.success;
        notifyListeners();
        return _list = user;
      }
    } catch (e) {
      _userListState = UserListState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
