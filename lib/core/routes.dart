import 'package:go_router/go_router.dart';
import 'package:savr_sense/features/home/presentation/home_screen.dart';
import '../features/raw_ingredients/presentation/add_raw_ingredient_screen.dart';
import '../features/processed_goods/presentation/add_processed_good_screen.dart';
import '../features/dishes/presentation/add_dish_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/ingredients',
      builder: (context, state) => AddRawIngredientScreen(),
    ),
    GoRoute(
      path: '/processed_goods',
      builder: (context, state) => AddProcessedGoodScreen(),
    ),
    GoRoute(path: '/dishes', builder: (context, state) => AddDishScreen()),
  ],
);
