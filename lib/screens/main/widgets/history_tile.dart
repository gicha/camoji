import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class HistoryTileWidget extends StatelessWidget {
  const HistoryTileWidget({
    Key key,
    this.title,
    this.text,
  }) : super(key: key);
  final String title;
  final String text;
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
            style: ITStyle.textBlock,
          ),
        ],
      ),
    );
  }
}
