import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiteboard_swd/presenters/google_sign_in.dart';
import 'package:whiteboard_swd/utils/color.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: null,
          title: Text(
            'Thông tin cá nhân ',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 18),
          ),
          actions: [
            PopupMenuButton<int>(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                onSelected: (value) {
                  if (value == 2) {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.logout();
                  }
                },
                itemBuilder: (context) => [
                      PopupMenuItem(value: 0, child: Text('Chỉnh sửa')),
                      PopupMenuItem(value: 1, child: Text('Cài đặt')),
                      PopupMenuDivider(),
                      PopupMenuItem(value: 2, child: Text('Đăng xuất')),
                    ]),
          ]),
      body: Container(
        child: Column(children: [
          SizedBox(
            height: size.height * 0.03,
          ),
          Center(
            child: Container(
              width: size.height * 0.2,
              height: size.height * 0.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(user.photoURL.toString()),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(size.height * 0.1)),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Center(
            child: Text(
              user.displayName.toString(),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Center(
            child: Text(
              user.email.toString(),
              style: TextStyle(fontSize: 18, color: grey_text),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
        ]),
      ),
    ));
  }
}
