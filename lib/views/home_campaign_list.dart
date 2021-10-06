import 'package:flutter/material.dart';
import 'package:whiteboard_swd/models/campaign.dart';
import 'package:whiteboard_swd/models/criteria.dart';
import 'package:whiteboard_swd/utils/color.dart';
import 'package:whiteboard_swd/presenters/network_request.dart';

class CampaignList extends StatefulWidget {
  const CampaignList({Key? key}) : super(key: key);

  @override
  _CampaignListState createState() => _CampaignListState();
}

class _CampaignListState extends State<CampaignList> {
  List<Campaign>? campaignData = [];

  @override
  void initState() {
    super.initState();
    NetworkRequest.getAllCampaign().then((dataFromServer) {
      // dataFromServer.add(Campaign(
      //     image:
      //         'https://hcmuni.fpt.edu.vn/Data/Sites/1/media/kho%E1%BA%A3nh-kh%E1%BA%AFc-%C4%91%E1%BB%9Di-l%C3%ADnh/72211011_1369286846561085_7354137037672284160_o.jpg',
      //     university: 'FPT',
      //     campus: 'HCM',
      //     name: 'Quân sự',
      //     description:
      //         'Hãy miêu tả 1 kỷ niệm đẹp của bạn trong khoảng thời gian học quân sự.',
      //     endDay: '2021-09-01T00:00:00',
      //     campaignCriteria: [
      //       Criteria(name: 'sinh hoạt'),
      //       Criteria(name: 'hoạt động'),
      //       Criteria(name: 'môi trường'),
      //       Criteria(name: 'cở sở vật chất'),
      //     ]));
      // dataFromServer.add(Campaign(
      //     image:
      //         'https://hcmuni.fpt.edu.vn/Data/Sites/1/media/kho%E1%BA%A3nh-kh%E1%BA%AFc-%C4%91%E1%BB%9Di-l%C3%ADnh/72211011_1369286846561085_7354137037672284160_o.jpg',
      //     university: 'FPT',
      //     campus: 'HCM',
      //     name: 'Quân sự',
      //     description:
      //         'Hãy miêu tả 1 kỷ niệm đẹp của bạn trong khoảng thời gian học quân sự.',
      //     endDay: '2021-09-01T00:00:00',
      //     campaignCriteria: [
      //       Criteria(name: 'môi trường'),
      //       Criteria(name: 'cở sở vật chất'),
      //     ]));
      // dataFromServer.add(Campaign(
      //     image:
      //         'https://hcmuni.fpt.edu.vn/Data/Sites/1/media/kho%E1%BA%A3nh-kh%E1%BA%AFc-%C4%91%E1%BB%9Di-l%C3%ADnh/72211011_1369286846561085_7354137037672284160_o.jpg',
      //     university: 'FPT',
      //     campus: 'HCM',
      //     name: 'Quân sự',
      //     description:
      //         'Hãy miêu tả 1 kỷ niệm đẹp của bạn trong khoảng thời gian học quân sự.',
      //     endDay: '2021-09-01T00:00:00',
      //     campaignCriteria: [
      //       // Criteria(name: 'moi truong'),
      //       Criteria(name: 'cở sở vật chất'),
      //     ]));
      // dataFromServer.add(Campaign(
      //     image:
      //         'https://cover.talk.zdn.vn/8/7/c/9/9/4be6fd7b52591b31928ae75200c5e561.jpg',
      //     school: 'FPT',
      //     campus: 'HCM',
      //     name: 'quan su',
      //     description: 'aksjdbhsasdasdasdjkashdjkashkdjahsjkdasdasdasdasdasd',
      //     endDay: '2021-09-01T00:00:00',
      //     campaignCriteria: [
      //       Criteria(name: 'moi truong'),
      //       Criteria(name: 'co so vat chat'),
      //     ]));
      // dataFromServer.add(Campaign(
      //     image:
      //         'https://cover.talk.zdn.vn/8/7/c/9/9/4be6fd7b52591b31928ae75200c5e561.jpg',
      //     school: 'FPT',
      //     campus: 'HCM',
      //     name: 'quan su',
      //     description: 'aksjdbhsasdasdasdjkashdjkashkdjahsjkdasdasdasdasdasd',
      //     endDay: '2021-09-01T00:00:00',
      //     campaignCriteria: [
      //       Criteria(name: 'moi truong'),
      //       Criteria(name: 'co so vat chat'),
      //     ]));
      // dataFromServer.add(Campaign(
      //     image:
      //         'https://cover.talk.zdn.vn/8/7/c/9/9/4be6fd7b52591b31928ae75200c5e561.jpg',
      //     school: 'FPT',
      //     campus: 'HCM',
      //     name: 'quan su',
      //     description: 'aksjdbhsasdasdasdjkashdjkashkdjahsjkdasdasdasdasdasd',
      //     endDay: '2021-09-01T00:00:00',
      //     campaignCriteria: [
      //       Criteria(name: 'moi truong'),
      //       Criteria(name: 'co so vat chat'),
      //     ]));
      // dataFromServer.add(Campaign(
      //     image:
      //         'https://cover.talk.zdn.vn/8/7/c/9/9/4be6fd7b52591b31928ae75200c5e561.jpg',
      //     school: 'FPT',
      //     campus: 'HCM',
      //     name: 'quan su',
      //     description: 'aksjdbhsasdasdasdjkashdjkashkdjahsjkdasdasdasdasdasd',
      //     endDay: '2021-09-01T00:00:00',
      //     campaignCriteria: [
      //       Criteria(name: 'moi truong'),
      //       Criteria(name: 'co so vat chat'),
      //     ]));
      // dataFromServer.add(Campaign(
      //     image:
      //         'https://cover.talk.zdn.vn/8/7/c/9/9/4be6fd7b52591b31928ae75200c5e561.jpg',
      //     school: 'FPT',
      //     campus: 'HCM',
      //     name: 'quan su',
      //     description: 'aksjdbhsasdasdasdjkashdjkashkdjahsjkdasdasdasdasdasd',
      //     endDay: '2021-09-01T00:00:00',
      //     campaignCriteria: [
      //       Criteria(name: 'moi truong'),
      //       Criteria(name: 'co so vat chat'),
      //     ]));
      // dataFromServer.add(Campaign(
      //     image:
      //         'https://cover.talk.zdn.vn/8/7/c/9/9/4be6fd7b52591b31928ae75200c5e561.jpg',
      //     school: 'FPT',
      //     campus: 'HCM',
      //     name: 'quan su',
      //     description: 'aksjdbhsasdasdasdjkashdjkashkdjahsjkdasdasdasdasdasd',
      //     endDay: '2021-09-01T00:00:00',
      //     campaignCriteria: [
      //       Criteria(name: 'moi truong'),
      //       Criteria(name: 'co so vat chat'),
      //     ]));
      setState(() {
        campaignData = dataFromServer;
      });
    });
  }

