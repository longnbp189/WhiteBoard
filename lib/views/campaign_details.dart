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
    // final bool isEnd =
    //     (compareDate(campaign.endDay, DateTime.now()) >= 0) ? false : true;
    final campaignStatus = (compareDate(campaign.startDay, DateTime.now()) > 0)
        ? -1
        : (compareDate(campaign.endDay, DateTime.now()) < 0)
            ? 1
            : 0;
    print(campaignStatus);
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
                          (campaignStatus == -1)
                              ? 'Sắp diễn ra 💣'
                              : (campaignStatus == 0)
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

                (campaignStatus >= 0)
                    ? Positioned(
                        top: size.height * 0.5 - 30,
                        left: 25,
                        child: Center(
                          child: ElevatedButton.icon(
                            icon: Text(
                              'Inside this campaign',
                            ),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.orange),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
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
                        ))
                    : SizedBox(),
                Container(
                  height: size.height * 0.55,
                ),
              ]),
              GFProgressBar(
                padding: EdgeInsets.symmetric(horizontal: 10),
                animation: true,
                lineHeight: 7,
                percentage: (campaignStatus == -1) ? 0 : 0.3,
                backgroundColor: Colors.grey[300]!,
                progressBarColor:
                    (campaignStatus >= 0) ? Colors.orange : Colors.lightBlue,
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (campaign.reviewerJoined.toString() != null)
                          ? Row(
                              children: [
                                Icon(
                                  Icons.people_alt_outlined,
                                  color: Colors.lightBlue,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  campaign.reviewerJoined.toString() +
                                      ' người đã tham gia chiến dịch này.', //number of post
                                  style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.lightBlue),
                                ),
                                // Expanded(child: SizedBox()),
                                // Text(
                                //   '12',
                                //   style: TextStyle(fontSize: 20),
                                // ),
                                // Icon(
                                //   Icons.people_alt_outlined,
                                //   color: Colors.lightBlue,
                                // )
                              ],
                            )
                          : SizedBox(),
                      // Text(
                      //   'trên 100 bài viết mục tiêu', //number of post
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        children: CriteriaList()
                            .createCriteriaList(campaign.campaignCriteria, 16),
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
                        style: TextStyle(color: Colors.black),
                      ),
                    ]),
              ),
              Image.asset(
                campaignStatus == -1
                    ? 'assets/images/ready.png'
                    : isFlag
                        ? 'assets/images/already.png'
                        : 'assets/images/notyet.png',
                height: size.height * 0.25,
              ),
              SizedBox(
                height: 7,
              ),
              Column(children: [
                Text(
                  campaignStatus == -1
                      ? 'Bạn đã sẵn sàng cho chiến dịch này chưa?'
                      : isFlag
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
                (campaignStatus == 0 || ((campaignStatus > 0) & isFlag))
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
                              color: Colors.white,
                              textColor: Colors.lightBlue,
                              child: Icon(
                                isFlag
                                    ? FontAwesomeIcons.arrowRight
                                    : Icons.create_outlined,
                              ),
                              onPressed: () {
                                // isFlag
                                // ////view post in campaign
                                // ?
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CreatePost(
                                          campaign: campaign,
                                          reviewerId: reviewerId,
                                          token: token,
                                        )));
                                ////create post
                                // :
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => CreatePost(
                                //           campaign: campaign,
                                //           reviewerId: reviewerId,
                                //           token: token,
                                //         )));
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
  }
}
