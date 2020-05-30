import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:camoji/global/after_layout.dart';
import 'package:camoji/theme/theme.dart';

import '../../../theme/theme.dart';

class ITProgress extends StatefulWidget {
  ITProgress({
    this.percent,
    this.size,
  });

  final double percent;
  final double size;

  @override
  _ITProgressState createState() => _ITProgressState();
}

class _ITProgressState extends State<ITProgress> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  AnimationController progressAnimationController;

  Animation<double> progressAnimation;
  Animation<double> textAnimation;

  @override
  void initState() {
    super.initState();
    progressAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    progressAnimation = Tween<double>(begin: 0.0, end: widget.percent / 100)
        .animate(CurvedAnimation(parent: progressAnimationController, curve: Curves.easeOutCubic));
    textAnimation = Tween<double>(begin: 0.0, end: widget.percent / 100)
        .animate(CurvedAnimation(parent: progressAnimationController, curve: Curves.easeOutCubic));
  }

  @override
  afterFirstLayout(BuildContext context) {
    progressAnimationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    var size = widget.size - 36;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * .05,
      ),
      child: AnimatedBuilder(
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
                        value: progressAnimation.value,
                        backgroundColor: ITColors.black.withOpacity(0.1),
                        strokeWidth: size * .1,
                        colors: [
                          ITColors.general,
                          ITColors.general,
                        ],
                      ),
                    ),
                    Text(
                      ["☹️", "🙁", "😐", "😌", "😁"][(widget.percent / 20).floor()],
                      style: ITStyle.create(fontSize: 70),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
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
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          12 * 0.57735 + 0.5,
        ),
    );
    var gradient = RadialGradient(
      center: Alignment(-0.4, -0.6),
      radius: 1.2,
      stops: [0.2, 1],
      colors: colors,
    );

    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(Offset.zero & size);

    canvas.drawArc(
      Offset.zero & size,
      arcStart,
      -arcSweep,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(ProgressPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor ||
        oldPainter.value != value ||
        oldPainter.strokeWidth != strokeWidth ||
        oldPainter.colors != colors;
  }
}
