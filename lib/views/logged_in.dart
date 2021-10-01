import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiteboard_swd/utils/google_sign_in.dart';

class LoggedIn extends StatelessWidget {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Logged In'),
        centerTitle: true,
      ),
      body: TextButton(
          onPressed: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.logout();
          },
          child: Text(
            'Logout',
          )),
    );
  }
}
