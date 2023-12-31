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
    apiKey: 'AIzaSyDf_dY7pi5NyeFkQXCow_3RGlzm3hYNP4o',
    appId: '1:747835007262:android:856b5069cad6183266e90f',
    messagingSenderId: '747835007262',
    projectId: 'afaq-academy',
    storageBucket: 'afaq-academy.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBeK_RtISAV1WTV_HQq_z9Mpm5kIfd-9Dg',
    appId: '1:747835007262:ios:ab5ded48e112c78566e90f',
    messagingSenderId: '747835007262',
    projectId: 'afaq-academy',
    storageBucket: 'afaq-academy.appspot.com',
    androidClientId: '747835007262-4ql3n6534cfdfu2uok85eolq5l581pqu.apps.googleusercontent.com',
    iosClientId: '747835007262-7vof38n7u0ld7dev0nd0624he3sggohp.apps.googleusercontent.com',
    iosBundleId: 'com.afaq.afaqAlnourAcademy',
  );
}
