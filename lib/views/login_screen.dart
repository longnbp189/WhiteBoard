import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whiteboard_swd/components/google_signup_button.dart';
import 'package:whiteboard_swd/utils/color.dart';
import 'package:whiteboard_swd/presenters/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/frame.png"),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.25,
              ),
              Center(
                child: Container(
                  child: Image.asset("assets/images/logo.jpg"),
                  height: size.height * 0.25,
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Center(
                  child: Text(
                "WhiteBoard",
                style: TextStyle(
                    color: white_blue, fontFamily: "Dancing", fontSize: 40),
              )),
              Center(
                  child: Text(
                "Đánh giá trường đại học",
                style: TextStyle(
                    color: dart_blue, fontFamily: "Dancing", fontSize: 30),
              )),
              SizedBox(
                height: size.height * 0.05,
              ),
              Container(
                height: size.height * 0.06,
                width: size.width - 100,
                child: ElevatedButton(
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.googleLogin();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: white_blue, width: 1)))),
                  // GoogleSignupButton(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Đăng nhập bằng Google',
                        style: TextStyle(fontSize: 16, color: white_blue),
                      ),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      Icon(
                        FontAwesomeIcons.googlePlusG,
                        color: white_blue,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
