import 'dart:async';

import 'package:Dwaya/controllers/user/produit_controller.dart';
import 'package:Dwaya/main.dart';
import 'package:Dwaya/models/user/produit.dart';
import 'package:Dwaya/views/user/layouts/main/autres_demande.dart';
import 'package:Dwaya/views/user/layouts/main/list_tab.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:Dwaya/views/user/layouts/main/main_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DetailsDemande extends StatefulWidget {
  DetailsDemande({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _DetailsDemandeState createState() => _DetailsDemandeState();
}

class _DetailsDemandeState extends State<DetailsDemande> {
  Color mainColor = Color.fromRGBO(236, 236, 236, 1.0);
  Color secondColor = Color.fromRGBO(19, 117, 71, 1.0);
  Color listColor1 = Color.fromRGBO(27, 32, 41, 1.0);
  Color listColor2 = Color.fromRGBO(238, 191, 54, 1.0);
  String img ;
  TextEditingController nomController = TextEditingController();
  ProduitController ctrl = new ProduitController() ;
  @override
  PageController _controller = PageController(
    initialPage: 0,
  );
  int _currentPage = 0;


  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeIn,
      );
    });
  }
  Future<Produit>getProduit()
  async {
    final prefs = await SharedPreferences.getInstance();
    String nomP =  prefs.get('nomP') ;
    String desc =  prefs.get('desc') ;
    String price =  prefs.get('price') ;
    String image =  prefs.get('image') ;
    img = prefs.get('image');
    String category =  prefs.get('category') ;
    String barcode =  prefs.get('barcode') ;
    print("degla");
    print(image);
    Produit p = new Produit(image: image,category: category,codeaBarres:barcode,description: desc,nom: nomP,price: price) ;
    return p ;
  }
  @override
  Widget build(BuildContext context) => FutureBuilder(
    future:  getProduit(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        Produit p = snapshot.data;
        // Build the widget with data.
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: mainColor,
          appBar: AppBar(
              leading: IconButton(
                onPressed: Get.back,
                icon: Icon(Icons.arrow_back),
                color: secondColor,
              ),
              title: Text('Détails',
                style: TextStyle(
                    color: secondColor
                ),
              ),
              backgroundColor: mainColor,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    //   _select(choices[1]);
                  },
                  color: secondColor,
                ),
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    //   _select(choices[1]);
                  },
                  color: secondColor,
                )
              ]
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    children: [
                      ImageOne(),
                      ImageTwo(),
                      ImageThree(),
                    ],
                  ),
                  height: Get.height * 0.30,
                  width:Get.width,
                  padding: EdgeInsets.all(20.0),
                  color: mainColor,
                ),
                Padding(
                  padding:  EdgeInsets.fromLTRB(15.0,10.0,0.0,0.0),
                  child: Row(
                    children: [
                      Text(
                        p.nom,
                        maxLines: 1,
                        style: TextStyle(color: Colors.black,fontSize: 17),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: Get.width*0.14),
                        child: FutureBuilder(
                          future: ctrl.Urgence(p.nom),
                          builder: (context, snapshot){

                            if (snapshot.hasData)
                              {
                                print(snapshot.data);
                                int a = snapshot.data ;

                                return InkWell(child: Text("Il existe "+a.toString()+" demandes de ce medicament",style: TextStyle(color: secondColor)),
                                onTap: ()=> showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20.0)), //this right here
                                        child:AutresDemande(),
                                      );
                                    }),
                                )
                                ;
                              }
                          else if  (snapshot.hasError) {
                            print("ghalet");
                            print(snapshot.error);
                              return Text('SOMETHING WENT WRONG, TAP TO RELOAD');
                            }
                            else {
                              print("eeeeeee");
                              print(snapshot.data);
                             return CircularProgressIndicator();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0,15.0,0.0,0.0),
                  child: Text(
                    p.price,
                    maxLines: 1,
                    style: TextStyle(color: Colors.black,fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0,15.0,0.0,0.0),
                      child: RatingBar(
                        unratedColor: Colors.white,
                        itemSize: Get.width/20,
                        initialRating:4,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: secondColor,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(130.0,15.0,0.0,0.0),
                      child: IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          //   _select(choices[1]);
                        },
                        color: secondColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0,15.0,0.0,0.0),
                      child: IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {
                          //   _select(choices[1]);
                        },
                        color: secondColor,
                      ),
                    )
                  ],
                ),
                Card(
                    child: ExpansionTile(
                      title: Text('Description'
                          ,
                          style: TextStyle(color: Colors.black,fontSize: 18,
                              fontWeight: FontWeight.bold
                          )),
                      children: <Widget>[
                        Text(p.description
                          ,
                          maxLines: 3,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),),
                      ],
                    )
                ),
                Card(
                    child: ExpansionTile(
                      title: Text('Offres Smiliaires'
                          ,
                          style: TextStyle(color: Colors.black,fontSize: 18,
                              fontWeight: FontWeight.bold
                          )),
                      children: <Widget>[
                        ProduitsTwo()
                      ],
                    )
                ),
                Card(
                    child: ExpansionTile(
                      title: Text('Consultés recemments'
                          ,
                          style: TextStyle(color: Colors.black,fontSize: 18,
                              fontWeight: FontWeight.bold
                          )),
                      children: <Widget>[
                        ProduitsThree()
                      ],
                    )
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: mainColor,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(110.0,10.0,0.0,10.0),
                  child: RawMaterialButton(
                    fillColor: secondColor,
                    splashColor: mainColor,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Contact l'offreur",
                            maxLines: 1,
                            style: TextStyle(color: Colors.white,fontSize: 17),
                          ),
                        ],
                      ),
                    ),

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    onPressed: () async {
                      Get.to(ListTab(),arguments: p.nom);
                    },
                  ),
                )

              ],

            ),
          ),
        );
      } else {
        // We can show the loading view until the data comes back.
        return CircularProgressIndicator();
      }
    },
  );
}
class ImageOne extends StatelessWidget {


