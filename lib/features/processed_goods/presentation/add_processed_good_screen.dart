import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:savr_sense/core/di/service_locator.dart';

class AddProcessedGoodScreen extends StatefulWidget {
  const AddProcessedGoodScreen({super.key});

  @override
  AddProcessedGoodScreenState createState() => AddProcessedGoodScreenState();
}

class AddProcessedGoodScreenState extends State<AddProcessedGoodScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();

  void _saveProcessedGood() {
    String name = _nameController.text;
    String brand = _brandController.text;
    if (name.isNotEmpty && brand.isNotEmpty) {
      final Logger logger = locator<Logger>();
      logger.i("Saved Processed Good: $name (Brand: $brand)");
      _nameController.clear();
      _brandController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Processed Good")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Processed Good Name",
              ),
            ),
            TextField(
              controller: _brandController,
              decoration: const InputDecoration(labelText: "Brand"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProcessedGood,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
