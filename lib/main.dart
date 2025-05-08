import 'package:flutter/material.dart';
import 'choices.dart';

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



/// A reusable widget that displays a list of radio options generated from a map.
///
/// `RadioListTileMcq` creates a vertical list of [RadioListTile] widgets from a
/// provided map of key-value pairs, where:
/// - Keys serve as the unique identifiers/values for each radio option
/// - Values represent the display text for each option
///
/// Features:
/// - Supports an optional title above the radio options
/// - Allows setting an initial selected value
/// - Provides a callback for selection changes
/// - Displays the currently selected value at the bottom
/// - Automatically scrollable for long lists
///
/// Example usage:
/// ```dart
/// RadioListTileMcq(
///   options: {
///     'option1': 'First Choice',
///     'option2': 'Second Choice',
///     'option3': 'Third Choice',
///   },
///   initialValue: 'option2',
///   title: 'Please select an option',
///   onSelectionChanged: (value) => print('Selected: $value'),
/// )
/// ```
class RadioListTileMcq extends StatefulWidget {
  /// Map of options to display as radio tiles
  final Map<String, String> options;
  
  /// Initial selected value (optional)
  final String? initialValue;
  
  /// Title for the radio group (optional)
  final String? title;
  
  /// Callback when selection changes (optional)
  final Function(String? value)? onSelectionChanged;

  const RadioListTileMcq({
    super.key, 
    required this.options,
    this.initialValue,
    this.title,
    this.onSelectionChanged,
  });

  @override
  State<RadioListTileMcq> createState() => _RadioListTileMcqState();
}

class _RadioListTileMcqState extends State<RadioListTileMcq> {
  // This stores the currently selected key
  String? _selectedValue;
  
  @override
  void initState() {
    super.initState();
    // Use the initial value provided, or the first item if available
    _selectedValue = widget.initialValue ?? 
                     (widget.options.isNotEmpty ? widget.options.keys.first : null);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Optional title
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.title!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          
          // Dynamically generate RadioListTile widgets from the Map
          ...widget.options.entries.map((entry) {
            return RadioListTile<String>(
              title: Text(entry.value),
              value: entry.key,
              groupValue: _selectedValue,
              onChanged: (String? value) {
                setState(() {
                  _selectedValue = value;
                });
                // Call the callback if provided
                if (widget.onSelectionChanged != null) {
                  widget.onSelectionChanged!(value);
                }
                print('Selected: $value (${widget.options[value]})');
              },
            );
          }),
          
          // Add a display of the currently selected value
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Selected: ${_selectedValue ?? 'None'}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}