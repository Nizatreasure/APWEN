import 'package:flutter/material.dart';

class ConnectivityProvider extends ChangeNotifier {
  bool connected = false;

  updatedConnectionStatus(bool status) {
    connected = status;
    notifyListeners();
  }
}
