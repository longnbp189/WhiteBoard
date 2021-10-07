import 'dart:convert';

import 'package:http/http.dart' as http;

class PostRequest {
  static const String url =
      'https://ec2-13-228-168-85.ap-southeast-1.compute.amazonaws.com/api/v1.0';

  static Future createPost(Map<String, dynamic> body, String token) async {
    // body['status'] = 'New';
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    heads['Authorization'] = 'Bearer $token';
    final response = await http.post(Uri.parse(url + '/reviews'),
        headers: heads, body: jsonEncode(body));

    if (response.statusCode == 201) {
      return true;
    } else
      throw Exception('Not Found');
  }
}
