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
    apiKey: 'AIzaSyDsa2hI6xaX1BBHskp2vFCTnAYrJZk4QSo',
    appId: '1:993958939137:web:10a46567eed2da40a64e00',
    messagingSenderId: '993958939137',
    projectId: 'dibrimak-b0193',
    authDomain: 'dibrimak-b0193.firebaseapp.com',
    databaseURL: 'https://dibrimak-b0193-default-rtdb.firebaseio.com',
    storageBucket: 'dibrimak-b0193.appspot.com',
    measurementId: 'G-69SQXJ1G0F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbapCQrdQfOVuBSHDIPteygk9PD-8Wb-w',
    appId: '1:993958939137:android:62916d3e830f6aaba64e00',
    messagingSenderId: '993958939137',
    projectId: 'dibrimak-b0193',
    databaseURL: 'https://dibrimak-b0193-default-rtdb.firebaseio.com',
    storageBucket: 'dibrimak-b0193.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAlga3vbrRjU69yFmmLxxbmRXuDPJkik8g',
    appId: '1:993958939137:ios:15bcbaaef6c3b395a64e00',
    messagingSenderId: '993958939137',
    projectId: 'dibrimak-b0193',
    databaseURL: 'https://dibrimak-b0193-default-rtdb.firebaseio.com',
    storageBucket: 'dibrimak-b0193.appspot.com',
    iosBundleId: 'com.example.dibrimakMobile',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAlga3vbrRjU69yFmmLxxbmRXuDPJkik8g',
    appId: '1:993958939137:ios:ab50ed6b1214c946a64e00',
    messagingSenderId: '993958939137',
    projectId: 'dibrimak-b0193',
    databaseURL: 'https://dibrimak-b0193-default-rtdb.firebaseio.com',
    storageBucket: 'dibrimak-b0193.appspot.com',
    iosBundleId: 'com.example.dibrimakMobile.RunnerTests',
  );
}