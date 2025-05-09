import 'package:flutter/material.dart';
import 'src/choices.dart';
import "src/radiolisttile_mcq.dart";

/// Flutter code sample for [RadioListTile] using Map data structure with controller.

void main() {
  runApp(const RadioListTileApp());
}

class RadioListTileApp extends StatelessWidget {
  const RadioListTileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const RadioControllerDemo(),
    );
  }
}

class RadioControllerDemo extends StatefulWidget {
  const RadioControllerDemo({super.key});

  @override
  State<RadioControllerDemo> createState() => _RadioControllerDemoState();
}

class _RadioControllerDemoState extends State<RadioControllerDemo> {
  // Create a controller for the RadioListTileMcq
  final RadioListTileController _radioController = RadioListTileController(
    initialValue: 'cystic',
  );
  
  @override
  void dispose() {
    // Don't forget to dispose of the controller when done
    _radioController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RadioListTile Controller Demo')),
      body: Column(
        children: [
          // Use the RadioListTileMcq with the controller
          Expanded(
            child: RadioListTileMcq(
              options: tiradsComposition,
              controller: _radioController,
              title: 'TIRADS Composition',
              onSelectionChanged: (value) {
                print('Selection changed from widget: $value');
              },
            ),
          ),
          
          // Add control buttons to demonstrate external control
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Set selection to a specific option
                    _radioController.selectedValue = 'spongiform';
                  }, 
                  child: const Text('Set to Spongiform'),
                ),
                
                ElevatedButton(
                  onPressed: () {
                    // Clear selection
                    _radioController.clear();
                  }, 
                  child: const Text('Clear Selection'),
                ),
                
                ElevatedButton(
                  onPressed: () {
                    // Read current value
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Current value: ${_radioController.selectedValue ?? "None"}'),
                      ),
                    );
                  }, 
                  child: const Text('Get Value'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}