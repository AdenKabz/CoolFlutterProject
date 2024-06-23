// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyA6rO2LJMNcg0ZXQLxMKeosDB4J8F1HUo8',
    appId: '1:793305182751:web:66684cd3b9cad220e99b2a',
    messagingSenderId: '793305182751',
    projectId: 'tibachap',
    authDomain: 'tibachap.firebaseapp.com',
    storageBucket: 'tibachap.appspot.com',
    measurementId: 'G-8CJ0140E33',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDelGCN-pxRoNq8BMZrH2HGm5QmXkLe0lc',
    appId: '1:793305182751:android:c9cc9894c6cc0567e99b2a',
    messagingSenderId: '793305182751',
    projectId: 'tibachap',
    storageBucket: 'tibachap.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6bOOx-CXwmYosKoPNhE_Tz8AV-eWcSpg',
    appId: '1:793305182751:ios:905c3c9eb7ef9647e99b2a',
    messagingSenderId: '793305182751',
    projectId: 'tibachap',
    storageBucket: 'tibachap.appspot.com',
    iosBundleId: 'com.example.tibachap',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB6bOOx-CXwmYosKoPNhE_Tz8AV-eWcSpg',
    appId: '1:793305182751:ios:905c3c9eb7ef9647e99b2a',
    messagingSenderId: '793305182751',
    projectId: 'tibachap',
    storageBucket: 'tibachap.appspot.com',
    iosBundleId: 'com.example.tibachap',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA6rO2LJMNcg0ZXQLxMKeosDB4J8F1HUo8',
    appId: '1:793305182751:web:fd020e8c6f075e63e99b2a',
    messagingSenderId: '793305182751',
    projectId: 'tibachap',
    authDomain: 'tibachap.firebaseapp.com',
    storageBucket: 'tibachap.appspot.com',
    measurementId: 'G-4HE68VC0R5',
  );

}