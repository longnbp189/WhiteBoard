import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whiteboard_swd/utils/color.dart';
import 'package:whiteboard_swd/utils/google_sign_in.dart';

class GoogleSignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: OutlinedButton.icon(
        label: Text(
          "Đăng nhập với Google",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        icon: FaIcon(
          FontAwesomeIcons.google,
          color: white_blue,
        ),
        onPressed: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.googleLogin();
        },
      ),
    );
  }
}
