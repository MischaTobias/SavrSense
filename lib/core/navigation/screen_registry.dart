import 'package:flutter/material.dart';
import 'package:savr_sense/features/dishes/presentation/add_dish_screen.dart';
import 'package:savr_sense/features/processed_goods/presentation/add_processed_good_screen.dart';
import 'package:savr_sense/features/raw_ingredients/presentation/raw_ingredent_inventory_screen.dart';

class ScreenInfo {
  final Widget screen;
  final String imagePath;

  ScreenInfo({required this.screen, required this.imagePath});
}

class ScreenRegistry {
  static Map<String, ScreenInfo> screens = {
    'Raw Ingredients': ScreenInfo(
      screen: RawIngredientInventoryScreen(),
      imagePath: 'assets/images/raw_ingredients.svg',
    ),
    'Processed Goods': ScreenInfo(
      screen: AddProcessedGoodScreen(),
      imagePath: 'assets/images/processed_goods.svg',
    ),
    'Dishes': ScreenInfo(
      screen: AddDishScreen(),
      imagePath: 'assets/images/dishes.svg',
    ),
  };

  static ScreenInfo? getScreenInfo(String screenName) {
    return screens[screenName];
  }
}
