import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whiteboard_swd/models/campaign.dart';
import 'package:whiteboard_swd/presenters/campaign_request.dart';
import 'package:whiteboard_swd/presenters/google_sign_in.dart';
import 'package:whiteboard_swd/presenters/post_request.dart';
import 'package:whiteboard_swd/views/campaign_details.dart';
import 'package:whiteboard_swd/views/home_screen.dart';
import 'package:whiteboard_swd/views/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whiteboard_swd/views/post_details.dart';

// void main() => runApp(MyApp());

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      // 'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
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
          home: MyHomePage(
            title: 'hihi',
          ))
      // home: Controller()),
      );
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      final prefs = await SharedPreferences.getInstance();
      // naviation to page
      if (message.data['AboutCampaignID'] != null) {
        String campaignId = message.data['AboutCampaignID'];
        var campaign = await NetworkRequest.getCampaignById(campaignId);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CampaignDetails(
                  campaign: campaign!,
                  reviewerId: prefs.getString("reviewerId")!,
                  token: prefs.getString("token")!,
                ) //send param using constructor
            ));
      }
      if (message.data['AboutReviewID'] != null) {
        String postId = message.data['AboutReviewID'];
        var post = await PostRequest.getPostById(postId);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PostDetail(
                  post: post!,
                ) //send param using constructor
            ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Controller();
  }
}
