import 'package:flutter/material.dart';
import 'package:whiteboard_swd/models/campaign.dart';
import 'package:whiteboard_swd/models/criteria.dart';
import 'package:whiteboard_swd/utils/color.dart';
import 'package:whiteboard_swd/presenters/network_request.dart';
import 'package:whiteboard_swd/views/home_create_post.dart';

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

  List<Widget> criteriaList(List<Criteria>? campaignCriteria) {
    List<Widget> criList = [];
    for (var i = 0; i < campaignCriteria!.length; i++) {
      criList.add(
        Padding(
          padding: const EdgeInsets.only(right: 5, bottom: 5),
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              border: Border.all(width: 1),
            ),
            child: Text(
              campaignCriteria[i].name.toString(),
              style: TextStyle(fontSize: 12),
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
    for (var i = 0; i < campaignData.length; i++) {
      list.add(InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreatePost(
                    campaign: campaignData[i],
                    reviewerId: reviewerId,
                    token: token,
                  )));
        },
        child: Container(
          height: size.height * 0.37,
          width: size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1),
          ),
          child: Column(
            children: [
              if (campaignData[i].image.toString() != '')
                Container(
                  height: size.height * 0.16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    image: DecorationImage(
                      image: NetworkImage(campaignData[i].image.toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          campaignData[i].unis![0].universityName.toString() +
                              ' - ' +
                              campaignData[i].unis![0].campusName.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )),
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
                          color: grey_text,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // Row(
                      //   children: (campaignData[i].campaignCriteria!.length > 0)
                      //       ? criteriaList(campaignData[i].campaignCriteria)
                      //       : [SizedBox()],
                      // ),
                      Wrap(
                          direction: Axis.horizontal,
                          children:
                              criteriaList(campaignData[i].campaignCriteria)),
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
    // return Container(
    //   child: Expanded(
    //     child: ListView.builder(
    //       padding: EdgeInsets.all(10),
    //       itemCount: campaignData.length,
    //       itemBuilder: (context, index) {
    //         return Card(
    //           child: Padding(
    //             padding: EdgeInsets.all(10),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   '${campaignData[index].description}',
    //                   style: TextStyle(fontSize: 16, color: Colors.black),
    //                 ),
    //                 SizedBox(
    //                   height: 10,
    //                 ),
    //                 Text(
    //                   campaignData[index].name.toString(),
    //                   style: TextStyle(fontSize: 16, color: Colors.black),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    // );
    return FutureBuilder<List<Campaign>?>(
      future: NetworkRequest.getAllCampaign(widget.universityId),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  direction: Axis.horizontal,
                  children: campaignList(
                      snapshot.data!, widget.reviewerId, widget.token),
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
  }
}
