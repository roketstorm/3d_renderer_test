import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class TriangleDrawer extends PositionComponent {
  final double x0;
  final double y0;
  final double x1;
  final double y1;
  final double x2;
  final double y2;
  final Paint color;

  TriangleDrawer(
    this.color, {
    required this.x0,
    required this.y0,
    required this.x1,
    required this.y1,
    required this.x2,
    required this.y2,
  }) : super(
          anchor: const Anchor(0, 0),
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawLine(Offset(x0, y0), Offset(x1, y1), color);
    canvas.drawLine(Offset(x1, y1), Offset(x2, y2), color);
    canvas.drawLine(Offset(x2, y2), Offset(x0, y0), color);
    removeFromParent();
  }
}
