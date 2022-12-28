import 'package:flutter/material.dart';
import 'package:sdp/API/userAPI.dart';
import 'package:sdp/Login/EmailSignIn.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      // style: ButtonStyle(
      //   shape: MaterialStateProperty.all(RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(15.0))),
      // ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          width: 1.0,
          color: Colors.white,
        ),
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        UserAPI().logout();
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const EmailSignIn();
          },
        ));
      },
      child: const Text('Logout'),
    );
  }
}
