import 'package:camoji/theme/theme.dart';
import 'package:flutter/material.dart';

class BoardingScreen extends StatefulWidget {
  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("Boarding", style: ITStyle.textGeneral),
    );
  }
}
