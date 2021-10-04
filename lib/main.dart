import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiteboard_swd/presenters/google_sign_in.dart';
import 'package:whiteboard_swd/views/home_screen.dart';
import 'package:whiteboard_swd/views/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() => runApp(MyApp());
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Widget Demo',
          home: Controller(),
        ),
      );
}
