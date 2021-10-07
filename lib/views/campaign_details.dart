import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whiteboard_swd/models/campaign.dart';
import 'package:whiteboard_swd/views/criteria_list.dart';
import 'package:intl/intl.dart';
import 'package:whiteboard_swd/utils/color.dart';
import 'package:whiteboard_swd/views/home_create_post.dart';

class CampaignDetails extends StatelessWidget {
  Campaign campaign;
  String reviewerId;
  String token;

  CampaignDetails(
      {required this.campaign, required this.reviewerId, required this.token});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formatter = DateFormat('dd/MM/yyyy');
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white_blue),
        toolbarHeight: 60,
        centerTitle: true,
        title: Text(
          'Chiến dịch',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: white_blue),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black54,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loading.gif',
                  image: campaign.image!,
                  width: size.width,
                  height: size.height * 0.25,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  right: 0,
                  left: 0,
                  bottom: 5,
                  child: Center(
                    child: ElevatedButton.icon(
                      icon: Image.asset(
                        'assets/icons/fire.png',
                        height: 16,
                      ),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black38),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ))),
                      label: Text(
                        'Inside this campaign',
                      ),
                      onPressed: () {
                        //view post in campaign
                      },
                    ),
                  )),
            ]),
            // SizedBox(
            //   height: 20,
            // ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
              alignment: Alignment.center,
              child: Text(
                '${campaign.name}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              SizedBox(
                height: 15,
              ),
              Container(
                child: Text.rich(TextSpan(
                    text: 'Trạng thái:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    children: <InlineSpan>[
                      //WidgetSpan(child:
                      //Icon(Image.asset('assets/icons/freeze.png', height: 16,)))
                      //,
                      TextSpan(
                        text: (compareDate(campaign.endDay, DateTime.now()) >=
                                0)
                            ? '   Đang diễn ra 🔥'
                            : '   Đã kết thúc ❄', //${ campaign.endDay.compareTo(DateTime.now()) >= 0} ? 'Đang diễn ra': 'Kết thúc',
                        style: TextStyle(
                            color:
                                (compareDate(campaign.endDay, DateTime.now()) >=
                                        0)
                                    ? Colors.redAccent
                                    : Colors.blue[800],
                            fontWeight: FontWeight.bold),
                      ),
                    ])),
              ),
              SizedBox(
                height: 15,
              ),
              Wrap(
                direction: Axis.horizontal,
                children: CriteriaList()
                    .createCriteriaList(campaign.campaignCriteria, 16),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    'Ngày bắt đầu nhận bài:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    parseDate(campaign.startDay),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    'Ngày kết thúc nhận bài:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    parseDate(campaign.endDay),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ])
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreatePost(
                    campaign: campaign,
                    reviewerId: reviewerId,
                    token: token,
                  )));
        },
        child: Icon(Icons.create_outlined),
        backgroundColor: indigo_blue,
        // foregroundColor: Colors.white,
      ),
    );
  }
}
