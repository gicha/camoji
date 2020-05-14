import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class HistoryTileWidget extends StatelessWidget {
  const HistoryTileWidget({
    Key key,
    this.title,
    this.text,
    this.textFontSize,
  }) : super(key: key);
  final String title;
  final String text;
  final double textFontSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: ITStyle.textBlock.copyWith(
              color: ITColors.grey,
            ),
          ),
          Text(
            text,
            style: ITStyle.textBlock.copyWith(fontSize: textFontSize ?? 16),
          ),
        ],
      ),
    );
  }
}
