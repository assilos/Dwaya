import 'dart:ui';

import 'package:Dwaya/controllers/user/liste_controller.dart';
import 'package:Dwaya/controllers/user/produit_controller.dart';
import 'package:random_color/random_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RecompenseScreen extends StatefulWidget {
  RecompenseScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _RecompenseScreenState createState() => _RecompenseScreenState();
}

class _RecompenseScreenState extends State<RecompenseScreen> {
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


  Widget build(BuildContext context) {
    return Container(
      color : mainColor,
      height: Get.height,
      width:Get.width,
      child: Center(
        child:    Column(
          children: [
            CircularProgressIndicator()
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