  Future<String> getImage()
  async {
    final prefs = await SharedPreferences.getInstance();
    String image =  prefs.get('image') ;
    return image;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getImage(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
          {
            String a = snapshot.data;
            return Container(
              color: Colors.white,
              child:   CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: 'http://272109dd5939.ngrok.io/images/'+a,
                height: Get.height*0.1,
                width: Get.width*0.2,
              )
              ,
            );

          }
          else{
            return LinearProgressIndicator();
          }
        }
    );
  }
}

class ImageTwo extends StatelessWidget {



  Future<String> getImage()
  async {
    final prefs = await SharedPreferences.getInstance();
    String image =  prefs.get('image') ;
    return image;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getImage(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
          {
            String a = snapshot.data;
            return Container(
              color: Colors.white,
              child:   CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: 'http://272109dd5939.ngrok.io/images/'+a,
                height: Get.height*0.1,
                width: Get.width*0.2,
              )
              ,
            );

          }
          else{
            return LinearProgressIndicator();
          }
        }
    );
  }
}
class ImageThree extends StatelessWidget {

  Future<String> getImage()
  async {
    final prefs = await SharedPreferences.getInstance();
    String image =  prefs.get('image') ;
    return image;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getImage(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
          {
            String a = snapshot.data;
            return Container(
              color: Colors.white,
              child:   CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: 'http://272109dd5939.ngrok.io/images/'+a,
                height: Get.height*0.1,
                width: Get.width*0.2,
              )
              ,
            );

          }
          else{
            return LinearProgressIndicator();
          }
        }
    );
  }
}
class ProduitsThree extends StatefulWidget {
  @override
  _ProduitsThreeState createState() => _ProduitsThreeState();
}
class _ProduitsThreeState extends State<ProduitsThree> {
  Color mainColor = Color.fromRGBO(236, 236, 236, 1.0);
  Color secondColor = Color.fromRGBO(19, 117, 71, 1.0);
  List<Produit> a = List<Produit>() ;
  ProduitController ctrl = new ProduitController() ;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: ctrl.ProduitsConsulter(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        print(snapshot.data);
        // Build the widget with data.
        List<Produit> data = snapshot.data;
        return Container(
          child: ListView(
            padding: EdgeInsets.all(12.0),
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            scrollDirection:Axis.horizontal,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(1, (index) {
              return Center(
                child: Container(
                  height: Get.height*0.30,
                  width: Get.width*0.47,
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
                      onTap: ()=> showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0)), //this right here
                              child:DetailsDemande(),
                            );
                          }),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Couscous Sanaabel',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                          Image.asset(
                            'assets/images/couscous.png',
                            width: Get.width * 0.30,
                            height: Get.height * 0.13,
                          ),
                          Text(
                            'couscous diari profesionnel',
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
                                '0.850',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: secondColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width: Get.width /15,
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
      } else {
        // We can show the loading view until the data comes back.
        return CircularProgressIndicator();
      }
    },
  );

}