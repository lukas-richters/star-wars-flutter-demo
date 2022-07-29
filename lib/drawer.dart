import 'package:flutter/material.dart';

import 'deathstar.dart';
import 'planets.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Image.asset('assets/images/swlogo.png')),
          ListTile(
            leading: const Icon(Icons.public),
            title: const Text('Planets'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlanetPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.public),
            title: const Text('Death Star'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeathStarPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
