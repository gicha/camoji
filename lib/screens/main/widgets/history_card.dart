import 'package:camoji/models/history.dart';
import 'package:camoji/screens/main/widgets/history_tile.dart';
import 'package:flutter/material.dart';

class HistoryCardWidget extends StatelessWidget {
  const HistoryCardWidget(this.history, this.withDivider);
  final History history;
  final bool withDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HistoryTileWidget(
          title: "Эмоция",
          text: ["☹️", "😐", "😁"][history.emotion.index],
          textFontSize: 25,
        ),
        HistoryTileWidget(
          title: "Время",
          text: history.time,
        ),
        SizedBox(
          height: 10,
        ),
        if (withDivider) Divider(),
      ],
    );
  }
}
