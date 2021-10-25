import 'package:flutter/material.dart';

class ExPage extends StatelessWidget {
  final String? payload;
  const ExPage({Key? key, required this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('notification')),
      body: Container(
        child: Column(
          children: [
            Text(
              payload ?? '',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'PAYLOAD',
              style: TextStyle(fontSize: 32),
            )
          ],
        ),
      ),
    );
  }
}
