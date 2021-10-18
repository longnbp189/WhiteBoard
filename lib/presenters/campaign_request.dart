import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whiteboard_swd/models/campaign.dart';
import 'package:whiteboard_swd/presenters/post_request.dart';

class NetworkRequest {
  static const String url =
      'https://ec2-13-228-168-85.ap-southeast-1.compute.amazonaws.com/api/v1.0';

  static List<Campaign>? parseCampaign(String responseBody) {
    var list = json.decode(responseBody) as Map<String, dynamic>;
    Campaigns campaigns = Campaigns.fromJson(list);
    return campaigns.listCampaign;
  }

  static Future<List<Campaign>?> getAllCampaign(
      String universityId, String reviewerId) async {
    final response = await http
        .get(Uri.parse(url + '/campaigns?universityid=$universityId'));
    if (response.statusCode == 200) {
      final response1 =
          await http.get(Uri.parse(url + '/reviews?reviewerid=$reviewerId'));
      if (response1.statusCode == 200) {
        var parseCampaignList = parseCampaign(response.body);
        var parsePostList = PostRequest.parsePost(response1.body);
        for (var i = 0; i < parseCampaignList!.length; i++) {
          for (var j = 0; j < parsePostList!.length; j++) {
            if (parsePostList[j].campaignId == parseCampaignList[i].id) {
              parseCampaignList[i].flag = true;
            }
          }
        }
        parseCampaignList
            .sort((a, b) => toDate(b.startDay!).compareTo(toDate(a.startDay!)));
        return parseCampaignList;
      } else {
        var result = parseCampaign(response.body);
        result!
            .sort((a, b) => toDate(b.startDay!).compareTo(toDate(a.startDay!)));
        return result;
      }
    } else
      throw Exception('Not Found');
  }
}
