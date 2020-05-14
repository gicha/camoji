import 'package:camoji/models/history.dart';
import 'package:camoji/screens/main/widgets/history_card.dart';
import 'package:camoji/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'widgets/progress.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<History> history = [
    History(10, "сегодня 18:30", false, 20),
    History(30, "сегодня 17:56", false, 13),
    History(50, "сегодня 17:41", true, 49),
    History(70, "сегодня 17:13", false, 34),
    History(90, "сегодня 16:28", true, 56),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: ITColors.white,
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 26,
              vertical: 30,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Статистика",
                      style: ITStyle.header,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .05,
                  ),
                  child: ITProgress(
                    size: MediaQuery.of(context).size.width * .7,
                    percent: 60,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Последние сканирования",
                      style: ITStyle.header,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ...List.generate(
                  history.length,
                  (index) => HistoryCardWidget(history[index], index + 1 != history.length),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
