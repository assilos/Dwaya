import 'dart:ui';

import 'package:Dwaya/controllers/user/liste_controller.dart';
import 'package:Dwaya/controllers/user/produit_controller.dart';
import 'package:random_color/random_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplachScreen extends StatefulWidget {
  SplachScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _SplachScreenState createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  Color mainColor = Color.fromRGBO(236, 236, 236, 1.0);
  Color secondColor = Color.fromRGBO(19, 117, 71, 1.0);
  Color listColor1 = Color.fromRGBO(27, 32, 41, 1.0);
  Color listColor2 = Color.fromRGBO(238, 191, 54, 1.0);
  bool inReorder = false;
  ScrollController scrollController;
  TextEditingController passwordController = TextEditingController();
  ListeController ctrl = new ListeController() ;
  ProduitController ctrl2 = new ProduitController() ;
  bool show = false;
  RandomColor _randomColor = RandomColor();
  Color _color;
  bool showText = true;
  String idListe ;
  @override
  void initState() {
    _color = _randomColor.randomColor(
        colorHue: ColorHue.multiple(colorHues: [ColorHue.green,ColorHue.yellow])
    );
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      show = !show;
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  Widget build(BuildContext context) {
    return Container(
      color : mainColor,
      height: Get.height,
      width:Get.width,
      child: Center(
        child:    Column(
          children: [
            Image.asset('assets/images/logo2.png',
              width: Get.width*0.75,
              height: Get.height*0.75,
            )
          ],
        ),
      ),
    );

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
  }








}
