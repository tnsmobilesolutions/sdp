// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:authentication/EmailLogin/authenticationWidget.dart';
import 'package:flutter/material.dart';
import 'package:sdp/API/userAPI.dart';
import 'package:sdp/dashboard.dart';

class EmailSignIn extends StatefulWidget {
  const EmailSignIn({super.key});

  @override
  State<EmailSignIn> createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  final TextEditingController PhoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.cyanAccent.shade200,
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: AuthenticationWidget(
                cardWidth: 100,
                cardHeight: 100,
                cardLeftPadding: 500,
                cardRightPadding: 600,
                loginImage: AssetImage('assets/images/login.png'),
                scaffoldbackGroundColor: Colors.white70,
                onEmailLoginPressed: (userEmail, userPassword) async {
                  log(userEmail);
                  log(userPassword);
                  final user = await UserAPI().signIn(userEmail, userPassword);
                  if (user != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dashboard(),
                        ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      elevation: 6,
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        'Please Check your Email/Password',
                      ),
                    ));
                  }
                },
                phoneAuthentication: false,
                isSignUpVisible: false,
                buttonColor: Colors.greenAccent.shade700,
                isImageVisible: true,
              )),
        ),
      ),
    );
  }
}
