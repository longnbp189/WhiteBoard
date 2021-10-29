import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:whiteboard_swd/components/button_upload_file.dart';
import 'package:whiteboard_swd/utils/color.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: SizedBox(),
          leadingWidth: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Thông báo',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: white_blue),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              ButtonUploadFile(
                onClicked: () async {
                  String? token = await FirebaseMessaging.instance.getToken();
                  print(token);
                },
                icon: Icons.notification_add,
                text: 'Notification',
              ),
              SizedBox(height: 20),
              // ButtonUploadFile(
              //   onClicked: () {
              //     NotificationAPI.showScheduleNotification(
              //         title: 'Đạt',
              //         body: 'Dậy đi cho rồi',
              //         payload: 'Đỗ',
              //         scheduledDate: DateTime.now().add(Duration(seconds: 5)));

              //     final snackBar = SnackBar(
              //       content: Text(
              //         'Scheduled in 5 seconds',
              //         style: TextStyle(fontSize: 24),
              //       ),
              //       backgroundColor: Colors.green,
              //     );
              //     ScaffoldMessenger.of(context)
              //       ..removeCurrentSnackBar()
              //       ..showSnackBar(snackBar);
              //   },
              //   icon: Icons.ac_unit,
              //   text: 'Scheduled Notification',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
