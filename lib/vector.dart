import 'dart:math';

import 'package:flame/game.dart';
import 'package:renderer/main.dart';

Vector3 rotateX(Vector3 v, double angle) {
  Vector3 rotatedVector = Vector3(
    v.x,
    v.y * cos(angle) - v.z * sin(angle),
    v.y * sin(angle) + v.z * cos(angle),
  );

  return rotatedVector;
}

Vector3 rotateY(Vector3 v, double angle) {
  Vector3 rotatedVector = Vector3(
    v.x * cos(angle) - v.z * sin(angle),
    v.y,
    v.x * sin(angle) + v.z * cos(angle),
  );

  return rotatedVector;
}

Vector3 rotateZ(Vector3 v, double angle) {
  Vector3 rotatedVector = Vector3(
    v.x * cos(angle) - v.y * sin(angle),
    v.x * sin(angle) + v.y * cos(angle),
    v.z,
  );

  return rotatedVector;
}

Vector2 project(Vector3 point) {
  return Vector2(
    fov * point.x / point.z,
    fov * point.y / point.z,
  );
}

Vector3 sub(Vector3 a, Vector3 b) {
  return Vector3(
    a.x - b.x,
    a.y - b.y,
    a.z - b.z,
  );
}

Vector3 cross(Vector3 a, Vector3 b) {
  return Vector3(
    a.y * b.z - a.z * b.y,
    a.z * b.x - a.x * b.z,
    a.x * b.y - a.y * b.x,
  );
}

double dot(Vector3 a, Vector3 b) {
  return (a.x * b.x) + (a.y * b.y) + (a.z * b.z);
}
