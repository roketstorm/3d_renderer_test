import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:renderer/render_model_surf_2.dart';
import 'package:renderer/renderer.dart';
import 'package:renderer/renderer_model.dart';
import 'package:renderer/renderer_model_2.dart';
import 'package:renderer/renderer_model_surf.dart';
import 'package:statsfl/statsfl.dart';

double fov = 480;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3D Renderer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Renderer Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => StatsFl(
                      child: Scaffold(
                        appBar: AppBar(
                          title: const Text('3D Cube'),
                        ),
                        body: Center(
                          child: SizedBox(
                            width: 320,
                            height: 240,
                            child: GameWidget(game: Renderer()),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Rotating 3D Cube'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => StatsFl(
                      child: Scaffold(
                        appBar: AppBar(
                          title: const Text('Model from File'),
                        ),
                        body: Center(
                          child: SizedBox(
                            width: 320,
                            height: 240,
                            child: GameWidget(game: RendererModel2()),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Rotating 3d Model'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => StatsFl(
                      child: Scaffold(
                        appBar: AppBar(
                          title: const Text('Surf Logo'),
                        ),
                        body: Center(
                          child: SizedBox(
                            width: 320,
                            height: 240,
                            child: GameWidget(game: RendererModelSurf2()),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Rotating Surf'),
            )
          ],
        ),
      ),
    );
  }
}
