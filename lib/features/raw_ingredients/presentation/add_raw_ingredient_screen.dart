import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savr_sense/features/raw_ingredients/models/raw_ingredient.dart';

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

  final RegExp _numericRegex = RegExp(r'^(?:\d+|\d*\.\d+)$');

  void _saveIngredient() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String quantity = _quantityController.text;

      RawIngredient newIngredient = RawIngredient(
        uid: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        image: 'assets/images/default.png',
        quantity: quantity,
      );

      Navigator.pop(context, newIngredient);
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

                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Enter initial quantity',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Initial quantity is required';
                  }

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
