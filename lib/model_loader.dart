import 'dart:io';
import 'package:flame/cache.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:string_scanner/string_scanner.dart';

Future<void> loadModel() async {
  final data = await rootBundle.loadString('assets/cube.obj');
  List<String> lines = data.split('\n');
  for (var element in lines) {
    if (element.isNotEmpty) {
      if (element[0] == 'v') {
        final values = element.split(' ');
      }
    }
  }
}
