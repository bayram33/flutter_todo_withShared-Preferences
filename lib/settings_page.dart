import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo2/models/color_theme_data.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(" Tema Seçimi :) ")),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const SwitchCard(),
    );
  }
}

class SwitchCard extends StatefulWidget {
  const SwitchCard({super.key});

  @override
  State<SwitchCard> createState() => _SwitchCardState();
}

class _SwitchCardState extends State<SwitchCard> {
  @override
  Widget build(BuildContext context) {
    Text green = const Text("Green", style: TextStyle(color: Colors.green));
    Text red = const Text("Red", style: TextStyle(color: Colors.red));
    return Card(
      child: SwitchListTile(
        subtitle: Provider.of<ColorThemeData>(context).isGreen ? green : red,
        title: const Text(
          "Change Theme Color",
          style: TextStyle(color: Colors.black),
        ),
        value: Provider.of<ColorThemeData>(context).isGreen,
        onChanged: (_) {
          Provider.of<ColorThemeData>(context, listen: false).toggleStatus();
        },
      ),
    );
  }
}
