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
  // Create controllers for each RadioListTileMcq
  final RadioListTileController _compositionController = RadioListTileController(
    initialValue: 'cystic',
  );
  
  final RadioListTileController _echogenicityController = RadioListTileController(
    initialValue: 'iso',
  );
  
  @override
  void dispose() {
    // Don't forget to dispose of the controllers when done
    _compositionController.dispose();
    _echogenicityController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TIRADS Assessment')),
      body: Column(
        children: [
          // TabBar to switch between different assessment categories
          DefaultTabController(
            length: 2,
            child: Expanded(
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: 'Composition'),
                      Tab(text: 'Echogenicity'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // First tab: Composition assessment
                        Column(
                          children: [
                            Expanded(
                              child: RadioListTileMcq(
                                options: tiradsComposition,
                                controller: _compositionController,
                                title: 'TIRADS Composition',
                                onSelectionChanged: (value) {
                                  print('Composition changed: $value');
                                },
                              ),
                            ),
                            _buildCompositionControls(),
                          ],
                        ),
                        
                        // Second tab: Echogenicity assessment
                        Column(
                          children: [
                            Expanded(
                              child: RadioListTileMcq(
                                options: tiradsEchogenicity,
                                controller: _echogenicityController,
                                title: 'TIRADS Echogenicity',
                                onSelectionChanged: (value) {
                                  print('Echogenicity changed: $value');
                                },
                              ),
                            ),
                            _buildEchogenicityControls(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Summary section to show both selected values
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Assessment Summary', 
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text('Composition: ${_getDisplayText(_compositionController.selectedValue, tiradsComposition)}'),
                    Text('Echogenicity: ${_getDisplayText(_echogenicityController.selectedValue, tiradsEchogenicity)}'),
                    const SizedBox(height: 8),
                    Text('Total Score: ${_calculateTotalScore()}', 
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get the display text for a value
  String _getDisplayText(String? value, Map<String, String> options) {
    if (value == null || !options.containsKey(value)) {
      return 'Not selected';
    }
    return options[value]!;
  }
  
  // Helper method to calculate the total score (simplified example)
  String _calculateTotalScore() {
    // This is a simplified calculation - in a real app you would parse the scores
    // from the strings and calculate properly
    int score = 0;
    
    // Extract score from composition (example)
    if (_compositionController.selectedValue == 'mixed') score += 1;
    if (_compositionController.selectedValue == 'solid' || 
        _compositionController.selectedValue == 'undetermined') score += 2;
    
    // Extract score from echogenicity (example)
    if (_echogenicityController.selectedValue == 'hyper' || 
        _echogenicityController.selectedValue == 'iso' ||
        _echogenicityController.selectedValue == 'undetermined') score += 1;
    if (_echogenicityController.selectedValue == 'hypo') score += 2;
    if (_echogenicityController.selectedValue == 'very-hypo') score += 3;
    
    return score.toString();
  }
  
  // Control buttons for composition
  Widget _buildCompositionControls() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () => _compositionController.selectedValue = 'spongiform',
            child: const Text('Set Spongiform'),
          ),
          ElevatedButton(
            onPressed: () => _compositionController.clear(),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
  
  // Control buttons for echogenicity
  Widget _buildEchogenicityControls() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () => _echogenicityController.selectedValue = 'hypo',
            child: const Text('Set Hypoechoic'),
          ),
          ElevatedButton(
            onPressed: () => _echogenicityController.clear(),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}