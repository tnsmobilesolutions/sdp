// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sammilani_dinikia_paali/Login/EmailSignIn.dart';
import 'package:sammilani_dinikia_paali/dashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyCifCEFC_0Dn6LRSF7p_jnMaF8p9Sk_f3o-0rUIOtHl_I",
    appId: "1:178527485841:web:57d9128145560fde08a430",
    messagingSenderId: "178527485841",
    projectId: "tnshealthone2022",
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;

            if (user == null) {
              return EmailSignIn();
            } else {
              return Dashboard();
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
