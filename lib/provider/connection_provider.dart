import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

enum DataState { noConnection, hasConnection }

class ConnectionProvider extends ChangeNotifier {
  DataState _connectionState = DataState.noConnection;
  DataState get connectionState => _connectionState;

  ConnectionProvider() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          _connectionState = DataState.hasConnection;
          break;
        case InternetConnectionStatus.disconnected:
          _connectionState = DataState.noConnection;
      }
      notifyListeners();
    });
  }
}
