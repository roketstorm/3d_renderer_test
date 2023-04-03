import 'dart:ui';

import 'package:flame/components.dart';

class Pixel extends PositionComponent {
  final double left;
  final double top;
  final Paint color;

  Pixel(
    this.color, {
    required this.left,
    required this.top,
  }) : super(
            anchor: Anchor.center,
            position: Vector2(
              left,
              top,
            ));

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(const Rect.fromLTRB(0, 0, 5, 5), color);
    removeFromParent();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
