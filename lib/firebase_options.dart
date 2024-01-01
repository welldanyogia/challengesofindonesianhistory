// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAGJ14wZezBkiztxeDDP1y5q-VNVz5JXzw',
    appId: '1:998006918407:web:c8fe5617558a054b0b49a2',
    messagingSenderId: '998006918407',
    projectId: 'mobilegame-86f16',
    authDomain: 'mobilegame-86f16.firebaseapp.com',
    storageBucket: 'mobilegame-86f16.appspot.com',
    measurementId: 'G-FCJTERG1S1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBLZLDPlHi5EjHucAdmEDbd9gl1F9FN_YU',
    appId: '1:998006918407:android:abbbfbed642168020b49a2',
    messagingSenderId: '998006918407',
    projectId: 'mobilegame-86f16',
    storageBucket: 'mobilegame-86f16.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCupa8ddoQdm5HuT4NE_9OUVW56V2gExFA',
    appId: '1:998006918407:ios:0fc6fcbb10d9808b0b49a2',
    messagingSenderId: '998006918407',
    projectId: 'mobilegame-86f16',
    storageBucket: 'mobilegame-86f16.appspot.com',
    iosBundleId: 'challengesofindonesianhistory.challengesofindonesianhistory',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCupa8ddoQdm5HuT4NE_9OUVW56V2gExFA',
    appId: '1:998006918407:ios:373caf026816e7fa0b49a2',
    messagingSenderId: '998006918407',
    projectId: 'mobilegame-86f16',
    storageBucket: 'mobilegame-86f16.appspot.com',
    iosBundleId: 'challengesofindonesianhistory.challengesofindonesianhistory.RunnerTests',
  );
}
