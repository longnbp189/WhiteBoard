import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whiteboard_swd/models/campaign.dart';

class NetworkRequest {
  static const String url =
      'https://ec2-13-228-168-85.ap-southeast-1.compute.amazonaws.com/api/v1.0';

  static List<Campaign>? parseCampaign(String responseBody) {
    // var list = json.decode(responseBody) as List;
    // List<Campaign> campaigns = list.map((e) => Campaign.fromJson(e)).toList();

    var list = json.decode(responseBody) as Map<String, dynamic>;
    Campaigns campaigns = Campaigns.fromJson(list);
    return campaigns.listCampaign;
  }

  static Future<List<Campaign>?> getAllCampaign() async {
    final response = await http.get(Uri.parse(url + '/campaigns/search'));
    if (response.statusCode == 200) {
      return parseCampaign(response.body);
    } else
      throw Exception('Not Found');
  }
}