  // List<Widget> criteriaList(List<Criteria>? campaignCriteria) {
  //   List<Widget> criList = [];
  //   if (campaignCriteria!.length == 1) {
  //     criList.add(Padding(
  //       padding: const EdgeInsets.only(right: 5),
  //       child: Container(
  //         padding: EdgeInsets.all(1),
  //         decoration: BoxDecoration(
  //           border: Border.all(width: 1),
  //         ),
  //         child: Text(
  //           campaignCriteria[0].name.toString(),
  //           style: TextStyle(fontSize: 12),
  //         ),
  //       ),
  //     ));
  //   } else if (campaignCriteria[0].name!.length +
  //           campaignCriteria[1].name!.length <=
  //       18) {
  //     criList.add(Padding(
  //       padding: const EdgeInsets.only(right: 5),
  //       child: Container(
  //         padding: EdgeInsets.all(1),
  //         decoration: BoxDecoration(
  //           border: Border.all(width: 1),
  //         ),
  //         child: Text(
  //           campaignCriteria[0].name.toString(),
  //           style: TextStyle(fontSize: 12),
  //         ),
  //       ),
  //     ));

  //     criList.add(Padding(
  //       padding: const EdgeInsets.only(right: 5),
  //       child: Container(
  //         padding: EdgeInsets.all(1),
  //         decoration: BoxDecoration(
  //           border: Border.all(width: 1),
  //         ),
  //         child: Text(campaignCriteria[1].name.toString(),
  //             style: TextStyle(fontSize: 12)),
  //       ),
  //     ));
  //     if (campaignCriteria.length > 2) {
  //       criList.add(Container(
  //         padding: EdgeInsets.all(1),
  //         decoration: BoxDecoration(
  //           border: Border.all(width: 1),
  //         ),
  //         child: Text('+' + (campaignCriteria.length - 2).toString(),
  //             style: TextStyle(fontSize: 12)),
  //       ));
  //     }
  //   } else {
  //     criList.add(Padding(
  //       padding: const EdgeInsets.only(right: 5),
  //       child: Container(
  //         padding: EdgeInsets.all(1),
  //         decoration: BoxDecoration(
  //           border: Border.all(width: 1),
  //         ),
  //         child: Text(
  //           campaignCriteria[0].name.toString(),
  //           style: TextStyle(fontSize: 12),
  //         ),
  //       ),
  //     ));
  //     criList.add(Container(
  //       padding: EdgeInsets.all(1),
  //       decoration: BoxDecoration(
  //         border: Border.all(width: 1),
  //       ),
  //       child: Text('+' + (campaignCriteria.length - 1).toString(),
  //           style: TextStyle(fontSize: 12)),
  //     ));
  //   }
  //   return criList;
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

  List<Widget> campaignList() {
    final size = MediaQuery.of(context).size;
    List<Widget> list = [];
    for (var i = 0; i < campaignData!.length; i++) {
      list.add(Container(
        height: size.height * 0.37,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1),
        ),
        child: Column(
          children: [
            if (campaignData![i].image.toString() != '')
              Container(
                height: size.height * 0.16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  image: DecorationImage(
                    image: NetworkImage(
                      campaignData![i].image != null
                          ? campaignData![i].image.toString()
                          : 'https://kenh14cdn.com/thumb_w/600/pr/2020/photo-1-159188526439782241575-0-39-870-1431-crop-1591885573914-63727516282294.jpg',
                    ),
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
                        campaignData![i].unis![0].universityName.toString() +
                            ' - ' +
                            campaignData![i].unis![0].campusName.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        )),
                    Text(
                      campaignData![i].name.toString(),
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
                      campaignData![i].description.toString(),
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
                            criteriaList(campaignData![i].campaignCriteria)),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(child: SizedBox()),
                        Text(
                          'Hạn chót: ' + parseDate(campaignData![i].endDay),
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            direction: Axis.horizontal,
            children: campaignList(),
          ),
        ),
      ),
    );
  }
}
