import 'dart:ui';

import 'package:dweya/controllers/user/liste_controller.dart';
import 'package:dweya/controllers/user/produit_controller.dart';
import 'package:dweya/models/user/liste.dart';
import 'package:dweya/models/user/produit.dart';
import 'package:random_color/random_color.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ListTab extends StatefulWidget {
  ListTab({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ListTabState createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Color mainColor = Color.fromRGBO(236, 236, 236, 1.0);
  Color mainColor2 = Color.fromRGBO(236, 236, 236, 5.0);
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
  List<String> items = ["lait", "yaourt", "Creme Fraiche","Harissa","chocoline","chorba","Couscous Sanabel","chocolat lidnt","chocolat ferrero"];
  List<String> filtredItems = ["lait", "yaourt", "Creme Fraiche","Harissa","chocoline","chorba","Couscous Sanabel","chocolat lidnt","chocolat ferrero"];
  TextEditingController searchController = new TextEditingController();
  bool showSearch = false ;
  bool showText = true;
String idListe ;
bool trash = false ;
  bool isSearching = false;
  Future<void> scheduleNotification() async {
    var scheduledNotificationDateTime =
    DateTime.now().add(Duration(seconds: 5));
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
        'Réduction',
        'Réduction de 20 % sur les produits laitiers',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }
  Future _showNotificationWithSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'id', 'channel', 'description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Réduction',
      'Réduction de 20 % sur les produits laitiers',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }
  @override
  void initState() {
    scheduleNotification();
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      trash=!trash ;
    });

  }
  void _incrementCounter2() {
    print("haw wfeee");
  }

  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Divider(
                height: Get.height*0.08,
              ),
              showSearch ?   Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      width: 200,
                      child: TextFormField(
                        onChanged: searchPressed,
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: isSearching
                              ? IconButton(
                            padding: EdgeInsets.all(0),
                            enableFeedback: true,
                            icon: Icon(Icons.close),
                            onPressed: () {
                              searchController.clear();
                              setState(() {
                                isSearching = false;
                              });
                            },
                          )
                              : IconButton(
                            icon: Icon(Icons.search),
                            padding: EdgeInsets.all(0),
                            onPressed: () {},
                          ),
                          border: InputBorder.none,
                        ),
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
              ): SizedBox(
                width: Get.width*0.05,
              ),
            ],
          ),
          centerTitle: true,
        ),
      ),
      resizeToAvoidBottomPadding: false,
      backgroundColor: mainColor,
      body: isSearching
          ? Container(
        child: search(),
      )
          :SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: ctrl.AfficherListe(),
              builder:  (context, snapshot) {
             if (snapshot.hasData)
               {
                 List<Liste> data = snapshot.data;

                return           SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: mainColor,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return LongPressDraggable<String>(
                              data: 'Flutter',
                              onDragStarted:_incrementCounter,
                              onDragCompleted: _incrementCounter2,
                              onDraggableCanceled :(velocity,offset){
                                  _incrementCounter();
                                },
                                feedback: Material(
                                  shadowColor: secondColor,
                                elevation: 10.0,
                                child: SimpleFoldingCell.create(
                                  frontWidget: _buildFrontWidget(data[index].nom,data[index].iId),
                                  innerWidget: _buildInnerWidget(data[index].iId),
                                  cellSize: Size(Get.width*0.80, Get.height*0.15),
                                  padding: EdgeInsets.all(1.0),
                                  animationDuration: Duration(milliseconds: 300),
                                  borderRadius: 20,
                                  onOpen: () => print('$index cell opened'),
                                  onClose: () => print('$index cell closed'),
                                ),
                              ),
                              childWhenDragging: SimpleFoldingCell.create(
                                frontWidget: Container(color: mainColor2),
                                innerWidget: _buildInnerWidget(data[index].iId),
                                cellSize: Size(Get.width*0.80, Get.height*0.15),
                                padding: EdgeInsets.all(15),
                                animationDuration: Duration(milliseconds: 300),
                                borderRadius: 20,
                                onOpen: () => print('$index cell opened'),
                                onClose: () => print('$index cell closed'),
                              ),
                              child: SimpleFoldingCell.create(
                                frontWidget: _buildFrontWidget(data[index].nom,data[index].iId),
                                innerWidget: _buildInnerWidget(data[index].iId),
                                cellSize: Size(Get.width*0.80, Get.height*0.15),
                                padding: EdgeInsets.all(15),
                                animationDuration: Duration(milliseconds: 300),
                                borderRadius: 20,
                                onOpen: () => print('$index cell opened'),
                                onClose: () => print('$index cell closed'),
                              ),
                            );
                          },
                        ),
                        height: Get.height * 0.3,
                      ),
                      Column(
                        children: [
                          Container(
                            color: mainColor,
                            child: AnimatedSwitcher(
                              duration: const Duration(seconds: 1),

                              child: showText ? _texte() : _contenuListe(idListe),
                            ),
                            height: Get.height * 0.38 ,
                          ),
                          Padding(
                            padding:  EdgeInsets.fromLTRB(0.0,50.0,0.0,2.0),
                            child: RawMaterialButton(
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20.0)),
                                        //this right here
                                        child: Container(
                                          height: 200,
                                          child: Padding(
                                            padding: EdgeInsets.all(12.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                TextField(
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: 'Nommez votre liste'),
                                                  controller: passwordController,
                                                ),
                                                Divider(
                                                  height: Get.height * 0.01,
                                                ),
                                                SizedBox(
                                                  width: 320.0,
                                                  child: RawMaterialButton(
                                                    fillColor: secondColor,
                                                    splashColor: mainColor,
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          8.0),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize
                                                            .min,
                                                        children: const <Widget>[
                                                          SizedBox(
                                                            width: 10.0,
                                                          ),
                                                          Text(
                                                            "Enregistrer",
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(24)
                                                    ),
                                                    onPressed: () async {
                                                      if (!passwordController
                                                          .isNull) {
                                                        ctrl.AjouterListe(
                                                            passwordController
                                                                .text);
                                                        await Get.back();
                                                        Get.snackbar('Succés',
                                                            'Liste crée avec succés');
                                                      }
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              fillColor: secondColor,
                              splashColor: mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius:  BorderRadius.circular(23.0),
                              ),
                              child: Padding(
                                padding:  EdgeInsets.fromLTRB(100,20,100,20),
                                child: Text("Nouvelle liste",style: TextStyle(
                                  color: Colors.white
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                );
               }
                else {
                  return CircularProgressIndicator() ;
             }
              }
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: Get.width*0.4,
                  ),
                DragTarget<String>(builder: (context, List<String> candidateData, rejectedData) {
                  return  Visibility(
                    child: Container(
                      decoration: BoxDecoration(
                        color: mainColor2,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: secondColor,
                            spreadRadius: 5.0,
                            blurRadius: 1.0

                          ),
                        ]
                    ),
                      child: Icon(Icons.delete,
                        color: secondColor,
                        size: Get.height*0.05,
                      ),
                      height: Get.height*0.1,
                    ),
                    visible: trash,
                  );
                },
                  onAccept:(String data) {
                  print('bbbb') ;
                    setState(() {
                     print("accept") ;
                    });

                  },
                  onWillAccept: (String data) {
                  if (data=='Flutter')
                    {
                      return true;
                    }
                  return false ;

                  },
                )

,
                  SizedBox(
                    width: Get.width*0.3,
                  ),
                ],
              ),
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.fromLTRB(0.0,0.0,Get.width*0.01,0.0),
              height: Get.height*0.20,
              width: Get.width*0.95,
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

  Widget search() {
    getItems();
    if (searchController.text.isNotEmpty) {
      List<String> temp = new List<String>();
      for (int i = 0; i < filtredItems.length; i++) {
        if (filtredItems[i].toLowerCase().contains(
          searchController.text.toLowerCase(),
        )) {
          temp.add(filtredItems[i]);
        }
      }
      filtredItems = temp;
    }
    return ListView.builder(
      itemCount: filtredItems.length,
      itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.search),
          title: Text(
            filtredItems[index],
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            searchController.clear();
            FocusScope.of(context).unfocus();
            setState(() {
              isSearching = false;
            });
            Get.snackbar('Succés ', 'Produit Ajouté',colorText: Colors.white,icon: Icon(Icons.shopping_cart),duration: Duration(seconds: 5),backgroundColor: Colors.green);
            print("caca"+filtredItems[index]);
          ctrl2.AjouterProduitListe(filtredItems[index],'5f846db96c6b1e57a3c2e6b7');
          }),
    );
  }

  void searchPressed(String text) {
    setState(() {
      if (text.isNotEmpty) {
        isSearching = true;
      } else
        isSearching = false;
    });
  }

  void getItems() {
    setState(() {
      filtredItems = items;
    });
  }
