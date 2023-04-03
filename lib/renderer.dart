import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:renderer/cube.dart';
import 'package:renderer/pixel.dart';
import 'package:renderer/triangle.dart';
import 'package:renderer/vector.dart';

class Renderer extends FlameGame {
  List<Pixel> renderBuffer = [
    Pixel(
      Paint()..color = Colors.cyan,
      left: 0,
      top: 0,
    ),
  ];

  Vector3 cubeRotation = Vector3(0, 0, 0);
  Vector3 cameraPosition = Vector3(0, 0, 0);
  List<Triangle> trianglesToRender = [];

  @override
  Color backgroundColor() {
    return Colors.transparent;
  }

  @override
  FutureOr<void> onLoad() {
    return super.onLoad();
  }

  @override
  void update(double dt) {
    cubeRotation.x += 0.01;
    cubeRotation.y += 0.01;
    cubeRotation.z += 0.01;

    buildCube();

    drawCube();

    super.update(dt);
  }

  void drawCube() {
    for (var i = 0; i < trianglesToRender.length; i++) {
      final Triangle triangle = trianglesToRender[i];

      // add(Pixel(
      //   Paint()..color = Colors.deepPurple,
      //   left: triangle.point0.x,
      //   top: triangle.point0.y,
      // ));

      // add(Pixel(
      //   Paint()..color = Colors.deepPurple,
      //   left: triangle.point1.x,
      //   top: triangle.point1.y,
      // ));

      // add(Pixel(
      //   Paint()..color = Colors.deepPurple,
      //   left: triangle.point2.x,
      //   top: triangle.point2.y,
      // ));

      add(
        TriangleDrawer(
          Paint()..color = Colors.deepPurple,
          x0: triangle.point0.x,
          y0: triangle.point0.y,
          x1: triangle.point1.x,
          y1: triangle.point1.y,
          x2: triangle.point2.x,
          y2: triangle.point2.y,
        ),
      );
    }
  }

  void buildCube() {
    trianglesToRender.clear();
    for (var i = 0; i < meshFaces.length; i++) {
      final meshFace = meshFaces[i];

      List<Vector3> faceVertices = [];
      faceVertices.add(meshVertices[meshFace.a - 1]);
      faceVertices.add(meshVertices[meshFace.b - 1]);
      faceVertices.add(meshVertices[meshFace.c - 1]);

      Triangle projectedTriangle = Triangle.points(
        Vector3.zero(),
        Vector3.zero(),
        Vector3.zero(),
      );

      List<Vector3> transformedVertices = [];

      for (var j = 0; j < 3; j++) {
        Vector3 transformedVertex = faceVertices[j];

        transformedVertex = rotateX(transformedVertex, cubeRotation.x);
        transformedVertex = rotateY(transformedVertex, cubeRotation.y);
        transformedVertex = rotateZ(transformedVertex, cubeRotation.z);

        transformedVertex.z += 5;

        transformedVertices.add(transformedVertex);
      }

      Vector3 vectorAB = sub(transformedVertices[1], transformedVertices[0]);
      Vector3 vectorAC = sub(transformedVertices[2], transformedVertices[0]);

      Vector3 normal = cross(vectorAB, vectorAC);

      Vector3 cameraRay = sub(cameraPosition, transformedVertices[0]);

      double dotNormalCamera = dot(normal, cameraRay);

      if (dotNormalCamera >= 0) {
        Vector2 projectedPoint = project(transformedVertices[0]);
        projectedPoint.x += 320 / 2;
        projectedPoint.y += 240 / 2;

        Vector2 projectedPoint1 = project(transformedVertices[1]);
        projectedPoint1.x += 320 / 2;
        projectedPoint1.y += 240 / 2;

        Vector2 projectedPoint2 = project(transformedVertices[2]);
        projectedPoint2.x += 320 / 2;
        projectedPoint2.y += 240 / 2;

        projectedTriangle = Triangle.points(
          Vector3(projectedPoint.x, projectedPoint.y, 0),
          Vector3(projectedPoint1.x, projectedPoint1.y, 0),
          Vector3(projectedPoint2.x, projectedPoint2.y, 0),
        );

        trianglesToRender.add(projectedTriangle);
      }
    }
  }
}
