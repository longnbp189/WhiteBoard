import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whiteboard_swd/models/campaign.dart';
import 'package:whiteboard_swd/models/criteria.dart';
import 'package:whiteboard_swd/utils/color.dart';
import 'package:whiteboard_swd/presenters/campaign_request.dart';
import 'package:whiteboard_swd/views/home_create_post.dart';
import 'package:whiteboard_swd/views/campaign_details.dart';

class CampaignList extends StatefulWidget {
  final String universityId;
  final String reviewerId;
  final String token;
  const CampaignList(
      {Key? key,
      required this.universityId,
      required this.reviewerId,
      required this.token})
      : super(key: key);

  @override
  _CampaignListState createState() => _CampaignListState();
}

class _CampaignListState extends State<CampaignList> {
  // List<Campaign>? campaignData = [];

  // @override
  // void initState() {
  //   super.initState();
  //   NetworkRequest.getAllCampaign(widget.universityId).then((dataFromServer) {
  //     setState(() {
  //       campaignData = dataFromServer;
  //     });
  //   });
  // }

  List<Widget> criteriaList(
      List<Criteria>? campaignCriteria, double iFontSize) {
    List<Widget> criList = [];
    for (var i = 0; i < campaignCriteria!.length; i++) {
      criList.add(
        Padding(
          padding: const EdgeInsets.only(right: 5, bottom: 5),
          child: Container(
            padding: EdgeInsets.all(iFontSize * 0.4),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: white_blue),
              //color: Colors.lightBlue[100],
              borderRadius: BorderRadius.circular(iFontSize),
              //border: Border.all(width: 1),
            ),
            child: Text(
              campaignCriteria[i].name.toString(),
              style: TextStyle(fontSize: iFontSize, color: white_blue),
            ),
          ),
        ),
      );
    }
    return criList;
  }

  List<Widget> campaignList(
      List<Campaign> campaignData, String reviewerId, String token) {
    final size = MediaQuery.of(context).size;
    List<Widget> list = [];
// <<<<<<< HEAD
//     for (var i = 0; i < campaignData.length; i++) {
//       list.add(InkWell(
//         onTap: () {
//           Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => CreatePost(
//                     campaign: campaignData[i],
//                     reviewerId: reviewerId,
//                     token: token,
//                   )));
//         },
//         child: Container(
//           height: size.height * 0.37,
//           width: size.width * 0.8,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             border: Border.all(width: 1),
//           ),
//           child: Column(
//             children: [
//               if (campaignData[i].image.toString() != '')
//                 Container(
//                   height: size.height * 0.16,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(5),
//                         topRight: Radius.circular(5)),
//                     image: DecorationImage(
//                       image: NetworkImage(campaignData[i].image.toString()),
// =======
    for (var i = 0; i < campaignData.length; i++) {
      list.add(
          //HaLTSE
          //change container to inkwell for interaction
          //add onTap()
          InkWell(
        borderRadius: BorderRadius.circular(10),
        splashColor: dart_blue,
        highlightColor: white_blue_white,

        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CampaignDetails(
                    campaign: campaignData[i],
                    reviewerId: reviewerId,
                    token: token,
                  ) //send param using constructor
              ));
        },
        //haltse removed these locs
        // height: size.height * 0.37,
        // width: size.width * 0.8,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(5),
        //   border: Border.all(width: 1),
        // ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          width: size.width - 2 * 10, //padding = 10
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: white_blue.withOpacity(0.2), //color of shadow
                spreadRadius: 3, //spread radius
                blurRadius: 5, // blur radius
                offset: Offset(0, 2), // changes position of shadow
                //first paramerter of offset is left-right
                //second parameter is top to down
              ),
              //you can set more BoxShadow() here
            ],
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              // if (campaignData[i].image.toString() != '')
              Container(
                height: size.height * 0.16,
                child: Stack(
                  children: [
                    Container(
                      // width: size.width - 20,
                      height: size.height * 0.16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        image: DecorationImage(
                          image: NetworkImage(campaignData[i].image.toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    (compareDate(campaignData[i].startDay, DateTime.now()) < 0)
                        ? Align(
                            alignment: Alignment.topRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.lightGreen[100],
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    //border: Border.all(width: 1),
                                  ),
                                  child: Text(
                                    'Đang diễn ra',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.lightGreen[800]),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.amber[100],
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                //border: Border.all(width: 1),
                              ),
                              child: Text(
                                'Sắp diễn ra',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.amber[800]),
                              ),
                            ),
                          ),
                    // if (campaignData[i].flag!)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.lightGreen[100],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                          ),
                          //border: Border.all(width: 1),
                        ),
                        child: Text(
                          '🎯 Đã tham gia',
                          style: TextStyle(
                              fontSize: 12, color: Colors.lightGreen[800]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //color: Colors.white,
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                  campaignData[i].universityName.toString() +
                                      ' - ' +
                                      campaignData[i].campusName.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  )),
                            ),
                          ),
                          if (campaignData[i].averageRatings != null &&
                              campaignData[i].averageRatings != 0.0)
                            Row(
                              children: [
                                Text(campaignData[i].averageRatings.toString()),
                                SizedBox(
                                  width: 2,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                )
                              ],
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        campaignData[i].name.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),

                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        campaignData[i].description.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Row(
                      //   children: (campaignData[i].campaignCriteria!.length > 0)
                      //       ? criteriaList(campaignData[i].campaignCriteria)
                      //       : [SizedBox()],
                      // ),
                      Wrap(
                          spacing: 2,
                          runSpacing: 2,
                          direction: Axis.horizontal,
                          children: criteriaList(
                              campaignData[i].campaignCriteria, 14)),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(child: SizedBox()),
                          Text(
                            'Hạn chót: ' + parseDate(campaignData[i].endDay),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Campaign>?>(
      future:
          NetworkRequest.getAllCampaign(widget.universityId, widget.reviewerId),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              color: white_blue_white,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 22,
                    direction: Axis.horizontal,
                    children: campaignList(
                        snapshot.data!, widget.reviewerId, widget.token),
                  ),
                ),
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
// =======
//     return SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         //haltse
//         //wrap padding with container to add background color :>
//         child: Container(
//           color: white_blue_white,
//           child: Padding(
//             padding: const EdgeInsets.all(13),
//             child: Center(
//               child: Wrap(
//                 spacing: 12,
//                 runSpacing: 20,
//                 direction: Axis.horizontal,
//                 children: campaignList(),
//               ),
//             ),
//           ),
//         ));
// >>>>>>> master
  }
}
