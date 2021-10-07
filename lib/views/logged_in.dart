import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiteboard_swd/components/home_search_bar.dart';
import 'package:whiteboard_swd/presenters/google_sign_in.dart';
import 'package:whiteboard_swd/views/home_campaign_list.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    // final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            child: HomeSearchBar(),
            //edit searchbar height
            //haltse
            preferredSize: Size.fromHeight(45),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              height: 50,
              width: 50,
            ),
            collapseMode: CollapseMode.pin,
            title: Text('asdasd'),
          ),
          backgroundColor: Colors.white,
          
          title: Text(
            'Xin chào, ' + user.displayName.toString(),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 18),
          ),
        ),
        body: Container(
          child: CampaignList(),
        ),
      ),
    );
  }
}

// TextButton(
          //     onPressed: () {
          //       final provider =
          //           Provider.of<GoogleSignInProvider>(context, listen: false);
          //       provider.logout();
          //     },
          //     child: Text(
          //       'Logout',
          //     )),

// class ListViewPage extends StatefulWidget {
//   @override
//   _ListViewPageState createState() => _ListViewPageState();
// }

// class _ListViewPageState extends State<ListViewPage> {
//   List<Campaign> campaignData = [];

//   @override
//   void initState() {
//     super.initState();
//     NetworkRequest.getAllCampaign().then((dataFromServer) {
//       setState(() {
//         campaignData = dataFromServer;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Expanded(
//           child: ListView.builder(
//               padding: EdgeInsets.all(10),
//               itemCount: campaignData.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '${campaignData[index].description}',
//                           style: TextStyle(fontSize: 16, color: Colors.black),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           campaignData[index].name.toString(),
//                           style: TextStyle(fontSize: 16, color: Colors.black),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               })),
//     );
//   }
// }
