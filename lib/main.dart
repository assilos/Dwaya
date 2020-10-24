import 'package:Dwaya/views/user/components/historique_interface.dart';
import 'package:Dwaya/views/user/components/profil.dart';
import 'package:Dwaya/views/user/components/shopping.dart';
import 'package:Dwaya/views/user/layouts/main/main_tab.dart';
import 'package:Dwaya/views/user/layouts/main/splach_screen.dart';
import 'package:Dwaya/views/user/user_view.dart';
import 'package:Dwaya/views/user/components/details_produits.dart';
import 'package:Dwaya/views/user/layouts/main/main_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

  //Future checkIfLoggedIn;
 // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  //FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    var initializationSettingsAndroid =
    //AndroidInitializationSettings('@mipmap/ic_launcher');
    //var initializationSettingsIOs = IOSInitializationSettings();
    //var initSetttings = InitializationSettings(
      //  initializationSettingsAndroid, initializationSettingsIOs);

    //flutterLocalNotificationsPlugin.initialize(initSetttings);
  //  scheduleNotification() ;
    super.initState();

  }
/*  Future<void> scheduleNotification() async {
    var scheduledNotificationDateTime =
    DateTime.now().add(Duration(seconds: 20));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'id',
      'channel',
      'description',
      icon: '@mipmap/ic_launcher',
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(

        0,
        'Promotions',
        'Promotion de 50 % sur les produits Saida',
        scheduledNotificationDateTime,
        platformChannelSpecifics,
      payload: 'Default_Sound',

    );
  }
  */

  Future<String> checkauth()
 async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   print(prefs.get('email'));

   return prefs.getString('email') ;
 }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dwaya',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainTab(
      ),
    );
  }





}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  var text = 'Suivant'.obs;
  @override
  Widget build(BuildContext context) {
    Color mainColor = Color.fromRGBO(249, 244, 244,1.0);

    return GetMaterialApp(
      title: 'Dwaya',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UserView(),
    );
  }
}
