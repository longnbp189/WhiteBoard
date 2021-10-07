import 'package:flutter/material.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({Key? key}) : super(key: key);

  @override
  _HomeSearchBarState createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
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
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 5),
                    hintText: "Tìm kiếm tên chiến dịch",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
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
                  size: 30,
                ))
          ],
        ),
      ),
    );
  }
}
