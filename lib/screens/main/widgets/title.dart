import 'package:camoji/theme/theme.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: ITStyle.header,
        ),
      ],
    );
  }
}
