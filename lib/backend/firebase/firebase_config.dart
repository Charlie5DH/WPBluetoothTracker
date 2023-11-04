import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyA1HH9HixFeMcoFIXi-A4KggX5iqQY2wDE",
            authDomain: "bluetoothwp.firebaseapp.com",
            projectId: "bluetoothwp",
            storageBucket: "bluetoothwp.appspot.com",
            messagingSenderId: "615477680904",
            appId: "1:615477680904:web:192f12fbaf70e4f2046abd"));
  } else {
    await Firebase.initializeApp();
  }
}
