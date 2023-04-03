import 'dart:async';
import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:renderer/mesh_face.dart';
import 'package:renderer/pixel.dart';
import 'package:renderer/triangle.dart';
import 'package:renderer/vector.dart';

class RendererModel extends FlameGame {
  List<Pixel> renderBuffer = [
    Pixel(
      Paint()..color = Colors.cyan,
      left: 0,
      top: 0,
    ),
  ];

  Vector3 cubeRotation = Vector3(0, 0, pi);
  Vector3 cameraPosition = Vector3(0, 0, -1);
  List<Triangle> trianglesToRender = [];

  List<Vector3> meshVertices = [];
  List<MeshFace> meshFaces = [];

  @override
  Color backgroundColor() {
    return Colors.transparent;
  }

  @override
  FutureOr<void> onLoad() async {
    await loadModel();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // cubeRotation.x += 0.01;
    cubeRotation.y += 0.01;
    // cubeRotation.z += 0.01;

    buildCube();

    drawCube();

    super.update(dt);
  }

  void drawCube() {
    for (var i = 0; i < meshFaces.length; i++) {
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

      for (var j = 0; j < 3; j++) {
        Vector3 transformedVertex = faceVertices[j];

        transformedVertex = rotateX(transformedVertex, cubeRotation.x);
        transformedVertex = rotateY(transformedVertex, cubeRotation.y);
        transformedVertex = rotateZ(transformedVertex, cubeRotation.z);

        transformedVertex.z -= cameraPosition.z;

        Vector2 projectedPoint = project(transformedVertex);
        projectedPoint.x += 320 / 2;
        projectedPoint.y += 240 / 2;

        if (j == 0) {
          projectedTriangle = Triangle.points(
            Vector3(projectedPoint.x, projectedPoint.y, 0),
            projectedTriangle.point1,
            projectedTriangle.point2,
          );
        }

        if (j == 1) {
          projectedTriangle = Triangle.points(
            projectedTriangle.point0,
            Vector3(projectedPoint.x, projectedPoint.y, 0),
            projectedTriangle.point2,
          );
        }

        if (j == 2) {
          projectedTriangle = Triangle.points(
            projectedTriangle.point0,
            projectedTriangle.point1,
            Vector3(projectedPoint.x, projectedPoint.y, 0),
          );
        }
      }

      trianglesToRender.add(projectedTriangle);
    }
  }

  Future<void> loadModel() async {
    final data = await rootBundle.loadString('assets/gun.obj');
    List<String> lines = data.split('\n');
    for (var element in lines) {
      if (element.isNotEmpty) {
        if (element[0] == 'v' && element[1] != 't' && element[1] != 'n') {
          final values = element.split(' ');
          meshVertices.add(
            Vector3(
              double.parse(values[1]),
              double.parse(values[2]),
              double.parse(values[3]),
            ),
          );
        }
        if (element[0] == 'f') {
          final values = element.split(' ');
          List<int> tempInts = [];
          for (var i = 1; i < values.length; i++) {
            final subValues = values[i].split('/');
            tempInts.add(int.parse(subValues[0]));
          }
          meshFaces.add(MeshFace(tempInts[0], tempInts[1], tempInts[2]));
        }
      }
    }
  }
}
