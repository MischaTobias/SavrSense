import 'dart:async';
import 'package:flutter/material.dart';
import 'package:savr_sense/features/raw_ingredients/models/raw_ingredient.dart';
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
  final ScrollController _scrollController = ScrollController();
  final List<RawIngredient> _ingredients = [
    RawIngredient(
      uid: 'asdfghjkl1234567890',
      name: 'Verdes',
      image: 'assets/images/verdes.jpeg',
      quantity: '100',
    ),
    RawIngredient(
      uid: 'asdfghjkl1234567890',
      name: 'Leche',
      image: 'assets/images/milk.jpeg',
      quantity: '100',
    ),
    RawIngredient(
      uid: 'asdfghjkl1234567890',
      name: 'Brioche',
      image: 'assets/images/brioche.jpeg',
      quantity: '100',
    ),
  ];

  List<RawIngredient> _filteredIngredients = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _filteredIngredients = _ingredients;
    _searchController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 300), _filterIngredients);
    });
  }

  void _filterIngredients() {
    setState(() {
      _filteredIngredients =
          _ingredients
              .where(
                (ingredient) => ingredient.name.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ),
              )
              .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _navigateToAddIngredient() async {
    final newIngredient = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddRawIngredientScreen()),
    );

    if (newIngredient != null && newIngredient is RawIngredient) {
      setState(() {
        _ingredients.add(newIngredient);
        _filteredIngredients = _ingredients;
      });
    }
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
              decoration: const InputDecoration(
                labelText: "Search Ingredients",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: ListView.separated(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: _filteredIngredients.length,
                separatorBuilder:
                    (context, index) => const Divider(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      thickness: 0.5,
                      indent: 16,
                      endIndent: 16,
                    ),
                itemBuilder: (context, index) {
                  final ingredient = _filteredIngredients[index];
                  return ListTile(
                    key: ValueKey(ingredient.name),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    leading: SizedBox(
                      width: 80,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.asset(ingredient.image, fit: BoxFit.cover),
                      ),
                    ),
                    title: Text(ingredient.name),
                    onTap: () {},
                  );
                },
              ),
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
