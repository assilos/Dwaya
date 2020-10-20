import 'package:dweya/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import model
import 'package:dweya/models/user/user_model.dart';
// import controller
import 'package:dweya/controllers/user/user_controller.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'dart:convert';

import 'package:get/get.dart';

class RegisterFourView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Get.put(RegisterFourView()) ;
    return ChangeNotifierProvider<UserModel>(
      create: (context) => UserModel.instance(),
      child: Consumer<UserModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
              resizeToAvoidBottomPadding: true,
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body:SingleChildScrollView(
                child:  Column(
                  children: [
                    Divider(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height/11,
                    ),
                    Image.asset('assets/images/logo.png',
                      width: MediaQuery.of(context).size.width*0.75,
                      height: MediaQuery.of(context).size.width*0.2,
                    ),
                    MyCustomForm(),
                  ],
                ),
              )
          );//TODO Add layout or component here
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
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  UserController viewController = UserController();
  String  _selectedItem ;
  List<DropdownMenuItem<int>> _menuItems;
  int _value = 1;
  Color mainColor = Color.fromRGBO(213, 240, 227,1.0);
  Color secondColor = Color.fromRGBO(19,117,71,1.0);
  Map yourJson = {
    "status": true,
    "message": "success",
    "data": {
      "list": [
        {"idattribute": "1", "gouv": "Ariana"},
        {"idattribute": "2", "gouv": "Beja "},
        {"idattribute": "3", "gouv": "Ben Arous"},
        {"idattribute": "4", "gouv": "Bizerte"},
        {"idattribute": "5", "gouv": "Gabes"},
        {"idattribute": "6", "gouv": "Gafsa"},
        {"idattribute": "7", "gouv": "Jendouba"},
        {"idattribute": "8", "gouv": "Kairouan"},
        {"idattribute": "9", "gouv": "Kasserine"},
        {"idattribute": "10", "gouv": "Kebili"},
        {"idattribute": "11", "gouv": "Kef"},
        {"idattribute": "12", "gouv": "Mahdia"},
        {"idattribute": "13", "gouv": "Mannouba"},
        {"idattribute": "14", "gouv": "Monastir"},
        {"idattribute": "15", "gouv": "Nabeul"},
        {"idattribute": "16", "gouv": "Sfax"},
        {"idattribute": "17", "gouv": "Sousse"},
        {"idattribute": "18", "gouv": "Siliana"},
        {"idattribute": "19", "gouv": "Sidi Bouzid"},
        {"idattribute": "20", "gouv": "Tataouine"},
        {"idattribute": "21", "gouv": "Tozeur"},
        {"idattribute": "22", "gouv": "Tunis"},
        {"idattribute": "23", "gouv": "Zaghouene"},
      ]
    }
  };
  @override
  void initState() {
    super.initState();

    List dataList = yourJson["data"]["list"];

    _menuItems = List.generate(
      dataList.length,
          (i) => DropdownMenuItem(
        value: int.parse(dataList[i]["idattribute"]),
        child: Text("${dataList[i]["gouv"]}"),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    String _civilite;
    final format = DateFormat("yyyy-MM-dd");
  bool  _valueCheck = false ;
    // Build a Form widget using the _formKey created above.
    return
      Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height*(3/4),
            width: MediaQuery.of(context).size.width*(0.90),
            child:Flex(
              direction: Axis.vertical,
         children: [
           Column(
               children: <Widget>[
                 Divider(
                   color: Colors.white,
                   height: MediaQuery.of(context).size.height/21,
                 ),
                 ConstrainedBox(
                     constraints: BoxConstraints(
                       minWidth: 300,
                       maxWidth: 300,
                     ),
                     child: TextFormField(
                       maxLength: 8,
                       keyboardType: TextInputType.visiblePassword,
                       controller: passwordController,
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
                         prefixIcon: Icon(Icons.lock,
                             color: secondColor),
                         alignLabelWithHint: true,
                         hintText: "Mot de passe",
                         hintStyle: TextStyle(
                           color: secondColor,
                         ),
                         //    labelText: 'Mail',
                         //  labelStyle: TextStyle(color: secondColor
                         //  ,fontSize: 20),
                       ),
                       validator: (value) {
                         if (value.isEmpty||value.length<4) {
                           return 'Le mot de passe doit contenir au mois 6 caractères';
                         }
                         return null;
                       },
                     )
                 ),
                 Divider(
                   color: Colors.white,
                   height: MediaQuery.of(context).size.height/38,
                 ),
                 ConstrainedBox(
                     constraints: BoxConstraints(
                       minWidth: 300,
                       maxWidth: 300,
                     ),
                     child: TextFormField(
                       maxLength: 8,
                       keyboardType: TextInputType.visiblePassword,
                       controller: confirmpasswordController,
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
                         prefixIcon: Icon(Icons.message,
                             color: secondColor),
                         alignLabelWithHint: true,
                         hintText: "Confirmer mot de passe",
                         hintStyle: TextStyle(
                           color: secondColor,
                         ),
                         //    labelText: 'Mail',
                         //  labelStyle: TextStyle(color: secondColor
                         //  ,fontSize: 20),
                       ),
                       validator: (value) {
                         if (value.isEmpty||value.length<4) {
                           return 'Veuillez verifier le mot de passe';
                         }
                         return null;
                       },
                     )
                 ),
                 StatefulBuilder(
                   builder: (BuildContext context, StateSetter setState) => CheckboxListTile(
                     title: Text("J'accepte les conditions générales d'utilisation ",style: TextStyle(
                       color: secondColor,

                     ),),
                     value: _valueCheck,
                     onChanged: (value) {
                       setState(() {
                         _valueCheck = value;
                       });
                     },
                   ),
                 ),
                 Divider(
                     height: MediaQuery.of(context).size.height/15,
                     color:Colors.white
                 ),
                 Text("Consultez les conditions générales d'utilisation ",style: TextStyle(
                   color: secondColor,
                   fontWeight: FontWeight.bold,
                   decoration: TextDecoration.underline,


                 ),),
                 Divider(
                     height: MediaQuery.of(context).size.height/5,
                     color:Colors.white
                 ),
                 // Add TextFormFields and RaisedButton here.
               ]
           )
         ],
            ) ,

          )
      );
  }
}
