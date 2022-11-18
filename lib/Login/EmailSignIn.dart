// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names

import 'dart:developer';

import 'package:authentication/EmailLogin/authenticationWidget.dart';
import 'package:flutter/material.dart';
import 'package:sdp/API/userAPI.dart';
import 'package:sdp/newDashboard.dart';

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
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: AuthenticationWidget(
                imageWidth: 240,
                imageHeight: 240,
                cardWidth: 240,
                cardHeight: 260,
                loginImage: AssetImage('assets/images/login.png'),
                onEmailLoginPressed: (userEmail, userPassword) async {
                  final user = await UserAPI().signIn(userEmail, userPassword);
                  if (user != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewDashboard(),
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
                buttonColor: Color(0xFFeb1589),
                loginButonTextColor: Colors.white,
                // titleTextColor: Colors.white,
                loginPageTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                isImageVisible: true,
                textFieldBorderColor: Colors.white,
                //  Color(0xFFeb1589),
                cardColor: Color(0XFF3f51b5),
                // textfieldHintColor: Colors.white,
                emailHintTextStyle: TextStyle(color: Colors.white),
                passwordHintTextStyle: TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }
}
