import 'dart:ui';

import 'package:Dwaya/models/user/produit.dart';
import 'package:Dwaya/views/user/components/historique_interface.dart';
import 'package:Dwaya/views/user/user_view.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:get/route_manager.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatefulWidget {
  Profil({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  Color mainColor = Color.fromRGBO(236, 236, 236, 1.0);
  Color secondColor = Color.fromRGBO(19, 117, 71, 1.0);
  Color listColor1 = Color.fromRGBO(27, 32, 41, 1.0);
  Color listColor2 = Color.fromRGBO(238, 191, 54, 1.0);
  bool inReorder = false;
  ScrollController scrollController;
  TextEditingController passwordController = TextEditingController();
  bool show = false;
  String nom;
  String prenom;
  final List<String> items = [
    "Amira",
    "Ahmed",
    "Marouene",
    "Mahdi",
    "Firas",
    "Ines"
  ];
  Future<String> GetProfil()
  async {
    final prefs = await SharedPreferences.getInstance();

prenom = prefs.get('prenomUser');
return prenom ;
  }
  void Sedeconnecter()
  async {
    final prefs = await SharedPreferences.getInstance();
prefs.clear();
Get.to(UserView());
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Flex(
          direction: Axis.vertical,
          children: [
            AppBar(
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
            )          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
      backgroundColor: mainColor,
      body: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 50, 0.0, 0.0),
                child: Container(
                  height: Get.height * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(
                        50.0) //                 <--- border radius here
                    ),
                  ),
                  child: Container(
                    padding:
                    EdgeInsets.fromLTRB(0.0, Get.height * 0.1, 0.0, 0.0),
                    height: Get.height * 0.8,
                    width: Get.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            'Marouene Khadhraoui',
                            style: TextStyle(fontSize: 22, color: Colors.black),
                          ),
                          Divider(
                            height: Get.height * 0.05,
                            color: Colors.white,
                          ),
                          Card(
                              child: ExpansionTile(
                                initiallyExpanded: true,
                                title: Text('Récemments consultés',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                children: <Widget>[ProduitsTwo()],
                              )),
                          Card(
                              child: ExpansionTile(
                                title: Text('Paramètres',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                children: <Widget>[Parametres()],
                              )),
                          Card(
                              child: GestureDetector(
                                onTap: ()=> Get.to(HistoriqueListe(),transition: Transition.fadeIn),
                                child: Container(
                                  height: Get.height*0.065,
                                  child: Padding(
                                    padding:  EdgeInsets.fromLTRB(Get.height*0.018,0.0,0.0,0.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text('Historique',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        Padding(
                                          padding:  EdgeInsets.fromLTRB(Get.width*0.65,0.0,0.0,0.0),
                                          child: Icon(Icons.keyboard_arrow_right,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                          Card(
                              child: GestureDetector(
                                onTap: () => {
                                  Sedeconnecter()

                                },
                                child: Container(
                                  height: Get.height*0.065,
                                  child: Padding(
                                    padding:  EdgeInsets.fromLTRB(Get.height*0.018,0.0,0.0,0.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text('Se déconnecter',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        Padding(
                                          padding:  EdgeInsets.fromLTRB(Get.width*0.59
                                              ,0.0,0.0,0.0),
                                          child: Icon(Icons.keyboard_arrow_right,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ))


                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: CircleAvatar(
                  child: Text(
                    'M',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                  maxRadius: Get.width * 0.15,
                ),
              ),
            ],
          )
        ],
      ),
    ));

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
  }
}

class ProduitsTwo extends StatefulWidget {
  @override
  _ProduitsTwoState createState() => _ProduitsTwoState();
}

class _ProduitsTwoState extends State<ProduitsTwo> {
  Color mainColor = Color.fromRGBO(236, 236, 236, 1.0);
  Color secondColor = Color.fromRGBO(19, 117, 71, 1.0);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(12.0),
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        scrollDirection: Axis.horizontal,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(1, (index) {
          return Center(
            child: Container(
              height: Get.height * 0.30,
              width: Get.width * 0.47,
              child: Card(
                margin: EdgeInsets.all(3),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: mainColor,
                    )),
                shadowColor: mainColor,
                borderOnForeground: true,
                elevation: 10.0,
                color: mainColor,
                child: InkWell(
                  onTap: () => Get.snackbar("ddd", "rrrrr"),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'clamoxyle',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                      Image.asset(
                        'assets/images/clamoxyle.png',
                        width: Get.width * 0.30,
                        height: Get.height * 0.13,
                      ),
                      Text(
                        'besoin urgent',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width / 6.56,
                          ),
                          Text(
                            '20/10/2020 ',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: secondColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: Get.width / 15,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
      height: Get.height * 0.32,
    );
  }
}

class Parametres extends StatefulWidget {
  @override
  _ParametresState createState() => _ParametresState();
}

class _ParametresState extends State<Parametres> {
  Color mainColor = Color.fromRGBO(236, 236, 236, 1.0);
  Color secondColor = Color.fromRGBO(19, 117, 71, 1.0);
  bool isSwitched = false;
  bool isSwitched2 = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.lightbulb_outline,
              color: secondColor,
              size: 35,
            ),
            SizedBox(
              width: Get.width * 0.2,
            ),
            Text(
              'Dark mode',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: Get.width * 0.34,
            ),
            Switch(
                activeColor: secondColor,
                value: false,
                activeTrackColor: mainColor,
                onChanged: (value) {
                  setState(() {
                    Get.changeTheme(ThemeData.dark());
                    isSwitched = value;
                  });
                })
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.notifications,
              color: secondColor,
              size: 35,
            ),
            SizedBox(
              width: Get.width * 0.2,
            ),
            Text(
              'Notifications',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: Get.width * 0.32,
            ),
            Switch(
              activeColor: secondColor,
              activeTrackColor: mainColor,
              value: isSwitched2,
              onChanged: (value) {
                Get.changeTheme(ThemeData.dark());
                setState(() {
                  isSwitched2 = value;
                });
              },
            )
          ],
        )
      ],
    );
  }
}
