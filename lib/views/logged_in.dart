import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whiteboard_swd/components/home_search_bar.dart';
import 'package:whiteboard_swd/models/reviewer.dart';
import 'package:whiteboard_swd/presenters/google_sign_in.dart';
import 'package:whiteboard_swd/views/home_campaign_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;
    // final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    // final size = MediaQuery.of(context).size;
    return SafeArea(
      child: FutureBuilder<Reviewer?>(
        future: GoogleSignInProvider().getInfo(),
        builder: (context, value) {
          if (value.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (value.data != null) {
            return Scaffold(
              appBar: AppBar(
                bottom: PreferredSize(
                  child: HomeSearchBar(),
                  preferredSize: Size.fromHeight(60),
                ),
                backgroundColor: Colors.white,
                title: Text(
                  'Xin chào, ' + value.data!.name.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 18),
                ),
              ),
              body: Container(
                child: CampaignList(
                  universityId: value.data!.universityId!,
                  reviewerId: value.data!.id!,
                  token: value.data!.token!,
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
// =======
//       child: Scaffold(
//         appBar: AppBar(
//           bottom: PreferredSize(
//             child: HomeSearchBar(),
//             //edit searchbar height
//             //haltse
//             preferredSize: Size.fromHeight(45),
//           ),
//           flexibleSpace: FlexibleSpaceBar(
//             background: Container(
//               height: 50,
//               width: 50,
//             ),
//             collapseMode: CollapseMode.pin,
//             title: Text('asdasd'),
//           ),
//           backgroundColor: Colors.white,

//           title: Text(
//             'Xin chào, ' + user.displayName.toString(),
//             style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.normal,
//                 fontSize: 18),
//           ),
//         ),
//         body: Container(
//           child: CampaignList(),
//         ),
// >>>>>>> master
      ),
    );
  }
}
