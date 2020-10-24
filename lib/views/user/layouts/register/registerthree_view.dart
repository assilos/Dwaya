import 'package:Dwaya/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import model
import 'package:Dwaya/models/user/user_model.dart';
// import controller
import 'package:Dwaya/controllers/user/user_controller.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'dart:convert';
import 'package:get/get.dart';
class RegisterThreeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color mainColor = Color.fromRGBO(	213, 240, 227,1.0);
    Color secondColor = Color.fromRGBO(19,117,71,1.0);
    Get.put(RegisterThreeView()) ;
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
  TextEditingController telController = TextEditingController();
  UserController viewController = UserController();
  String  _selectedItem ;
  List<DropdownMenuItem<int>> _menuItems;
  int _value = 1;
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
    Color mainColor =  Color.fromRGBO(211, 232, 213,1.0);
    Color secondColor = Color.fromRGBO(19,117,71,1.0);
    String _civilite;
    final format = DateFormat("yyyy-MM-dd");

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
                     height: MediaQuery.of(context).size.height/15,
                   ),
                   ConstrainedBox(
                       constraints: BoxConstraints(
                         minWidth: 300,
                         maxWidth: 300,
                       ),
                       child: TextFormField(
                         maxLength: 8,
                         keyboardType: TextInputType.number,
                         controller: telController,
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
                           hintText: "Téléphone portable",
                           hintStyle: TextStyle(
                             color: secondColor,
                           ),
                           //    labelText: 'Mail',
                           //  labelStyle: TextStyle(color: secondColor
                           //  ,fontSize: 20),
                         ),
                         validator: (value) {
                           if (value.isEmpty||value.length<4) {
                             return 'Veuillez verifier votre code';
                           }
                           return null;
                         },
                       )
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
                         maxLength: 8,
                         keyboardType: TextInputType.emailAddress,
                         controller: mailController,
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
                           prefixIcon: Icon(Icons.phone,
                               color: secondColor),
                           alignLabelWithHint: true,
                           hintText: "Email",
                           hintStyle: TextStyle(
                             color: secondColor,
                           ),
                           //    labelText: 'Mail',
                           //  labelStyle: TextStyle(color: secondColor
                           //  ,fontSize: 20),
                         ),
                         validator: (value) {
                           if (value.isEmpty||value.length<4) {
                             return 'Veuillez verifier votre mail';
                           }
                           return null;
                         },
                       )
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
                     child:DropDownFormField(
                       titleText: 'Profession',
                       hintText: 'Please choose one',
                       value: _civilite,
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
                           "display": "Etudiant",
                           "value": "Etudiant",
                         },
                         {
                           "display": "Ouvrier",
                           "value": "Ouvrier",
                         },
                         {
                           "display": "Femme au foyer",
                           "value": "Femme au foyer",
                         },
                       ],
                       textField: 'display',
                       valueField: 'value',
                     ),
                   ),
                   Divider(
                     height: MediaQuery.of(context).size.height/4,
                     color: Colors.white,
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
