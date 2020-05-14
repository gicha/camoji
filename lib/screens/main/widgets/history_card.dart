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
          text: ["☹️", "🙁", "😐", "😌", "😁"][(history.emotion / 20).floor()],
        ),
        HistoryTileWidget(
          title: "Время",
          text: history.time,
        ),
        HistoryTileWidget(
          title: "Пол",
          text: history.sex ? "М" : "Ж",
        ),
        HistoryTileWidget(
          title: "Возраст",
          text: history.age.toString(),
        ),
        SizedBox(
          height: 10,
        ),
        if (withDivider) Divider(),
      ],
    );
  }
}
