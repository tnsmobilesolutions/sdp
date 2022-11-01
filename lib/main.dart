// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sdp/Login/EmailSignIn.dart';
import 'package:sdp/dashboard.dart';
import 'package:sdp/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp(
  //     options: FirebaseOptions(
  //   apiKey: "AIzaSyBBM9fjqih7IJSi1VfYLfHq3nWtbKFKuNQ",
  //   appId: "1:684346010972:web:20b7176ec8d3228476e599",
  //   messagingSenderId: "684346010972",
  //   projectId: "sdp-nss-puri",
  // ));
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
