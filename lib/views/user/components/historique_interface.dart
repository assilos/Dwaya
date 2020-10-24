import 'dart:async';

import 'package:Dwaya/controllers/user/historique_controller.dart';
import 'package:Dwaya/main.dart';
import 'package:Dwaya/models/user/historique.dart';
import 'package:Dwaya/views/user/layouts/main/list_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:Dwaya/views/user/layouts/main/main_interface.dart';
class HistoriqueListe extends StatefulWidget {
  HistoriqueListe({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HistoriqueListeState createState() => _HistoriqueListeState();
}

class _HistoriqueListeState extends State<HistoriqueListe> {
  Color mainColor = Color.fromRGBO(236, 236, 236, 1.0);
  Color secondColor = Color.fromRGBO(19, 117, 71, 1.0);
  Color listColor1 = Color.fromRGBO(27, 32, 41, 1.0);
  Color listColor2 = Color.fromRGBO(238, 191, 54, 1.0);
  TextEditingController nomController = TextEditingController();
  HistoriqueController ctrl = HistoriqueController();
  @override
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return (Scaffold(
      resizeToAvoidBottomPadding: false,

      backgroundColor: mainColor,
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
            color: secondColor,),
            color: secondColor,
            onPressed: ()=>Get.back(),
          ),
          title: Text('Historique',
            style: TextStyle(
                color: secondColor
            ),
          ),
          backgroundColor: mainColor,
      ),
      body: FutureBuilder(
        future: ctrl.HistoriquebyClient(),
        builder: (context,snapshot)
        {
          if (snapshot.hasData)
            {
              List<Historique> l = snapshot.data ;
              return
                Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: l.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:  BorderRadius.circular(23.0),
                        ),
                        child: ExpansionTile(
                          title: Text(l[index].tva,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                          children: [
                            Container(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: l[index].produits.length,
                                itemBuilder: (context, index2) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:  BorderRadius.circular(23.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              (l[index].produits)[index2],
                                              maxLines: 1,
                                              style: TextStyle(color: Colors.black,fontSize: 17),
                                            ),
                                          ],
                                        )
                                      ],

                                    ),
                                  );
                                },
                              ),
                              height: Get.height*0.40,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0,20.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(Get.width*0.1, 0.0, 0.0, 0.0),
                                    child: Text('Total :',style:TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(Get.width*0.5, 0.0, 0.0, 0.0),
                                    child: Text(l[index].montantfinal,style: TextStyle(
                                        fontSize: 18,
                                        color: secondColor
                                    )),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  height: Get.height*0.60,

                );
            }
          else{
            return CircularProgressIndicator();
          }

        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: mainColor,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(110.0,10.0,0.0,10.0),
            )

          ],

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

}


