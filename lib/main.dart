import 'package:flutter/material.dart';
import 'src/choices.dart';
import "src/radiolisttile_mcq.dart";

/// Flutter code sample for [RadioListTile] using Map data structure.

void main() {
  runApp(const RadioListTileApp());
}

class RadioListTileApp extends StatelessWidget {
  const RadioListTileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('RadioListTile Sample')),
        // Use the reusable widget with the tiradsComposition map
        body: RadioListTileMcq(
          options: tiradsComposition,
          initialValue: 'cystic',
          title: 'TIRADS Composition',
        ),
      ),
    );
  }
}