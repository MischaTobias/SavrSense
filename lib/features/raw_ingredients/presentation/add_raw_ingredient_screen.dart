import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:savr_sense/core/di/service_locator.dart';

class AddRawIngredientScreen extends StatefulWidget {
  const AddRawIngredientScreen({super.key});

  @override
  AddRawIngredientScreenState createState() => AddRawIngredientScreenState();
}

class AddRawIngredientScreenState extends State<AddRawIngredientScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  String _selectedUnit = "grams";

  final List<String> _units = [
    "grams",
    "kilograms",
    "ounces",
    "pounds",
    "liters",
    "milliliters",
    "teaspoons",
    "tablespoons",
    "cups",
  ];

  // Final regex for a valid whole or decimal number (no negatives)
  final RegExp _numericRegex = RegExp(r'^(?:\d+|\d*\.\d+)$');

  void _saveIngredient() {
    // Validate the form before saving
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String quantity = _quantityController.text;
      final Logger logger = locator<Logger>();
      logger.i("Saved Ingredient: $name ($quantity $_selectedUnit)");
      _nameController.clear();
      _quantityController.clear();
      setState(() {
        _selectedUnit = "grams"; // Reset to default unit
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Raw Ingredient")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Ingredient Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingredient name is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                // Use a simple formatter that allows digits and a decimal point,
                // allowing for temporary states during editing.
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
                ],
                decoration: const InputDecoration(labelText: 'Enter quantity'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Quantity is required';
                  }
                  // Validate final value using the stricter regex.
                  if (!_numericRegex.hasMatch(value)) {
                    return 'Please enter a valid number (whole or decimal, no negatives)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedUnit,
                decoration: const InputDecoration(
                  labelText: "Measurement Unit",
                ),
                items:
                    _units
                        .map(
                          (unit) =>
                              DropdownMenuItem(value: unit, child: Text(unit)),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedUnit = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveIngredient,
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
