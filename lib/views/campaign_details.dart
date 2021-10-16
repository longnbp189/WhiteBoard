import 'package:flutter/material.dart';
import 'package:whiteboard_swd/models/campaign.dart';
import 'package:whiteboard_swd/views/criteria_list.dart';
import 'package:whiteboard_swd/views/home_create_post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

class CampaignDetails extends StatelessWidget {
  Campaign campaign;
  String reviewerId;
  String token;

  CampaignDetails(
      {required this.campaign, required this.reviewerId, required this.token});

  @override
  Widget build(BuildContext context) {
    final bool isFlag = campaign.flag!;
    final bool isEnd =
        (compareDate(campaign.endDay, DateTime.now()) >= 0) ? false : true;
    String CampaignName = campaign.name!.trim();
    print(campaign.universityName);
    String subCampaignName = '';
    if (CampaignName.contains('–')) {
      List<String> array = CampaignName.split('–');
      subCampaignName = '- ' + array[1];
      CampaignName = array[0];
    }
    final size = MediaQuery.of(context).size;
    try {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Container(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(60)),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: campaign.image!,
                      width: size.width,
                      height: size.height * 0.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.5,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(60)),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black26,
                        Colors.black45,
                        Colors.black54,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  width: 260,
                  top: 80,
                  left: 20,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          CampaignName,
                          //textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        (subCampaignName != '')
                            ? Text(
                                subCampaignName,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              )
                            : SizedBox(
                                height: 10,
                              ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          (compareDate(campaign.endDay, DateTime.now()) >= 0)
                              ? 'Đang diễn ra 🔥'
                              : 'Đã kết thúc ❄', //${ campaign.endDay.compareTo(DateTime.now()) >= 0} ? 'Đang diễn ra': 'Kết thúc',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(children: [
                          Icon(
                            FontAwesomeIcons.calendarAlt,
                            color: Colors.white,
                          ),
                          Text(
                            '  ' +
                                parseDate(campaign.startDay).substring(0, 5) +
                                ' - ' +
                                parseDate(campaign.endDay),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ])
                      ]),
                ),
                Positioned(
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    iconTheme: IconThemeData(color: Colors.white70),
                  ),
                ),

                //UNIVERSITY LOGO
                Positioned(
                    right: 20,
                    top: size.height * 0.5 - 80,
                    child: Image.asset(
                      'assets/images/fpt-logo.jpg',
                      height: 40,
                    )),

                Positioned(
                    top: size.height * 0.5 - 30,
                    left: 25,
                    child: Center(
                      child: ElevatedButton.icon(
                        icon: Text(
                          'Inside this campaign',
                        ),
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.orange),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          )),
                        ),
                        label: FaIcon(
                          FontAwesomeIcons.angleDoubleRight,
                          size: 15,
                        ),
                       
                        onPressed: () {
                          //view post in campaign
                        },
                      ),
                    )),
                Container(
                  height: size.height * 0.55,
                ),
              ]),
              GFProgressBar(
                padding: EdgeInsets.symmetric(horizontal: 10),
                animation: true,
                lineHeight: 7,
                percentage: 0.3,
                backgroundColor: Colors.grey[300]!,
                progressBarColor:
                    (compareDate(campaign.endDay, DateTime.now()) >= 0)
                        ? Colors.orange
                        : Colors.lightBlue,
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '30 BÀI VIẾT', //number of post
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.lightBlue),
                          ),
                          Expanded(child: SizedBox()),
                          Text(
                            '12',
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(
                            Icons.people_alt_outlined,
                            color: Colors.lightBlue,
                          )
                        ],
                      ),
                      Text(
                        'trên 100 bài viết mục tiêu', //number of post
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        children: CriteriaList()
                            .createCriteriaList(campaign.campaignCriteria, 14),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Mô tả:',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${campaign.description}',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ]),
              ),
              Image.asset(
                isFlag
                    ? 'assets/images/already.png'
                    : 'assets/images/notyet.png',
                height: size.height * 0.25,
              ),
              SizedBox(
                height: 7,
              ),
              Column(children: [
                Text(
                  isFlag
                      ? 'Bạn đã viết bài đánh giá cho chiến dịch này!'
                      : 'Bạn chưa viết bài đánh giá cho chiến dịch này?',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20,
                ),
                (!isEnd || (isEnd & isFlag))
                    ? SizedBox(
                        height: 60,
                        width: size.width,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 22, 0, 20),
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                              ),
                              child: Text(
                                (isFlag)
                                    ? 'Xem bài viết của bạn'
                                    : 'Viết bài ngay',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                  child: Container(
                                padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                ),
                              )),
                            ),
                            FlatButton(
                              height: 60,
                              minWidth: 40,
                              //onPressed: (){},
                              color: Colors.white,
                              textColor: Colors.lightBlue,
                              child: Icon(
                                isFlag
                                    ? FontAwesomeIcons.arrowRight
                                    : Icons.create_outlined,
                              ),
                              onPressed: () {
                                //view post in campaign
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CreatePost(
                                          campaign: campaign,
                                          reviewerId: reviewerId,
                                          token: token,
                                        )));
                              },
                            )
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 20,
                      )
              ]),
            ],
          ),
        ),
      );
    } catch (e) {
      print(e);
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    // appBar: PreferredSize(
    //   preferredSize: Size.fromHeight(300),
    //   child: AppBar(
    //     iconTheme: IconThemeData(color: Colors.white60),
    //     toolbarHeight: 60,
    //     centerTitle: true,
    //     // title: Text(
    //     //   'Chiến dịch',
    //     //   style: TextStyle(
    //     //       fontSize: 18, fontWeight: FontWeight.bold, color: white_blue),
    //     // ),
    //     backgroundColor: Colors.transparent,
    //     //foregroundColor: Colors.black54,
    //     flexibleSpace: ClipRRect(
    //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
    //       child: FadeInImage.assetNetwork(
    //         placeholder: 'assets/images/loading.gif',
    //         image: campaign.image!,
    //         width: size.width,
    //         height: size.height,
    //         fit: BoxFit.cover,

    //       ),
    //     ),
    //   ),
    // ),
    // body:
    // Container(
    //   padding: EdgeInsets.all(15),
    //   child: Column(
    //     // mainAxisAlignment: MainAxisAlignment.start,
    //     // crossAxisAlignment: CrossAxisAlignment.start,

    //     children: [
    //       Stack(children: [
    //         ClipRRect(
    //           borderRadius: BorderRadius.circular(15),
    //           child: FadeInImage.assetNetwork(
    //             placeholder: 'assets/images/loading.gif',
    //             image: campaign.image!,
    //             width: size.width,
    //             height: size.height,
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //         Positioned(
    //             right: 0,
    //             left: 0,
    //             bottom: 5,
    //             child: Center(
    //               child: ElevatedButton.icon(
    //                 icon: Image.asset(
    //                   'assets/icons/fire.png',
    //                   height: 16,
    //                 ),
    //                 style: ButtonStyle(
    //                     foregroundColor:
    //                         MaterialStateProperty.all<Color>(Colors.white),
    //                     backgroundColor:
    //                         MaterialStateProperty.all<Color>(Colors.black38),
    //                     shape:
    //                         MaterialStateProperty.all<RoundedRectangleBorder>(
    //                             RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.all(Radius.circular(10)),
    //                     ))),
    //                 label: Text(
    //                   'Inside this campaign',
    //                 ),
    //                 onPressed: () {
    //                   //view post in campaign
    //                 },
    //               ),
    //             )),
    //       ]),
    //       // SizedBox(
    //       //   height: 20,
    //       // ),
    //       Container(
    //         padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
    //         alignment: Alignment.center,
    //         child: Text(
    //           '${campaign.name}',
    //           textAlign: TextAlign.center,
    //           style: TextStyle(fontSize: 20),
    //         ),
    //       ),
    //       Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //         Text(
    //           'Mô tả:',
    //           textAlign: TextAlign.left,
    //           style: TextStyle(fontWeight: FontWeight.bold),
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Text(
    //           '${campaign.description}',
    //           style: TextStyle(color: Colors.black54),
    //         ),
    //         SizedBox(
    //           height: 15,
    //         ),
    //         Container(
    //           child: Text.rich(TextSpan(
    //               text: 'Trạng thái:',
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //               children: <InlineSpan>[
    //                 //WidgetSpan(child:
    //                 //Icon(Image.asset('assets/icons/freeze.png', height: 16,)))
    //                 //,
    //                 TextSpan(
    //                   text: (compareDate(campaign.endDay, DateTime.now()) >=
    //                           0)
    //                       ? '   Đang diễn ra 🔥'
    //                       : '   Đã kết thúc ❄', //${ campaign.endDay.compareTo(DateTime.now()) >= 0} ? 'Đang diễn ra': 'Kết thúc',
    //                   style: TextStyle(
    //                       color:
    //                           (compareDate(campaign.endDay, DateTime.now()) >=
    //                                   0)
    //                               ? Colors.redAccent
    //                               : Colors.blue[800],
    //                       fontWeight: FontWeight.bold),
    //                 ),
    //               ])),
    //         ),
    //         SizedBox(
    //           height: 15,
    //         ),
    //         Wrap(
    //           direction: Axis.horizontal,
    //           children: CriteriaList()
    //               .createCriteriaList(campaign.campaignCriteria, 16),
    //         ),
    //         SizedBox(
    //           height: 5,
    //         ),
    //         Row(
    //           children: [
    //             Text(
    //               'Ngày bắt đầu nhận bài:',
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //             Expanded(child: SizedBox()),
    //             Text(
    //               parseDate(campaign.startDay),
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //           ],
    //         ),
    //         SizedBox(
    //           height: 5,
    //         ),
    //         Row(
    //           children: [
    //             Text(
    //               'Ngày kết thúc nhận bài:',
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //             Expanded(child: SizedBox()),
    //             Text(
    //               parseDate(campaign.endDay),
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //           ],
    //         ),
    //       ])
    //     ],
    //   ),
    // ),

    // floatingActionButton: FloatingActionButton(
    //   onPressed: () {
    //     Navigator.of(context).push(MaterialPageRoute(
    //         builder: (context) => CreatePost(
    //               campaign: campaign,
    //               reviewerId: reviewerId,
    //               token: token,
    //             )));
    //   },
    //   child: Icon(Icons.create_outlined),
    //   backgroundColor: indigo_blue,
    //   // foregroundColor: Colors.white,
    // ),
  }
}
