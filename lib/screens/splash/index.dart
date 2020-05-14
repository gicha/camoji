import 'package:camoji/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: ITColors.general,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '😎  😜  🤔',
            style: ITStyle.create(fontSize: 50),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 26,
          ),
          Text(
            'Camoji',
            style: ITStyle.headerWhite,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
