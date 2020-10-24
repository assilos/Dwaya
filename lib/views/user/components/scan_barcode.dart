import 'dart:async';

import 'package:Dwaya/controllers/user/produit_controller.dart';
import 'package:Dwaya/models/user/produit.dart';
import 'package:Dwaya/views/user/layouts/main/main_tab.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animated_dialog_box/animated_dialog_box.dart';
class Scan extends StatefulWidget {
  Scan({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  _ScanState createState() => _ScanState();
}
class _ScanState extends State<Scan> {
  Color mainColor = Color.fromRGBO(236, 236, 236, 1.0);
  Color secondColor = Color.fromRGBO(19, 117, 71, 1.0);
  List<Produit> a = List<Produit>() ;
  int _counter = 0;
  GlobalKey<ScaffoldState> key= new GlobalKey<ScaffoldState>();
  String _scanBarcode = 'Unknown';
  String _url = 'https://1ea64b7a3d28.ngrok.io';
  ProduitController ctrl = new ProduitController() ;
  WebViewController _controller;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference scans = FirebaseFirestore.instance.collection('scan');
  @override
  initState() {
    new Future.delayed(const Duration(seconds: 1))
        .then((_)=>_buildSnackBar()
    );
    super.initState();
  }
  _buildSnackBar (){

 Get.snackbar('Bienvenue', 'Vous pouvez commencez votre shopping !',colorText: Colors.white,icon: Icon(Icons.shopping_cart),duration: Duration(seconds: 5),backgroundColor: secondColor);
  }
  void _onAddToCache(WebViewController controller, BuildContext context) async {
    await controller.evaluateJavascript(
        'caches.open("test_caches_entry"); localStorage["test_localStorage"] = "dummy_entry";');
    Scaffold.of(context).showSnackBar(const SnackBar(
      content: Text('Added a test entry to cache.'),
    ));
  }
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print("Barcodeeee") ;
      print(barcodeScanRes);
          await  addUser(barcodeScanRes);
      Get.snackbar('Ajouté !', 'Produit ajouté au panier !',duration:  Duration(seconds: 5),snackPosition: SnackPosition.TOP,colorText: Colors.white,backgroundColor: secondColor);

      //    channel.sink.add('Hello!');
     // _onAddToCache(_controller,context);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
     _controller.loadUrl('https://acf59a5b6c1d.ngrok.io');
    });
  }
  Future<void> addUser(String barcode) async {
    // Call the user's CollectionReference to add a new user
    return scans
        .add({
      'idClient': '5f33d3a99bb45dc5468c6513', // John Doe
      'barcode': barcode, // Stokes an
      // d Sons
    })
        .then((value) => print(value.documentID))
        .catchError((error) => print("Failed to add user: $error"));
  }
  Widget build(BuildContext context) {

    return (Scaffold(
      key: key,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: 200,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Search",
                        icon: Icon(Icons.search),
                        border: InputBorder.none),
                  ),
                ),
              ],
            ),
            height: 35.00,
            width: 300,
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 3.00),
                  color: Color(0xff000000).withOpacity(0.16),
                  blurRadius: 6,
                ),
              ],
              borderRadius: BorderRadius.circular(20.00),
            ),
          ),
          centerTitle: true,
        ),
      ),
      backgroundColor: mainColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(0.0,Get.height*0.06,0.0,0.0),
        child: Center(
          child: Column(
            children: [
              RawMaterialButton(
                fillColor: secondColor,
                splashColor: mainColor,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Scanner le Code à barres",
                        maxLines: 1,
                        style: TextStyle(color: Colors.white,fontSize: 15),
                      ),
                    ],
                  ),
                ),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)
                ),
                onPressed: () async {

                 scanBarcodeNormal();


                },
              ),
              Container(
                height: Get.height*0.68,
                width: Get.width,
                child: WebView(
                  initialUrl: _url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller = webViewController;
                  },
                  javascriptChannels: <JavascriptChannel>[
                    JavascriptChannel(name: 'Print', onMessageReceived: (JavascriptMessage msg) { print(msg); }),
                  ].toSet(),
                ),
              ),
              RawMaterialButton(
                fillColor: secondColor,
                splashColor: mainColor,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Retour à l'application",
                        maxLines: 1,
                        style: TextStyle(color: Colors.white,fontSize: 15),
                      ),
                    ],
                  ),
                ),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)
                ),
                onPressed: () async {
                  print("lololololol");
                  Get.to(MainTab()) ;
                },
              )
            ],
          ),
        ),
      ),
    ));

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
  }
  @override
  void dispose() {
    super.dispose();
  }
}

