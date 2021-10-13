import 'package:flutter/material.dart';
import 'package:whiteboard_swd/utils/color.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({Key? key}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white_blue),
        toolbarHeight: 60,
        centerTitle: true,
        title: Text(
          'Chiến dịch',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: white_blue),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black54,
      ),
    );
  }
}
