import 'package:camoji/providers/ros.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AuthStatus { Start, Loading, StartAnimation, Found }

class AuthProvider with ChangeNotifier {
  AuthStatus status = AuthStatus.Start;
  AnimationController animationController;
  Animation<double> animation;

  void startSearch() async {
    setState(AuthStatus.Loading);
    animationController.forward();
    await Future.wait(
      [
        RosProvider().init(),
        Future.delayed(Duration(seconds: 3)),
      ],
    );
    setState(AuthStatus.StartAnimation);
    await Future.delayed(Duration(milliseconds: 1200));
    setState(AuthStatus.Found);
  }

  setState(AuthStatus status) {
    this.status = status;
    notifyListeners();
  }
}
