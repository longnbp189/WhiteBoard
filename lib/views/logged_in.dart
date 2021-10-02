import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiteboard_swd/utils/google_sign_in.dart';

class LoggedIn extends StatelessWidget {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Log in"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Text(provider.getTokenId().then((value) => value.toString()) ),
          // FutureBuilder<String>(
          //   builder: (context, value) {
          //     return Container(
          //         child: TextFormField(
          //             maxLines: 35,
          //             controller:
          //                 TextEditingController(text: value.data.toString())));
          //   },
          //   future: provider.getTokenId(),
          // ),
          TextButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
              child: Text(
                'Logout',
              )),
        ],
      ),
    );
  }
}
