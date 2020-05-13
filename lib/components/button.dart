import 'package:flutter/material.dart';

import '../theme/theme.dart';

enum ButtonStyle { Primary, White }

enum ButtonType { Active, Unactive }

// Displays primary button
// If onTap==null button is disabled

class ITButton extends StatefulWidget {
  const ITButton({Key key, this.onTap, this.text, this.style, this.type = ButtonType.Active}) : super(key: key);
  final Function onTap;
  final String text;
  final ButtonStyle style;
  final ButtonType type;

  @override
  _ITButtonState createState() => _ITButtonState();
}

class _ITButtonState extends State<ITButton> {
  Function get onTap => widget.onTap;
  String get text => widget.text;
  ButtonType get type => widget.type;
  ButtonStyle get style => widget.style;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    if (type == ButtonType.Unactive)
      return AnimatedOpacity(
        opacity: isPressed ? 0.4 : 1,
        duration: Duration(milliseconds: 300),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: ITColors.grey2,
            borderRadius: BorderRadius.circular(38),
          ),
          child: Center(
            child: Text(
              text,
              style: ITStyle.textGrey,
            ),
          ),
        ),
      );
    else
      return GestureDetector(
        onTapDown: (_) => setState(() {
          isPressed = true;
        }),
        onTapCancel: () => setState(() {
          isPressed = false;
        }),
        onTap: onTap,
        child: AnimatedContainer(
            height: 60,
            decoration: BoxDecoration(
              boxShadow: [isPressed ? ITShadows.buttonPressed : ITShadows.button],
              color: style == ButtonStyle.Primary ? ITColors.general : ITColors.white,
              borderRadius: BorderRadius.circular(38),
            ),
            duration: Duration(milliseconds: 300),
            child: Center(
              child: Text(
                text,
                style: style == ButtonStyle.Primary ? ITStyle.textMediumWhite : ITStyle.textMediumGeneral,
              ),
            )),
      );
  }
}
