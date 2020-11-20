import 'dart:async';
import 'dart:io';

import 'package:Dwaya/controllers/user/produit_controller.dart';
import 'package:Dwaya/models/user/demande.dart';
import 'package:Dwaya/models/user/offre.dart';
import 'package:Dwaya/models/user/produit.dart';
import 'package:Dwaya/views/user/components/details_demande.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:Dwaya/views/user/components/details_produits.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';





class AutresDemande extends StatefulWidget {
  @override
  _AutresDemandeState createState() => _AutresDemandeState();
}
class _AutresDemandeState extends State<AutresDemande> {
  Color mainColor = Color.fromRGBO(236, 236, 236, 1.0);
  Color secondColor = Color.fromRGBO(19, 117, 71, 1.0);
  List<Produit> a = List<Produit>() ;
  ProduitController ctrl = new ProduitController() ;
  @override
  void initState() {
    super.initState();
  }
  Future<void> toDetails(String nom ,String desc ,String price ,String image,String category,String barcode)
  async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('nomP',nom) ;
    prefs.setString('desc',desc) ;
    prefs.setString('price',price) ;
    prefs.setString('image',image) ;
    prefs.setString('category',category) ;
    prefs.setString('barcode',barcode) ;


    Get.to(DetailsDemande(),transition: Transition.fade);
  }
 bool compareDates(String date)
 {
   print("date jet");
   print(date);
   DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
   DateTime dateTime = dateFormat.parse(date);
  int difference = dateTime.difference(DateTime.now()).inDays;

  // if (difference >10)
     return true ;
   //return false ;

 }
  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: ctrl.Autres("dd"),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        print(snapshot.data);
        // Build the widget with data.
        List<Demande> data = snapshot.data;
        print("fil deglaaa");
        print(data.length) ;
        return Container(
          child: ListView(
            padding: EdgeInsets.all(12.0),
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            scrollDirection:Axis.vertical,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(data.length, (index) {




              return Center(
                child: Container(
                  height: Get.height*0.1,
                  width: Get.width,
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
                      onTap: ()=>toDetails(data[index].nommedicament,data[index].description,data[index].datePublication.substring(0,10),data[index].image,data[index].lieu,data[index].unite),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Divider(height: Get.height*0.03),
                              Text(
                                data[index].nommedicament,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                              Text(
                                data[index].description,
                                style: TextStyle(
                                  fontSize: 11.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: Get.width *0.2,
                              ),
                              Text(
                                data[index].datePublication.substring(0,10),
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: secondColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child:
                                compareDates(data[index].datePublication.substring(0,19))?
                                Text("Urgent",style: TextStyle(color: Colors.red),):Text("Pas urgent",style: TextStyle(color: Colors.green),),
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
          height: Get.height * 0.40,
        );
      } else {
        // We can show the loading view until the data comes back.
        return LinearProgressIndicator();
      }
    },
  );

}
