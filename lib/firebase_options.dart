// DO NOT EDIT
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // Web
    return const FirebaseOptions(
      apiKey: 'your_api_key',
      appId: 'your_app_id',
      messagingSenderId: 'your_sender_id',
      projectId: 'your_project_id',
      authDomain: 'your_auth_domain',
      storageBucket: 'your_storage_bucket',
    );
  }
}
