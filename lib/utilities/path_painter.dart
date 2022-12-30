import 'package:flutter/material.dart';

class PathPainter extends CustomPainter {
  Path path;
  Color color;
  PathPainter({required this.path, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // paint the line
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
