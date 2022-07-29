import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_api_demo/drawer.dart';
import 'package:flutter_api_demo/styleutil.dart';
import 'netutil.dart';

class Planet extends StatelessWidget {
  final String name;
  final String diameter;
  final String rotationPeriod;
  final String orbitalPeriod;
  final String gravity;
  final String population;
  final String climate;
  final String terrain;
  final String surfaceWater;

  const Planet(
      this.name,
      this.diameter,
      this.rotationPeriod,
      this.orbitalPeriod,
      this.gravity,
      this.population,
      this.climate,
      this.terrain,
      this.surfaceWater,
      {Key? key})
      : super(key: key);

  const Planet.empty(
      {this.name = 'n/a',
      this.diameter = 'n/a',
      this.rotationPeriod = 'n/a',
      this.orbitalPeriod = 'n/a',
      this.gravity = 'n/a',
      this.population = 'n/a',
      this.climate = 'n/a',
      this.terrain = 'n/a',
      this.surfaceWater = 'n/a',
      Key? key})
      : super(key: key);

  factory Planet.fromJson(Map<String, dynamic>? json) {
    var g = json!['gravity'];
    if (g.indexOf('s') != -1) {
      json['gravity'] = g.substring(0, g.indexOf('s') - 1);
    }

    g = json['gravity'];
    if (g != 'N/A' && g != 'unknown') {
      json['gravity'] = '${double.parse(g) * 9.8} m/s^2';
    }

    return Planet(
      json['name'],
      json['diameter'],
      json['rotation_period'],
      json['orbital_period'],
      json['gravity'],
      json['population'],
      json['climate'],
      json['terrain'],
      json['surface_water'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            StyledLabel('Diameter: ', '$diameter km'),
            StyledLabel('Rotation period: ', '$rotationPeriod std. hours'),
            StyledLabel('Orbital period: ', '$orbitalPeriod std. days'),
            StyledLabel('Gravity: ', gravity),
            StyledLabel('Population: ', population),
            StyledLabel('Climate: ', climate),
            StyledLabel('Terrain: ', terrain),
            StyledLabel('Surface water: ', '$surfaceWater%'),
          ],
        ));
  }
}

class PlanetPage extends StatefulWidget {
  const PlanetPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlanetPageState();
}

class _PlanetPageState extends State<PlanetPage> {
  int _planetCounter = 1;
  final NetUtil _nu = NetUtil();

  Future<Planet?> getPlanet() async {
    var r = await _nu.get("planets/$_planetCounter");
    if (r.statusCode == 200) {
      return Planet.fromJson(jsonDecode(r.body));
    }
    return const Planet.empty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planets"),
        backgroundColor: const Color.fromARGB(255, 228, 201, 1),
      ),
      drawer: const MainDrawer(),
      body: Center(
        child: FutureBuilder<Planet?>(
          future: getPlanet(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!;
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _planetCounter++;
            if (_planetCounter > 60) _planetCounter = 1;
          });
        },
        backgroundColor: const Color.fromARGB(255, 228, 201, 1),
        child: const Icon(Icons.keyboard_double_arrow_right),
      ),
    );
  }
}
