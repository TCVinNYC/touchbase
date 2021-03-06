import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDO1E9ZGAjOG9c3d5Xnq0qiNpRrpzv9Sw4',
    appId: '1:871129232474:web:cb7d5ca05baf706c8a9463',
    messagingSenderId: '871129232474',
    projectId: 'touchbase-b2faf',
    authDomain: 'touchbase-b2faf.firebaseapp.com',
    storageBucket: 'touchbase-b2faf.appspot.com',
    measurementId: 'G-EGZNL2MVXK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzDq6eb0gNR20uVPWh_eYi-t8fQutCGqA',
    appId: '1:871129232474:android:1909c6d86a92c8588a9463',
    messagingSenderId: '871129232474',
    projectId: 'touchbase-b2faf',
    storageBucket: 'touchbase-b2faf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDv5EocOJwuuIOMje6VGFa1tyPQ1Eefe6M',
    appId: '1:871129232474:ios:bdbc30eeba4fcf1e8a9463',
    messagingSenderId: '871129232474',
    projectId: 'touchbase-b2faf',
    storageBucket: 'touchbase-b2faf.appspot.com',
    iosClientId: '871129232474-n3avlap91b5s03ra29n2uukmqcokduvv.apps.googleusercontent.com',
    iosBundleId: 'com.example.letsConnect',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDv5EocOJwuuIOMje6VGFa1tyPQ1Eefe6M',
    appId: '1:871129232474:ios:bdbc30eeba4fcf1e8a9463',
    messagingSenderId: '871129232474',
    projectId: 'touchbase-b2faf',
    storageBucket: 'touchbase-b2faf.appspot.com',
    iosClientId: '871129232474-n3avlap91b5s03ra29n2uukmqcokduvv.apps.googleusercontent.com',
    iosBundleId: 'com.example.letsConnect',
  );
}
