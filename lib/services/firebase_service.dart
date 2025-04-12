import 'package:firebase_core/firebase_core.dart';
import '../core/config/firebase_options.dart';

class FirebaseService {
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