Widget _texte()
{
  return Text("Vos produits",
  key: UniqueKey(),);
}
  Widget
  _contenuListe(String id)
  {
    print('ID :'+id);
    return FutureBuilder(
      key: UniqueKey(),
      future:  ctrl2.ProduitbyListe(id),
      builder: (context,snapshot){
        if (snapshot.hasData)
          {
            print('fih data');
            List<Produit> data = snapshot.data;
            return Column(
              children: [
                Padding(
                  padding:  EdgeInsets.fromLTRB(15.0,0.0,0.0,0.0),
                  child: Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.fromLTRB(320.0,0.0,0.0,0.0),
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton(
                              backgroundColor: secondColor,
                              splashColor: mainColor,
                              child: Icon(Icons.add),
                            onPressed: () async {
                              setState(() {
                           showSearch = true ;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                  Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: data.length,
                    itemBuilder: (context, index2) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:  BorderRadius.circular(23.0),
                        ),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text('  '+
                                  data[index2].nom,
                                  maxLines: 1,
                                  style: TextStyle(color: Colors.black,fontSize: 20),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  height: Get.height*0.3,
                ),
              ],
            );
          }
        else {
          print('ma fihouch data');
          return CircularProgressIndicator();
        }
      },
    );
  }
  Widget _buildFrontWidget(String nom,String id) {
    return Builder(
      builder: (BuildContext context) {
        return InkWell(
          onTap: () async => {
            if (Get.arguments != "Details")
              {
            ctrl2.AjouterProduitListe(Get.arguments,id).then((value) => Get.snackbar('Succés ', 'Produit Ajouté',colorText: Colors.white,icon: Icon(Icons.shopping_cart),duration: Duration(seconds: 3),backgroundColor: Colors.green))
              }

          },
          child: Container(
            color: secondColor,
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    nom,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  left: Get.width*0.63,
                  child: FlatButton(
                    onPressed: () async {
                 setState(() {
                   showText = !showText;
                   idListe = id ;
                    });
                    },
                    child: AnimatedSwitcher(
                      duration: Duration(seconds: 1),
                      child: showText ?  Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ) :  Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.white,
                      ),
                    ),
                    textColor: Colors.white,
                    color: secondColor,
                    splashColor: Colors.white.withOpacity(0.5),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInnerWidget(String id) {
    return Text('ddddddddddddddd');
  }

  Widget _buildVerticalLanguageList( List<String> items) {
    final theme = Theme.of(context);
    const listPadding = EdgeInsets.symmetric(horizontal: 0);

    Widget buildReorderable(
      String lang,
      Widget Function(Widget tile) transitionBuilder,
    ) {
      return Reorderable(
        key: ValueKey(lang),
        builder: (context, dragAnimation, inDrag) {
          final t = dragAnimation.value;
          final tile = _buildTile(t, lang,items);

          // If the item is in drag, only return the tile as the
          // SizeFadeTransition would clip the shadow.
          if (t > 0.0) {
            return tile;
          }

          return transitionBuilder(
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                tile,
                const Divider(height: 0),
              ],
            ),
          );
        },
      );
    }

    return ImplicitlyAnimatedReorderableList<String>(
      items: items,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: listPadding,
      areItemsTheSame: (oldItem, newItem) => oldItem == newItem,
      onReorderStarted: (item, index) => setState(() => inReorder = true),
      onReorderFinished: (movedLanguage, from, to, newItems) {
        // Update the underlying data when the item has been reordered!
        onReorderFinished(newItems,items);
      },
      itemBuilder: (context, itemAnimation, lang, index) {
        return buildReorderable(lang, (tile) {
          return SizeFadeTransition(
            sizeFraction: 0.7,
            curve: Curves.easeInOut,
            animation: itemAnimation,
            child: tile,
          );
        });
      },
      updateItemBuilder: (context, itemAnimation, lang) {
        return buildReorderable(lang, (tile) {
          return FadeTransition(
            opacity: itemAnimation,
            child: tile,
          );
        });
      },
    );
  }

  Widget _buildTile(double t, String lang,List<String> items) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final color = Color.lerp(Colors.white, Colors.grey.shade100, t);
    final elevation = lerpDouble(0, 8, t);

    final List<Widget> actions = items.length > 1
        ? [
            SlideAction(
              closeOnTap: true,
              color: secondColor,
              onTap: () {
                setState(
                  () => items.remove(lang),
                );
              },
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Supprimer',
                      style: textTheme.bodyText2.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]
        : [];

    return Slidable(
      actionPane: const SlidableBehindActionPane(),
      actions: actions,
      secondaryActions: actions,
      child: SizedBox(
        child: ListTile(
          title: Text(
            lang,
            style: textTheme.bodyText2.copyWith(
              fontSize: 16,
            ),
          ),
          leading: SizedBox(
            width: 36,
            height: 36,
            child: Center(
              child: Text(
                '${items.indexOf(lang) + 1}',
                style: textTheme.bodyText2.copyWith(
                  color: theme.accentColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onReorderFinished(List<String> newItems,List<String> items) {
    scrollController.jumpTo(scrollController.offset);
    setState(() {
      inReorder = false;

      items
        ..clear()
        ..addAll(newItems);
    });
  }
}
