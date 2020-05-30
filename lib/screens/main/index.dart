import 'package:camoji/models/history.dart';
import 'package:camoji/providers/ros.dart';
import 'package:camoji/screens/main/widgets/history_card.dart';
import 'package:camoji/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme.dart';
import 'widgets/progress.dart';
import 'widgets/title.dart';

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
    var provider = Provider.of<RosProvider>(context);
    return CupertinoPageScaffold(
      backgroundColor: ITColors.white,
      child: SafeArea(
        child:
            // StreamBuilder<Object>(
            //   stream: provider..subscription,
            //   builder: (context, snapshot) {
            //     return
            Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 26,
              vertical: 30,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TitleWidget("Статистика"),
                ITProgress(
                  size: MediaQuery.of(context).size.width * .7,
                  percent: 60,
                ),
                TitleWidget("Последние сканирования"),
                SizedBox(
                  height: 20,
                ),
                ...List.generate(
                  history.length,
                  (index) => HistoryCardWidget(
                    history[index],
                    index + 1 != history.length,
                  ),
                ),
              ],
            ),
          ),
          //   );
          // },
        ),
      ),
    );
  }
}
