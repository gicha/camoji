import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'button.dart';

enum ButtonSize { Normal, Small }

class ITButtonText extends StatefulWidget {
  const ITButtonText({
    Key key,
    this.onTap,
    this.text,
    this.icon,
    this.style = ButtonStyle.Primary,
    this.size = ButtonSize.Normal,
  }) : super(key: key);
  final Function onTap;
  final String text;
  final Widget icon;
  final ButtonStyle style;
  final ButtonSize size;

  @override
  _ITButtonTextState createState() => _ITButtonTextState();
}

class _ITButtonTextState extends State<ITButtonText> {
  Function get onTap => widget.onTap;
  String get text => widget.text;
  ButtonStyle get style => widget.style;
  ButtonSize get size => widget.size;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
        Future.delayed(Duration(seconds: 3), () {
          setState(() {
            isPressed = false;
          });
        });
      },
      onTapCancel: () => setState(() {
        isPressed = false;
      }),
      onTap: onTap,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: isPressed ? 0.7 : 1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: widget.icon,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: ITStyle.captionGeneral,
              ),
            ] else
              Text(
                text,
                style: style == ButtonStyle.Primary
                    ? size == ButtonSize.Normal ? ITStyle.textGeneral : ITStyle.captionGeneral
                    : size == ButtonSize.Normal ? ITStyle.textWhite : ITStyle.captionWhite,
              ),
          ],
        ),
      ),
    );
  }
}
