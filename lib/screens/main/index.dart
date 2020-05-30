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
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RosProvider>(context);

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
                SizedBox(
                  height: 20,
                ),
                TitleWidget("Статистика"),
                ITProgress(
                  size: MediaQuery.of(context).size.width * .7,
                  percent: ((provider.summEmotion / provider.history.length.clamp(1, double.infinity)) ?? 0.0) * 100,
                ),
                TitleWidget("Последние сканирования"),
                SizedBox(
                  height: 20,
                ),
                ...List.generate(
                  provider.history.length,
                  (index) => HistoryCardWidget(
                    provider.history[provider.history.length - 1 - index],
                    index + 1 != provider.history.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
