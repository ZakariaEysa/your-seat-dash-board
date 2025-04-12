import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorRingWidget extends StatelessWidget {
  const ColorRingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      height: 135.h,
      child: CustomPaint(
        painter: SegmentedCirclePainter(),
      ),
    );
  }
}

class SegmentedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 24;
    final double gapSize = 0.2;
    final int segments = 5;

    final List<Color> colors = [
      Color(0xFF490073),
      Color(0xFFC69CFF),
      Color(0xFFE4C4FF),
      Color(0xFFA464F2),
      Color(0xFF7F33CC),
    ];

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final Rect rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final double totalAngle = 2 * 3.141592653589793;
    final double sweepAngle = (totalAngle - (segments * gapSize)) / segments;

    for (int i = 0; i < segments; i++) {
      paint.color = colors[i];
      final double startAngle = i * (sweepAngle + gapSize);
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
