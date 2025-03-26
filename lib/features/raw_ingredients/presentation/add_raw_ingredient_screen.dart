import 'package:flutter/material.dart';

class AddRawIngredientScreen extends StatefulWidget {
  const AddRawIngredientScreen({super.key});

  @override
  AddRawIngredientScreenState createState() => AddRawIngredientScreenState();
}

class AddRawIngredientScreenState extends State<AddRawIngredientScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  void _saveIngredient() {
    String name = _nameController.text;
    String quantity = _quantityController.text;
    if (name.isNotEmpty && quantity.isNotEmpty) {
      print("Saved Ingredient: $name ($quantity)");
      _nameController.clear();
      _quantityController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Raw Ingredient")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Ingredient Name"),
            ),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: "Quantity"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveIngredient,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
