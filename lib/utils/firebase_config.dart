import 'dart:io';

import 'package:firebase_core/firebase_core.dart';


class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:448618578101:ios:0b650370bb29e29cac3efc',
        apiKey: 'AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzMOfz0',
        projectId: 'react-native-firebase-testing',
        messagingSenderId: '448618578101',
        iosBundleId: 'io.flutter.plugins.firebasecoreexample',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:155507588971:android:7b035203b55262fd06962e',
        apiKey: 'AIzaSyBgF-kMBB3GJ-Ah2LIHJ_zMed7fHdnp584',
        projectId: 'taptodo-d996e',
        messagingSenderId: '448618578101',
      );
    }
  }
}