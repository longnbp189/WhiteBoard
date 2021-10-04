import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:whiteboard_swd/models/campaign.dart';

class NetworkRequest {
  static const String url =
      'https://ec2-13-228-168-85.ap-southeast-1.compute.amazonaws.com/api/v1.0';

  static List<Campaign> parseCampaign(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Campaign> campaigns = list.map((e) => Campaign.fromJson(e)).toList();
    return campaigns;
  }

  static Future<List<Campaign>> getAllCampaign() async {
    final response = await http.get(Uri.parse(url + '/campaigns'));
    if (response.statusCode == 200) {
      return compute(parseCampaign, response.body);
    } else
      throw Exception('Not Found');
  }
}
