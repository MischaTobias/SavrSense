import 'package:flutter/material.dart';

class AddDishScreen extends StatefulWidget {
  const AddDishScreen({super.key});

  @override
  AddDishScreenState createState() => AddDishScreenState();
}

class AddDishScreenState extends State<AddDishScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _recipeController = TextEditingController();

  void _saveDish() {
    String name = _nameController.text;
    String recipe = _recipeController.text;
    if (name.isNotEmpty && recipe.isNotEmpty) {
      print("Saved Dish: $name (Recipe: $recipe)");
      _nameController.clear();
      _recipeController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Dish")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Dish Name"),
            ),
            TextField(
              controller: _recipeController,
              decoration: const InputDecoration(labelText: "Recipe"),
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _saveDish, child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
