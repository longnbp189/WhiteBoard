import 'package:flutter/material.dart';
import 'package:whiteboard_swd/utils/color.dart';
import 'package:whiteboard_swd/views/logged_in.dart';
import 'package:whiteboard_swd/views/notification_screen.dart';
import 'package:whiteboard_swd/views/post_screen.dart';
import 'package:whiteboard_swd/views/profile_screen.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({Key? key}) : super(key: key);

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int currentTab = 0;
  final List<Widget> screens = [
    HomePage(),
    PostPage(),
    NotificationPage(),
    ProfilePage()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomePage();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_outlined,
                          color: currentTab == 0 ? white_blue : grey_text,
                        ),
                        Text(
                          'Trang chủ',
                          style: TextStyle(
                              fontSize: 12,
                              color: currentTab == 0 ? white_blue : grey_text),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 30,
                    onPressed: () {
                      setState(() {
                        currentScreen = PostPage();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.article_outlined,
                          color: currentTab == 1 ? white_blue : grey_text,
                        ),
                        Text(
                          'Bài viết',
                          style: TextStyle(
                              fontSize: 12,
                              color: currentTab == 1 ? white_blue : grey_text),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              // SizedBox(
              //   width: 10,
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = NotificationPage();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_outlined,
                          color: currentTab == 2 ? white_blue : grey_text,
                        ),
                        Text(
                          'Thông báo',
                          style: TextStyle(
                              fontSize: 12,
                              color: currentTab == 2 ? white_blue : grey_text),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = ProfilePage();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: currentTab == 3 ? white_blue : grey_text,
                        ),
                        Text(
                          'Cá nhân',
                          style: TextStyle(
                              fontSize: 12,
                              color: currentTab == 3 ? white_blue : grey_text),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
