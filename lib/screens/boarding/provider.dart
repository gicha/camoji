import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AuthStatus { Start, Loading, Found }

class AuthProvider with ChangeNotifier {
  AuthStatus status = AuthStatus.Start;
  AnimationController animationController;
  Animation<double> animation;

  void startSearch() async {
    setState(AuthStatus.Loading);
    animationController.forward();
    await Future.delayed(Duration(seconds: 5));
    setState(AuthStatus.Found);
  }

  setState(AuthStatus status) {
    this.status = status;
    notifyListeners();
  }
}
