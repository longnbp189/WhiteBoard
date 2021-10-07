import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whiteboard_swd/models/reviewer.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool? isSigningIn;
  static const String url =
      'https://ec2-13-228-168-85.ap-southeast-1.compute.amazonaws.com/api/v1.0/reviewers/authenticate';

  GoogleSignInProvider() {
    isSigningIn = false;
  }

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  set isSigningInn(bool isSigningInn) {
    isSigningIn = isSigningInn;
    notifyListeners();
  }

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }

  Future<Reviewer> getInfo() async {
    var user = FirebaseAuth.instance.currentUser!;
    Map<String, String> headers = {"Content-type": "application/json"};
    Map<String, dynamic> body = new Map<String, dynamic>();
    body['idToken'] = await user.getIdToken();
    body['name'] = user.displayName!;
    // body['phoneNumber'] = user.phoneNumber!;
    body['avatar'] = user.photoURL!;
    body['birthday'] = "2021-10-06T15:30:43.417Z";
    body['phoneNumber'] = 0;

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));
    var reviewer;
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      reviewer = Reviewer.fromJson(body);
      reviewer.avatar = user.photoURL!;
      reviewer.name = user.displayName!;
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setString('info', response.body);
      // prefs.setString('info', jsonEncode(response.body));
    } else {
      await googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
    }

    return reviewer;
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  Future<Reviewer> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> reviewerJson =
        jsonDecode(prefs.getString(key)!) as Map<String, dynamic>;
    return Reviewer.fromJson(reviewerJson);
  }

  Future<String> getTokenId() async {
    return await FirebaseAuth.instance.currentUser!.getIdToken();
  }
}
