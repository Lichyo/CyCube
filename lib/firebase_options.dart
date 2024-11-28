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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZ5QXF4Wzh-RuZWM_TLhBA1GurkP1Pugs',
    appId: '1:116929185399:ios:9e65d22a9bc10a997ae872',
    messagingSenderId: '116929185399',
    projectId: 'cy-cube-a25ad',
    storageBucket: 'cy-cube-a25ad.appspot.com',
    iosBundleId: 'com.lcy.cyCube',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD52XNdmEqbFj4xKbOzjx3L8LVLTQ764TA',
    appId: '1:116929185399:android:41346488c3e79cbb7ae872',
    messagingSenderId: '116929185399',
    projectId: 'cy-cube-a25ad',
    storageBucket: 'cy-cube-a25ad.appspot.com',
  );

}