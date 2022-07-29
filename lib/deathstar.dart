import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_api_demo/drawer.dart';
import 'package:flutter_api_demo/styleutil.dart';
import 'netutil.dart';
import 'package:provider/provider.dart';

class Starship extends StatelessWidget {
  final String name;
  final String model;
  final String starshipClass;
  final String length;

  const Starship(this.name, this.model, this.starshipClass, this.length,
      {Key? key})
      : super(key: key);

  const Starship.empty(
      {this.name = 'n/a',
      this.model = 'n/a',
      this.starshipClass = 'n/a',
      this.length = 'n/a',
      Key? key})
      : super(key: key);

  factory Starship.fromJson(Map<String, dynamic>? json) {
    return Starship(
      json!['name'],
      json['model'],
      json['starship_class'],
      json['length'],
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
            StyledLabel('Model: ', model),
            StyledLabel('Class: ', starshipClass),
            StyledLabel('Length: ', '$length m'),
          ],
        ));
  }
}

class DeathStarModel with ChangeNotifier {
  final NetUtil _nu = NetUtil();
  Starship? deathStar;

  Future<Starship?> getDeathStar() async {
    if (deathStar == null) {
      var r = await _nu.get('starships/9');
      if (r.statusCode == 200) {
        deathStar = Starship.fromJson(jsonDecode(r.body));
      }
    }
    return deathStar;
  }
}

class DeathStarPage extends StatefulWidget {
  const DeathStarPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DeathStarPageState();
}

class _DeathStarPageState extends State<DeathStarPage> {
  late Future<Starship?> _deathStar;

  @override
  void initState() {
    super.initState();
    _deathStar =
        Provider.of<DeathStarModel>(context, listen: false).getDeathStar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Death Star"),
        backgroundColor: const Color.fromARGB(255, 228, 201, 1),
      ),
      drawer: const MainDrawer(),
      body: Center(
        child: FutureBuilder<Starship?>(
          future: _deathStar,
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
    );
  }
}
