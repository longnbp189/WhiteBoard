import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiteboard_swd/models/reviewer.dart';
import 'package:whiteboard_swd/presenters/google_sign_in.dart';
import 'package:whiteboard_swd/utils/color.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      // child: FutureBuilder(
      // builder: ,
      // future: Fu,
      child: FutureBuilder<Reviewer>(
        future: GoogleSignInProvider().getInfo(),
        builder: (context, value) {
          if (value.hasData) {
            return Scaffold(
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
                            final provider = Provider.of<GoogleSignInProvider>(
                                context,
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
                              image:
                                  NetworkImage(value.data!.avatar.toString()),
                              fit: BoxFit.cover),
                          borderRadius:
                              BorderRadius.circular(size.height * 0.1)),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Center(
                    child: Text(
                      value.data!.name.toString(),
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Center(
                    child: Text(
                      value.data!.email.toString(),
                      style: TextStyle(fontSize: 18, color: grey_text),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.width * 0.09,
                        horizontal: size.height * 0.06),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '9',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Điểm',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Bài viết của tôi',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Text(value.data!.publishedReviews.toString(),
                            style: TextStyle(fontSize: 20)),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Column(
                        children: [
                          Text(value.data!.waitingReviews.toString(),
                              style: TextStyle(fontSize: 20)),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Bị từ chối', style: TextStyle(fontSize: 16))
                        ],
                      ),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Icon(
                        Icons.arrow_back_ios,
                        color: grey_text,
                      ),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Column(
                        children: [
                          Text(value.data!.waitingReviews.toString(),
                              style: TextStyle(fontSize: 20)),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Chờ sử lý', style: TextStyle(fontSize: 16))
                        ],
                      ),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: grey_text,
                      ),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      Column(
                        children: [
                          Text(value.data!.publishedReviews.toString(),
                              style: TextStyle(fontSize: 20)),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Đã công bố', style: TextStyle(fontSize: 16))
                        ],
                      )
                    ],
                  )
                ]),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // )
    );
  }
}
