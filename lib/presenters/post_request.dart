import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whiteboard_swd/models/post.dart';

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

  static List<Post>? parsePost(String responseBody) {
    var list = json.decode(responseBody) as Map<String, dynamic>;
    Posts posts = Posts.fromJson(list);
    return posts.listPost;
  }

  static Future<List<Post>?> getPostList() async {
    final prefs = await SharedPreferences.getInstance();
    String? reviewerId = prefs.getString('reviewerId');
    final response =
        await http.get(Uri.parse(url + '/reviews?reviewerid=$reviewerId'));
    if (response.statusCode == 200) {
      return parsePost(response.body);
    } else
      throw Exception('Not Found');
  }
}
