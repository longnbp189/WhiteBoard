import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whiteboard_swd/components/bottom_tab.dart';
import 'package:whiteboard_swd/utils/color.dart';

Widget buildCompleted(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return Scaffold(
    body: Column(
      children: [
        Container(
          height: size.height - 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Icon(
                  Icons.check_circle,
                  size: 120,
                  color: white_blue,
                ),
              ),
              Center(
                child: Text(
                  'Gửi thành công\nĐang chờ xử lý',
                  style: TextStyle(
                      color: white_blue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        Container(
            width: size.width - 80,
            height: size.height * 0.06,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => BottomTab()));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(white_blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ))),
              child: Text(
                'Trang chủ',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ))
      ],
    ),
  );
}
