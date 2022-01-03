import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final double percentage;
  final Color? color;
  final Color? backColor;
  final double? width;
  final double? backWidth;
  final Gradient? gradient;

  const RadialProgress(
      {Key? key,
      required this.percentage,
      this.color = Colors.blue,
      this.backColor = Colors.transparent,
      this.width = 10,
      this.backWidth = 4,
      this.gradient})
      : super(key: key);

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late double previousPercentage;

  @override
  void initState() {
    previousPercentage = widget.percentage;

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);

    final substractAnimate = widget.percentage - previousPercentage;
    previousPercentage = widget.percentage;

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: _MyRadialProgress(
                (widget.percentage - substractAnimate) +
                    (substractAnimate * controller.value),
                widget.color ?? Colors.blue,
                widget.backColor ?? Colors.transparent,
                widget.width ?? 10.0,
                widget.backWidth ?? 5.0,
                widget.gradient),
          ),
        );
      },
    );
  }
}

class _MyRadialProgress extends CustomPainter {
  final double percentage;
  final Color color;
  final Color backColor;
  final double width;
  final double backwidth;
  final Gradient? gradient;

  _MyRadialProgress(this.percentage, this.color, this.backColor, this.width,
      this.backwidth, this.gradient);

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromCircle(center: const Offset(0, 0), radius: 180);

    // Circle
    final paint = Paint()
      ..strokeWidth = backwidth
      ..color = backColor
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double radius = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radius, paint);

    // Arc
    if (gradient != null) {
      final paintArc = Paint()
        ..strokeWidth = width
        ..strokeCap = StrokeCap.round
        ..color = color
        ..shader = gradient!.createShader(rect)
        ..style = PaintingStyle.stroke;

      double arcAngle = 2 * pi * (percentage / 100);

      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
          arcAngle, false, paintArc);
    } else {
      final paintArc = Paint()
        ..strokeWidth = width
        ..strokeCap = StrokeCap.round
        ..color = color
        ..style = PaintingStyle.stroke;

      double arcAngle = 2 * pi * (percentage / 100);

      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
          arcAngle, false, paintArc);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
