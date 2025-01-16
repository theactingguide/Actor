import 'package:actor/View/Authentication/login.dart';
import 'package:actor/View/Home/Homescreen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDe_trlnDn2Tj85YYEUNRNTCy63JnZOKRk",
          authDomain: "the-acting-guide.firebaseapp.com",
          projectId: "the-acting-guide",
          storageBucket: "the-acting-guide.firebasestorage.app",
          messagingSenderId: "468470770669",
          appId: "1:468470770669:web:bc104baca21cb9ebe115e4"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: FirebaseAuth.instance.currentUser != null
          ? Homescreen()
          : LoginScreen(),
    );
  }
}
