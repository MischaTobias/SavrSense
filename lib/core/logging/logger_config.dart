import 'package:logger/logger.dart';

class LoggerConfig {
  static Logger getLogger() {
    return Logger(
      level: Level.debug,
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
    );
  }
}
