import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:savr_sense/core/di/service_locator.dart';

@lazySingleton
class RawIngredientService {
  void addIngredient(String name) {
    final Logger logger = locator<Logger>();
    logger.i('Added ingredient: $name');
  }
}
