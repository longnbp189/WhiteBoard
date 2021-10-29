import 'package:flutter/material.dart';
import 'package:whiteboard_swd/models/criteria.dart';
import 'package:whiteboard_swd/utils/color.dart';

class ChipCustom extends StatefulWidget {
  final bool checked;
  final Function callback;
  final Criteria criteria;
  const ChipCustom(
      {Key? key,
      required this.criteria,
      required this.callback,
      required this.checked})
      : super(key: key);

  @override
  _ChipCustomState createState() => _ChipCustomState();
}

class _ChipCustomState extends State<ChipCustom> {
  bool check = false;

  @override
  void initState() {
    check = widget.checked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: !check
          ? BoxDecoration(
              border: Border.all(color: grey_text),
              borderRadius: BorderRadius.all(Radius.circular(30)))
          : null,
      child: ChoiceChip(
        avatar: check
            ? Icon(
                Icons.check,
                color: white_blue,
              )
            : null,
        padding: EdgeInsets.all(10),
        backgroundColor: Colors.white,
        selected: check,
        selectedColor: white_blue_white,
        onSelected: (bool value) {
          setState(() {
            if (value)
              widget.callback(1, widget.criteria.id);
            else
              widget.callback(-1, widget.criteria.id);
            check = value;
          });
        },
        label: Text(
          widget.criteria.name.toString(),
          style: TextStyle(fontSize: 16, color: check ? white_blue : grey_text),
        ),
      ),
    );
  }
}
