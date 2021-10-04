import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool? isSigningIn;
  static const String url =
      'https://ec2-13-228-168-85.ap-southeast-1.compute.amazonaws.com/api​/v1.0​/reviewers​/authenticate';

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
    var u = await FirebaseAuth.instance.currentUser!.getIdToken();

    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  Future<String> getTokenId() async {
    return await FirebaseAuth.instance.currentUser!.getIdToken();
  }
}