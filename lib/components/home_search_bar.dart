import 'package:flutter/material.dart';
import 'package:whiteboard_swd/utils/color.dart';
import 'package:whiteboard_swd/views/home_campaign_list.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({Key? key}) : super(key: key);

  @override
  _HomeSearchBarState createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                height: size.height * 0.07,
                child: TextFormField(
                  cursorColor: white_blue,
                  textAlign: TextAlign.left,

                  /***********************/
                  enableSuggestions: true,
                  controller: searchController,
                          onFieldSubmitted: (text) {
                            searchController.clear();
                            streamController.add(text);
                          },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 5),
                    hintText: "Tìm kiếm tên chiến dịch",
                    hintStyle: TextStyle(color: white_blue),
                    prefixIcon: Icon(
                      Icons.search,
                      color: white_blue,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: white_blue),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {},
                padding: EdgeInsets.only(bottom: 10),
                icon: Icon(
                  //haltse
                  //change icon and so on :>
                  Icons.filter_list_rounded,
                  color: white_blue,
                  size: 30,
                ))
          ],
        ),
      ),
    );
  }
}
