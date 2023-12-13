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
    apiKey: 'AIzaSyBRKu6odcIFPM71G0C1QSpT3zAAOwZNDHA',
    appId: '1:988495546387:web:cd4ad3515265d2743b97e6',
    messagingSenderId: '988495546387',
    projectId: 'tea-time-118d6',
    authDomain: 'tea-time-118d6.firebaseapp.com',
    storageBucket: 'tea-time-118d6.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB813VS1YtXcmtewDBthVrmmZm-2GGsptc',
    appId: '1:988495546387:android:efc0f25e516905ce3b97e6',
    messagingSenderId: '988495546387',
    projectId: 'tea-time-118d6',
    storageBucket: 'tea-time-118d6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvDknUGOJIJBP4J04jqhD6k_BB0L1yG-M',
    appId: '1:988495546387:ios:d6856acdeaeb04683b97e6',
    messagingSenderId: '988495546387',
    projectId: 'tea-time-118d6',
    storageBucket: 'tea-time-118d6.appspot.com',
    iosBundleId: 'com.example.teatime',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDvDknUGOJIJBP4J04jqhD6k_BB0L1yG-M',
    appId: '1:988495546387:ios:cf1653282017c1033b97e6',
    messagingSenderId: '988495546387',
    projectId: 'tea-time-118d6',
    storageBucket: 'tea-time-118d6.appspot.com',
    iosBundleId: 'com.example.teatime.RunnerTests',
  );
}
