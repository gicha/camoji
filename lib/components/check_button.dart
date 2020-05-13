import 'package:flutter/material.dart';
import 'package:camoji/theme/theme.dart';

class CheckButtonWidget extends StatelessWidget {
  const CheckButtonWidget({
    Key key,
    this.isChoosed,
    this.onTap,
  }) : super(key: key);

  final bool isChoosed;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: isChoosed ? PLColors.primary : null,
          border: Border.all(
            width: 1,
            color: PLColors.primary,
          ),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Icon(
          Icons.check,
          size: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}
