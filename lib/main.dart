import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_api_demo/planets.dart';
import 'package:provider/provider.dart';
import 'deathstar.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => DeathStarModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'Flutter API Demo'),
      home: const PlanetPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _color = Colors.indigo;

  void _changeColor() {
    setState(() {
      _color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(onTap: () => _changeColor()),
      backgroundColor: _color,
    );
  }
}
