import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:camoji/global/after_layout.dart';
import 'package:camoji/theme/theme.dart';

class ITProgress extends StatefulWidget {
  ITProgress({
    this.selfEmission,
    this.selfAbsorbtion,
    this.globalEmission,
    this.globalAbsorbtion,
    this.size,
  });
  final double selfEmission;
  final double selfAbsorbtion;
  final double globalEmission;
  final double globalAbsorbtion;
  final double size;

  @override
  _ITProgressState createState() => _ITProgressState();
}

class _ITProgressState extends State<ITProgress> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  AnimationController progressAnimationController;

  Animation<double> selfProgressAnimation;
  Animation<double> selfTextAnimation;

  Animation<double> globalProgressAnimation;
  Animation<double> globalTextAnimation;

  @override
  void initState() {
    super.initState();
    progressAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    selfProgressAnimation = Tween<double>(begin: 0.0, end: widget.selfAbsorbtion / widget.selfEmission)
        .animate(CurvedAnimation(parent: progressAnimationController, curve: Curves.easeOutCubic));
    selfTextAnimation = Tween<double>(begin: 0.0, end: widget.selfEmission - widget.selfAbsorbtion)
        .animate(CurvedAnimation(parent: progressAnimationController, curve: Curves.easeOutCubic));

    globalProgressAnimation = Tween<double>(begin: 0.0, end: widget.globalAbsorbtion / widget.globalEmission)
        .animate(CurvedAnimation(parent: progressAnimationController, curve: Curves.easeOutCubic));
    globalTextAnimation = Tween<double>(begin: 0.0, end: widget.globalEmission - widget.globalAbsorbtion)
        .animate(CurvedAnimation(parent: progressAnimationController, curve: Curves.easeOutCubic));
  }

  @override
  afterFirstLayout(BuildContext context) {
    progressAnimationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    var size = widget.size - 36;
    return AnimatedBuilder(
      animation: progressAnimationController,
      builder: (context, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: size + 36,
              height: size + 36,
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CustomPaint(
                    size: Size(size * .9, size * .9),
                    painter: ProgressPainter(
                      value: globalProgressAnimation.value,
                      backgroundColor: ITColors.grey,
                      strokeWidth: size * .08,
                      colors: [
                        Color(0xff6CEEE6),
                        Color(0xff883AEC),
                      ],
                    ),
                  ),
                  CustomPaint(
                    size: Size(size * .65, size * .65),
                    painter: ProgressPainter(
                      value: selfProgressAnimation.value,
                      backgroundColor: ITColors.grey,
                      strokeWidth: size * .08,
                      colors: [
                        Color(0xff57F9D2),
                        Color(0xff1AB18D),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "YOUR",
                        style: ITStyle.header.apply(color: ITColors.grey2),
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: selfTextAnimation.value.truncate().toString(),
                          style: ITStyle.create(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: "  KgCO\u2082",
                          style: ITStyle.create(
                            color: ITColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ])),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
            Text(
              "COUNTRY AVERAGE",
              style: ITStyle.header.apply(color: ITColors.grey2),
            ),
            Text.rich(TextSpan(children: [
              TextSpan(
                text: globalTextAnimation.value.truncate().toString(),
                style: ITStyle.create(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: ITColors.grey,
                ),
              ),
              TextSpan(
                text: "  KgCO\u2082",
                style: ITStyle.create(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ITColors.grey,
                ),
              ),
            ])),
          ],
        );
      },
    );
  }
}

class ProgressPainter extends CustomPainter {
  ProgressPainter({
    this.backgroundColor,
    this.value,
    this.strokeWidth,
    this.colors,
  })  : arcStart = value != null ? _startAngle : _startAngle,
        arcSweep = value != null ? (value.clamp(0.0, 1.0) as double) * _sweep : _epsilon;

  final Color backgroundColor;
  final double value;
  final double strokeWidth;
  final double arcStart;
  final double arcSweep;
  final List<Color> colors;

  static const double _twoPi = math.pi * 2.0;
  static const double _epsilon = .001;
  static const double _sweep = _twoPi - _epsilon;
  static const double _startAngle = -math.pi / 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (backgroundColor != null) {
      final Paint backgroundPaint = Paint()
        ..color = backgroundColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawArc(Offset.zero & size, 0, _sweep, false, backgroundPaint);
    }

    canvas.drawArc(
      Offset(0, 3) & size,
      arcStart,
      -arcSweep,
      false,
      Paint()
        ..color = ITColors.black.withOpacity(0.23)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth * 1.2
        ..strokeCap = StrokeCap.round
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(12)),
    );
    var gradient = RadialGradient(center: Alignment(-0.4, -0.6), radius: 1.2, stops: [0.2, 1], colors: colors);

    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(Offset.zero & size);

    canvas.drawArc(Offset.zero & size, arcStart, -arcSweep, false, paint);
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  @override
  bool shouldRepaint(ProgressPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor ||
        oldPainter.value != value ||
        oldPainter.strokeWidth != strokeWidth ||
        oldPainter.colors != colors;
  }
}
