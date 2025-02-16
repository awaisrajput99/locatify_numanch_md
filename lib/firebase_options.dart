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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVHWRjUOan8ZGPERbDULHYa2mo_MnEtmA',
    appId: '1:39644027924:android:6bc38060ff0b3c46089b01',
    messagingSenderId: '39644027924',
    projectId: 'md-locatify-8fd9e',
    storageBucket: 'md-locatify-8fd9e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAS5SxsjFw5CP5gw7yoecMbAWcR8kC82Uo',
    appId: '1:39644027924:ios:a54f58ba66d7455b089b01',
    messagingSenderId: '39644027924',
    projectId: 'md-locatify-8fd9e',
    storageBucket: 'md-locatify-8fd9e.firebasestorage.app',
    androidClientId: '39644027924-m9jh5fqsu3d820vkgbusnfrp1oon7itu.apps.googleusercontent.com',
    iosClientId: '39644027924-k44d5t6ogjieft727up8dgeir2mkicr7.apps.googleusercontent.com',
    iosBundleId: 'com.numanch.locatify',
  );

}