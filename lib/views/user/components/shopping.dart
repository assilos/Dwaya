

import 'package:Dwaya/controllers/user/produit_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
// import model
import 'package:Dwaya/models/user/user_model.dart';
// import controller
import 'package:Dwaya/controllers/user/user_controller.dart';
import 'package:path/path.dart' as path;

import 'package:get/get.dart';
import 'package:tesseract_ocr/tesseract_ocr.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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
  String _lieu;
  final format = DateFormat("yyyy-MM-dd");
  bool _load  ;
  @override
  Future<void> initState() {
    _load = false ;



  }
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
  List<String> users = <String>[
   'tabelettes',
   'pillules',
    'flacon',
  ];
  String selectedUser;
  List<String> users2 = <String>[
    'Sfax',
    'Tunisia',
    'Sousse',
    'Beja',
  ];
  String selectedUser2;
  String _extractText = 'Unknown';
  Color mainColor =  Color.fromRGBO(211, 232, 213,1.0);
  Color secondColor = Color.fromRGBO(19,117,71,1.0);
  String _civilite;
  String _unite;



  Future<File> _choose(String nomm) async {
    var image  = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      file = image;

    });



    //file = await ImagePicker.pickImage(source: ImageSource.gallery);
  }
  Future<void> initPlatformState() async {
    String extractText;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      print("haw text");
      String text = await TesseractOcr.extractText(file.path,language:'eng');
      print("haw text");
      print(text);
    } on PlatformException {
      extractText = 'Failed to extract text';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

  }

  @override
  Widget build(BuildContext context) {


    // Build a Form widget using the _formKey created above.
    return
      ModalProgressHUD(
        color: secondColor,
        inAsyncCall: _load,
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                height: Get.height,
                width: MediaQuery.of(context).size.width,
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
                            Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 300,
                                  maxWidth: 300,
                                ),
                                child:DropdownButton<String>(

                                  icon: Icon(Icons.healing),
                                  iconEnabledColor: secondColor,
                                  dropdownColor: secondColor,
                                  isExpanded: true,
                                  isDense: true,
                                  hint:  Text("Unité",style: TextStyle(color: secondColor)),
                                  value: selectedUser,
                                  onChanged: (String Value) {
                                    setState(() {
                                      selectedUser = Value;
                                    });
                                  },
                                  items: users.map((String user) {
                                    return  DropdownMenuItem<String>(
                                      value: user,
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            user,
                                            style:  TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
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
                            Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 300,
                                  maxWidth: 300,
                                ),
                                child:DropdownButton<String>(
                                  icon: Icon(Icons.location_on),
                                  iconEnabledColor: secondColor,
                                  dropdownColor: secondColor,
                                  isExpanded: true,
                                  isDense: true,
                                  hint:  Text("Lieu",style: TextStyle(color: secondColor)),
                                  value: selectedUser2,
                                  onChanged: (String Value) {
                                    setState(() {
                                      selectedUser2 = Value;
                                    });
                                  },
                                  items: users2.map((String user) {
                                    return  DropdownMenuItem<String>(
                                      value: user,
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            user,
                                            style:  TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                              height: Get.height/35,
                            ),
                            file == null
                                ? Text('Veuillez choisir une image')
                                : Image.file(file,height: Get.height*0.05,width: Get.width*0.3,),
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

                                  setState(() {
                                    _load = true;

                                  });
                                  Get.snackbar('Merci !', 'Veuillez Patientez',colorText: Colors.white,icon: Icon(Icons.check),duration: Duration(seconds: 3),backgroundColor: Colors.green);
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                 await ctrl.Upload(file,nomController.text+'23');


                                  await  ctrl.AjouterOffre(nomController.text,nomController.text+'23.jpg',selectedUser2,selectedUser,23,quantController.text,descController.text);

                                  setState(() {
                                    _load = false;

                                  });
                                 Get.snackbar('Succés ', 'Votre offre a été ajouté',colorText: Colors.white,icon: Icon(Icons.check),duration: Duration(seconds: 3),backgroundColor: Colors.green,);
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
        ),
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
  Color mainColor =  Color.fromRGBO(211, 232, 213,1.0);
  Color secondColor = Color.fromRGBO(19,117,71,1.0);
  String _lieu;
  String _unite;
  final format = DateFormat("yyyy-MM-dd");
  File file;
  bool mail = false ;
  bool pwd = false ;
  List<String> users = <String>[
    'tabelettes',
    'pillules',
    'flacon',
  ];
  String selectedUser;
  List<String> users2 = <String>[
    'Sfax',
    'Tunisia',
    'Sousse',
    'Beja',
  ];
  String selectedUser2;
  bool _load ;
  Future<void> initState() {
    _load = false ;



  }
  Future<File> _choose() async {
    var image  = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = image;
    });

    //file = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {

    // Build a Form widget using the _formKey created above.
    return
      ModalProgressHUD(
        inAsyncCall: _load,
        color: secondColor,
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                height: Get.height*0.95,
                width: MediaQuery.of(context).size.width,
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
                                      return 'Veuillez insérer la raison de votre demande';
                                    }
                                    return null;
                                  },
                                )
                            ),
                            Divider(
                              color: Colors.white,
                              height: Get.height/25,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 300,
                                  maxWidth: 300,
                                ),
                                child:DropdownButton<String>(
                                  icon: Icon(Icons.healing),
                                  iconEnabledColor: secondColor,
                                  dropdownColor: secondColor,
                                  isExpanded: true,
                                  isDense: true,
                                  hint:  Text("Unité",style: TextStyle(color: secondColor)),
                                  value: selectedUser,
                                  onChanged: (String Value) {
                                    setState(() {
                                      selectedUser = Value;
                                    });
                                  },
                                  items: users.map((String user) {
                                    return  DropdownMenuItem<String>(
                                      value: user,
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            user,
                                            style:  TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
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
                            Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 300,
                                  maxWidth: 300,
                                ),
                                child:DropdownButton<String>(
                                  icon: Icon(Icons.location_on),
                                  iconEnabledColor: secondColor,
                                  dropdownColor: secondColor,
                                  isExpanded: true,
                                  isDense: true,
                                  hint:  Text("Lieu",style: TextStyle(color: secondColor)),
                                  value: selectedUser2,
                                  onChanged: (String Value) {
                                    setState(() {
                                      selectedUser2 = Value;
                                    });
                                  },
                                  items: users2.map((String user) {
                                    return  DropdownMenuItem<String>(
                                      value: user,
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            user,
                                            style:  TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                              height: Get.height/35,
                            ),
                            file == null
                                ? Text('Veuillz uploader votre ordonnance')
                                : Image.file(file,height: Get.height*0.05,width: Get.width*0.3),
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
                                if (_formKey.currentState.validate()) {

                                  setState(() {
                                    _load = true;

                                  });
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  Get.snackbar('Merci ! ', 'Veuillez patientez',isDismissible: true,duration: Duration(seconds: 3));

                                  await ctrl.Upload(file,nomController.text+'23');
                                  print("haw kmel");
                                  await   ctrl.VerifyOCR(nomController.text+'23'+'.jpg')? await  ctrl.AjouterDemande(nomController.text,nomController.text+'23.jpg',selectedUser2,selectedUser,23,quantController.text,descController.text).then((value) => Get.snackbar('Succés ', 'Offre ajouté',colorText: Colors.white,icon: Icon(Icons.check),duration: Duration(seconds: 15),backgroundColor: Colors.green)
                                  ): Get.snackbar('Désolé ', 'Veuillez vérifier votre ordonnance',colorText: Colors.white,icon: Icon(Icons.check),duration: Duration(seconds: 15),backgroundColor: Colors.green,snackPosition:SnackPosition.BOTTOM );
                                  setState(() {
                                    _load = false;

                                  });

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
        ),
      );
  }
}
