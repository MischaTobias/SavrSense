import 'package:flutter/material.dart';
import 'package:savr_sense/features/raw_ingredients/presentation/add_raw_ingredient_screen.dart';

class RawIngredientInventoryScreen extends StatefulWidget {
  const RawIngredientInventoryScreen({super.key});

  @override
  RawIngredientInventoryScreenState createState() =>
      RawIngredientInventoryScreenState();
}

class RawIngredientInventoryScreenState
    extends State<RawIngredientInventoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _ingredients = const [
    {'name': 'Flour', 'image': 'assets/images/flour.png'},
    {'name': 'Sugar', 'image': 'assets/images/sugar.png'},
    {'name': 'Salt', 'image': 'assets/images/salt.png'},
  ];
  List<Map<String, String>> _filteredIngredients = [];

  @override
  void initState() {
    super.initState();
    _filteredIngredients = _ingredients;
    _searchController.addListener(_filterIngredients);
  }

  void _filterIngredients() {
    setState(() {
      _filteredIngredients =
          _ingredients
              .where(
                (ingredient) => ingredient['name']!.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ),
              )
              .toList();
    });
  }

  void _navigateToAddIngredient() {
    // Navigate to the AddRawIngredientScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddRawIngredientScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inventory")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Search Ingredients",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredIngredients.length,
              itemBuilder: (context, index) {
                final ingredient = _filteredIngredients[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  leading: SizedBox(
                    width: 50, // Fixed width for alignment
                    height: 50,
                    child: Image.asset(ingredient['image']!, fit: BoxFit.cover),
                  ),
                  title: Text(ingredient['name']!),
                  onTap: () {
                    // Navigate to edit/restock screen
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddIngredient,
        child: const Icon(Icons.add),
      ),
    );
  }
}
