import 'package:dweya/controllers/user/produit_controller.dart';
import 'package:dweya/main.dart';
import 'package:dweya/views/user/layouts/register/registertwo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
// import model
import 'package:dweya/models/user/user_model.dart';
// import controller
import 'package:dweya/controllers/user/user_controller.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:get/get.dart';

class Shopping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color mainColor = Color.fromRGBO(213, 240, 227,1.0);
    Color secondColor = Color.fromRGBO(19,117,71,1.0);
    return ChangeNotifierProvider<UserModel>(
      create: (context) => UserModel.instance(),
      child: Consumer<UserModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
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
                    Container(
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
                    SizedBox(
                      width: Get.width*0.05,
                    ),
                    IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () {
                        //   _select(choices[1]);
                      },
                      color: secondColor,
                    )
                  ],
                ),
                centerTitle: true,
              ),
            ),
              resizeToAvoidBottomPadding: true,
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body:DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0.0,
                    toolbarHeight: Get.height*0.06,
                    backgroundColor: mainColor,
                    bottom: TabBar(
                      labelColor: secondColor,
                      indicatorColor: secondColor,
                      unselectedLabelColor: Colors.white,
                      tabs: [
                        Tab(text: 'Offres'),
                        Tab(text: 'Demandes'),
                      ],
                    ),
                  ),
                  body: TabBarView(

                    children: [
                      MyCustomForm(),
                      MyCustomForm2(),
                    ],
                  ),
                ),
              )          );//TODO Add layout or component here
        },
      ),
    );
  }
}
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  TextEditingController nomController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController quantController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  UserController viewController = UserController();
  ProduitController ctrl = ProduitController();
  File file;
  bool mail = false ;
  bool pwd = false ;

  Future<File> _choose(String nomm) async {
    var image  = await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: Get.height*0.05,maxWidth: Get.width*0.7);
    setState(() {
      file = image;
      file.rename(nomm);
    });

 //file = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor =  Color.fromRGBO(211, 232, 213,1.0);
    Color secondColor = Color.fromRGBO(19,117,71,1.0);
    String _civilite;
    String _unite;
    String _lieu;
    final format = DateFormat("yyyy-MM-dd");
    // Build a Form widget using the _formKey created above.
    return
      Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              height: Get.height,
              width: MediaQuery.of(context).size.width*(0.90),
              child:Flex(
                direction: Axis.vertical,
                children: [
                  SingleChildScrollView(
                    child: Column(
                        children: <Widget>[
                          Divider(
                            height: MediaQuery.of(context).size.height/15,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 300,
                                maxWidth: 300,
                              ),
                              child :
                              TextFormField(
                                controller: nomController,
                                cursorColor:  secondColor,
                                decoration: InputDecoration(
                                  fillColor: mainColor,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: mainColor,
                                    ),
                                    borderRadius: BorderRadius.circular(33.0),
                                  ),
                                  hasFloatingPlaceholder: true,
                                  prefixIcon: Icon(Icons.person,
                                      color: secondColor),
                                  alignLabelWithHint: true,
                                  hintText: "Nom medicament",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    color: secondColor,
                                  ),
                                  //    labelText: 'Mail',
                                  //  labelStyle: TextStyle(color: secondColor
                                  //  ,fontSize: 20),
                                ),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Veuillez verifier votre nom';
                                  }
                                  return null;
                                },
                              )
                          )
                          ,
                          Divider(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height/35,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 300,
                                maxWidth: 300,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: descController,
                                cursorColor:  secondColor,
                                obscureText: true,
                                decoration: InputDecoration(
                                  fillColor: mainColor,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: mainColor,
                                    ),
                                    borderRadius: BorderRadius.circular(33.0),
                                  ),
                                  prefixIcon: Icon(Icons.person,
                                      color: secondColor),
                                  alignLabelWithHint: true,
                                  hintText: "Raison de l'offre",
                                  hintStyle: TextStyle(
                                    color: secondColor,
                                  ),
                                  //    labelText: 'Mail',
                                  //  labelStyle: TextStyle(color: secondColor
                                  //  ,fontSize: 20),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Veuillez insérer votre prénom';
                                  }
                                  return null;
                                },
                              )
                          ),
                          Divider(
                            color: Colors.white,
                            height: Get.height/25,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 300,
                              maxWidth: 300,
                            ),
                            child:DropDownFormField(
                              filled: true,

                              titleText: 'Unité',
                              hintText: 'Veuillez choisir une unité',
                              value: _unite,
                              onSaved: (value) {
                                setState(() {
                                  _civilite = value;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  _civilite = value;
                                });
                              },
                              dataSource: [
                                {
                                  "display": "Mademoiselle",
                                  "value": "Mademoiselle",
                                },
                                {
                                  "display": "Madame",
                                  "value": "Madame",
                                },
                                {
                                  "display": "Monsieur",
                                  "value": "Monsieur",
                                },
                              ],
                              textField: 'display',
                              valueField: 'value',
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height/35,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 300,
                                maxWidth: 300,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: quantController,
                                cursorColor:  secondColor,
                                obscureText: true,
                                decoration: InputDecoration(
                                  fillColor: mainColor,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: mainColor,
                                    ),
                                    borderRadius: BorderRadius.circular(33.0),
                                  ),
                                  prefixIcon: Icon(Icons.person,
                                      color: secondColor),
                                  alignLabelWithHint: true,
                                  hintText: "Quantité",
                                  hintStyle: TextStyle(
                                    color: secondColor,
                                  ),
                                  //    labelText: 'Mail',
                                  //  labelStyle: TextStyle(color: secondColor
                                  //  ,fontSize: 20),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Veuillez préciser la quantité';
                                  }
                                  return null;
                                },
                              )
                          ),
                    Divider(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height/35,
                     )
                          ,
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 300,
                              maxWidth: 300,
                            ),
                            child:DropDownFormField(
                              titleText: 'Lieu',
                              hintText: 'Veuillez choisir votre lieu',
                              value: _lieu,
                              onSaved: (value) {
                                setState(() {
                                  _civilite = value;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  _civilite = value;
                                });
                              },
                              dataSource: [
                                {
                                  "display": "Mademoiselle",
                                  "value": "Mademoiselle",
                                },
                                {
                                  "display": "Madame",
                                  "value": "Madame",
                                },
                                {
                                  "display": "Monsieur",
                                  "value": "Monsieur",
                                },
                              ],
                              textField: 'display',
                              valueField: 'value',
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            height: Get.height/35,
                          ),
                          file == null
                              ? Text('Veuillez choisir une image')
                              : Image.file(file),
                          Divider(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height/15,
                          ),
        Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    RawMaterialButton(

                      fillColor: secondColor,
                      splashColor: mainColor,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "Choisir une image",
                              maxLines: 1,
                              style: TextStyle(color: Colors.white,fontSize: 12),
                            ),
                          ],
                        ),
                      ),

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)
                      ),
                      onPressed: () async {
                        _choose(nomController.text) ;
                        // Validate returns true if the form is valid, otherwise false.

                      },
                    ),
                ],
              ),
             // file == null
               //   ? Text('No Image Selected')
                 // : Image.file(file)
            ],
        ),
                          Divider(
                            color: Colors.white,
                            height: Get.height/30,
                          ),
                          RawMaterialButton(

                            fillColor: secondColor,
                            splashColor: mainColor,
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const <Widget>[
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "Enregistrer votre offre",
                                    maxLines: 1,
                                    style: TextStyle(color: Colors.white,fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                            onPressed: () async {

                              if (_formKey.currentState.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ctrl.Upload(file);
                              await  ctrl.AjouterOffre(nomController.text,nomController.text,_lieu,_unite,23,quantController.text,descController.text);

                            Get.snackbar('Succés ', 'Offre ajouté',colorText: Colors.white,icon: Icon(Icons.check),duration: Duration(seconds: 3),backgroundColor: Colors.green);
                              }
                              // Validate returns true if the form is valid, otherwise false.

                            },
                          )

                          // Add TextFormFields and RaisedButton here.
                        ]
                    ),
                  )
                ],
              ) ,

            ),
          )
      );
  }
}
class MyCustomForm2 extends StatefulWidget {
  @override
  MyCustomForm2State createState() {
    return MyCustomForm2State();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomForm2State extends State<MyCustomForm2> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  TextEditingController nomController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController quantController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  UserController viewController = UserController();
  ProduitController ctrl = ProduitController();
  File file;
  bool mail = false ;
  bool pwd = false ;

  Future<File> _choose() async {
    var image  = await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: Get.height*0.05,maxWidth: Get.width*0.7);
    setState(() {
      file = image;
    });

    //file = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor =  Color.fromRGBO(211, 232, 213,1.0);
    Color secondColor = Color.fromRGBO(19,117,71,1.0);
    String _lieu;
    String _unite;
    final format = DateFormat("yyyy-MM-dd");
    // Build a Form widget using the _formKey created above.
    return
      Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              height: Get.height*0.95,
              width: MediaQuery.of(context).size.width*(0.90),
              child:Flex(
                direction: Axis.vertical,
                children: [
                  SingleChildScrollView(
                    child: Column(
                        children: <Widget>[
                          Divider(
                            height: MediaQuery.of(context).size.height/15,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 300,
                                maxWidth: 300,
                              ),
                              child :
                              TextFormField(
                                controller: nomController,
                                cursorColor:  secondColor,
                                decoration: InputDecoration(
                                  fillColor: mainColor,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: mainColor,
                                    ),
                                    borderRadius: BorderRadius.circular(33.0),
                                  ),
                                  hasFloatingPlaceholder: true,
                                  prefixIcon: Icon(Icons.person,
                                      color: secondColor),
                                  alignLabelWithHint: true,
                                  hintText: "Nom medicament",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    color: secondColor,
                                  ),
                                  //    labelText: 'Mail',
                                  //  labelStyle: TextStyle(color: secondColor
                                  //  ,fontSize: 20),
                                ),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Veuillez insérer le nom du médicament';
                                  }
                                  return null;
                                },
                              )
                          )
                          ,
                          Divider(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height/35,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 300,
                                maxWidth: 300,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: descController,
                                cursorColor:  secondColor,
                                obscureText: true,
                                decoration: InputDecoration(
                                  fillColor: mainColor,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: mainColor,
                                    ),
                                    borderRadius: BorderRadius.circular(33.0),
                                  ),
                                  prefixIcon: Icon(Icons.person,
                                      color: secondColor),
                                  alignLabelWithHint: true,
                                  hintText: "Raison de la demande",
                                  hintStyle: TextStyle(
                                    color: secondColor,
                                  ),
                                  //    labelText: 'Mail',
                                  //  labelStyle: TextStyle(color: secondColor
                                  //  ,fontSize: 20),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Veuillez insérer la raisond e votre demande';
                                  }
                                  return null;
                                },
                              )
                          ),
                          Divider(
                            color: Colors.white,
                            height: Get.height/25,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 300,
                              maxWidth: 300,
                            ),
                            child:DropDownFormField(
                              titleText: 'Unité',
                              hintText: 'Veuillez choisir une unité',
                              value: _unite,
                              onSaved: (value) {
                                setState(() {
                                  _unite = value;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  _unite = value;
                                });
                              },
                              dataSource: [
                                {
                                  "display": "tabelettes",
                                  "value": "tabelettes",
                                },
                                {
                                  "display": "Flacons",
                                  "value": "Flacons",
                                },
                                {
                                  "display": "Packets",
                                  "value": "Packets",
                                },
                              ],
                              textField: 'value',
                              valueField: 'value',
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height/35,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 300,
                                maxWidth: 300,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller:quantController,
                                cursorColor:  secondColor,
                                obscureText: true,
                                decoration: InputDecoration(
                                  fillColor: mainColor,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: mainColor,
                                    ),
                                    borderRadius: BorderRadius.circular(33.0),
                                  ),
                                  prefixIcon: Icon(Icons.person,
                                      color: secondColor),
                                  alignLabelWithHint: true,
                                  hintText: "Quantité",
                                  hintStyle: TextStyle(
                                    color: secondColor,
                                  ),
                                  //    labelText: 'Mail',
                                  //  labelStyle: TextStyle(color: secondColor
                                  //  ,fontSize: 20),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Veuillez préciser la quantité';
                                  }
                                  return null;
                                },
                              )
                          ),
                          Divider(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height/35,
                          )
                          ,
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 300,
                              maxWidth: 300,
                            ),
                            child:DropDownFormField(
                              titleText: 'Lieu',
                              hintText: 'Veuillez choisir votre gouverorat',
                              value: _lieu,
                              onSaved: (value) {
                                setState(() {
                                  _lieu = value;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  _lieu = value;
                                });
                              },
                              dataSource: [
                                {
                                  "display": "Tunis",
                                  "value": "Tunis",
                                },
                                {
                                  "display": "Sousse",
                                  "value": "Sousse",
                                },
                                {
                                  "display": "Beja",
                                  "value": "Beja",
                                },
                                {
                                  "display": "Bizerte",
                                  "value": "Bizerte",
                                },
                                {
                                  "display": "Nabeul",
                                  "value": "Nabeul",
                                },
                                {
                                  "display": "Kef",
                                  "value": "Kef",
                                },
                                {
                                  "display": "Jendouba",
                                  "value": "Jendouba",
                                },
                                {
                                  "display": "Kef",
                                  "value": "Kef",
                                },
                                {
                                  "display": "Monsatir",
                                  "value": "Monsatir",
                                },
                                {
                                  "display": "Sfax",
                                  "value": "Sfax",
                                },
                                {
                                  "display": "Kairouan",
                                  "value": "Kairouan",
                                },
                                {
                                  "display": "Zaghouane",
                                  "value": "Zaghouane",
                                },
                              ],
                              textField: 'value',
                              valueField: 'value',
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            height: Get.height/35,
                          ),
                          file == null
                              ? Text('Veuillz uplader votre ordonnance')
                              : Image.file(file),
                          Divider(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height/10,
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RawMaterialButton(

                                    fillColor: secondColor,
                                    splashColor: mainColor,
                                    child: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const <Widget>[
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            "Choisir une image",
                                            maxLines: 1,
                                            style: TextStyle(color: Colors.white,fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),

                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24)
                                    ),
                                    onPressed: () async {
                                      _choose() ;
                                      // Validate returns true if the form is valid, otherwise false.

                                    },
                                  ),
                                ],
                              ),
                              // file == null
                              //   ? Text('No Image Selected')
                              // : Image.file(file)
                            ],
                          ),
                          Divider(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height/35,
                          ),
                          RawMaterialButton(

                            fillColor: secondColor,
                            splashColor: mainColor,
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const <Widget>[
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "Enregistrer votre demande",
                                    maxLines: 1,
                                    style: TextStyle(color: Colors.white,fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                            onPressed: () async {
                              ctrl.Upload(file);
                              await  ctrl.AjouterDemande(nomController.text,nomController.text,_lieu,_unite,23,quantController.text,descController.text);

                              Get.snackbar('Succés ', 'Demande ajouté',colorText: Colors.white,icon: Icon(Icons.check),duration: Duration(seconds: 3),backgroundColor: Colors.green);
                              // Validate returns true if the form is valid, otherwise false.

                            },
                          )

                          // Add TextFormFields and RaisedButton here.
                        ]
                    ),
                  )
                ],
              ) ,

            ),
          )
      );
  }
}
