import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whiteboard_swd/models/post.dart';
import 'package:whiteboard_swd/utils/color.dart';
import 'package:whiteboard_swd/views/post_screen.dart';

class TabbedAppBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: Colors.white,
          leadingWidth: 0,
          centerTitle: true,
          title: (Text(
            'Bài viết',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: white_blue),
          )),
          bottom: TabBar(
            tabs: choices.map<Widget>(
              (Choice choice) {
                return Tab(
                  // text: choice.title,
                  child: Text(
                    choice.title,
                    style: TextStyle(fontSize: 16, color: white_blue),
                  ),
                );
              },
            ).toList(),
          ),
        ),
        body: TabBarView(
          children: choices.map(
            (Choice choice) {
              return ChoicePage(
                choice: choice,
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

class Choice {
  final String title;
  const Choice({required this.title});
}

const List<Choice> choices = <Choice>[
  Choice(title: 'Đã duyệt'),
  Choice(title: 'Chờ xử lí'),
  Choice(title: 'Bị từ chối')
];

class ChoicePage extends StatelessWidget {
  final Choice choice;
  const ChoicePage({Key? key, required this.choice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? list;
    if (choice.title == 'Đã duyệt') list = 'Public';
    if (choice.title == 'Chờ xử lí') list = 'Waiting';
    if (choice.title == 'Bị từ chối') list = 'Unpublished';
    // final TextStyle? textStyle = Theme.of(context).textTheme.display1;
    return PostPage(
      statusPost: list!,
    );
  }
}
