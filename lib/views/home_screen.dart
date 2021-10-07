import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whiteboard_swd/components/bottom_tab.dart';
import 'package:whiteboard_swd/presenters/google_sign_in.dart';
import 'package:whiteboard_swd/views/login_screen.dart';

class Controller extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            else if (snapshot.hasData) {
              return BottomTab();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Đã xảy ra sự cố. Vui lòng thử lại sau.'),
              );
            } else {
              return LoginScreen();
            }
          },
        ),
      );
}
