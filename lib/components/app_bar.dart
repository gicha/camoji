import 'package:camoji/theme/theme.dart';
import 'package:flutter/material.dart';

class PLAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PLAppBar({
    Key key,
    @required this.height,
    @required this.bgAsset,
    this.withBack = false,
  }) : super(key: key);

  final double height;
  final String bgAsset;
  final bool withBack;

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: -40,
          child: ClipPath(
            clipper: AppBarClipper(),
            child: Container(
              decoration: BoxDecoration(
                color: PLColors.bg,
                image: DecorationImage(
                  image: ExactAssetImage(bgAsset),
                  fit: BoxFit.fitWidth,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Stack(children: [
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40),
                      if (withBack)
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                      boxShadow: [PLShadows.appbar],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, height);
}

class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..arcToPoint(Offset(size.width - 40, size.height - 40), radius: Radius.circular(40), clockwise: false)
      ..lineTo(40, size.height - 40)
      ..arcToPoint(Offset(0, size.height), radius: Radius.circular(40), clockwise: false)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
