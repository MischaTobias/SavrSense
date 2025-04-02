import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import '../../core/logging/logger_config.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<Logger>(() => LoggerConfig.getLogger());

  // Register other services here.
  // For example:
  // locator.registerLazySingleton<SomeService>(() => SomeServiceImpl());
}
