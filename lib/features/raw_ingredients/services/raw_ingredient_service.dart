import 'package:injectable/injectable.dart';

@lazySingleton
class RawIngredientService {
  void addIngredient(String name) {
    print('Added ingredient: $name');
  }
}
