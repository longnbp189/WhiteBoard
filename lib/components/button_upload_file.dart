import 'package:flutter/material.dart';
import 'package:whiteboard_swd/utils/color.dart';

class ButtonUploadFile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;
  const ButtonUploadFile(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: white_blue,
        minimumSize: Size.fromHeight(50),
      ),
      onPressed: onClicked,
      child: buildContent());

  Widget buildContent() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 28,
          ),
          SizedBox(
            width: 16,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 22, color: Colors.white),
          )
        ],
      );
}
