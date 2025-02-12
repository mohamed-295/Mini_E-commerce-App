import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:final_project/service/connectivity_service.dart';

class HomeController extends ChangeNotifier {
  final ConnectivityService _connectivityService = ConnectivityService();
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  Stream<ConnectivityResult> get connectivityStream =>
      _connectivityService.connectivityStream;

  get notchBottomBarController => null;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<bool> checkConnectivity() async {
    return await _connectivityService.checkConnectivity();
  }

  @override
  void dispose() {
    _connectivityService.dispose();
    super.dispose();
  }
}