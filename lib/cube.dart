import 'dart:core';

import 'package:flame/game.dart';
import 'package:renderer/mesh_face.dart';

final List<Vector3> meshVertices = [
  Vector3(-1, -1, -1),
  Vector3(-1, 1, -1),
  Vector3(1, 1, -1),
  Vector3(1, -1, -1),
  Vector3(1, 1, 1),
  Vector3(1, -1, 1),
  Vector3(-1, 1, 1),
  Vector3(-1, -1, 1),
];

List<MeshFace> meshFaces = [
  // Front
  MeshFace(1, 2, 3),
  MeshFace(1, 3, 4),

  // Right
  MeshFace(4, 3, 5),
  MeshFace(4, 5, 6),

  // Back
  MeshFace(6, 5, 7),
  MeshFace(6, 7, 8),

  // Left
  MeshFace(8, 7, 2),
  MeshFace(8, 2, 1),

  // Top
  MeshFace(2, 7, 5),
  MeshFace(2, 5, 3),

  // Bottom
  MeshFace(6, 8, 1),
  MeshFace(6, 1, 4),
];
