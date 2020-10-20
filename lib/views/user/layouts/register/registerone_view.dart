import 'package:dweya/main.dart';
import 'package:dweya/views/user/layouts/register/registertwo_view.dart';
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

import 'package:get/get.dart';

class RegisterOneView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color mainColor = Color.fromRGBO(213, 240, 227,1.0);
    Color secondColor = Color.fromRGBO(19,117,71,1.0);
    Get.put(RegisterOneView()) ;
    RegisterOneView one = Get.find();
    return ChangeNotifierProvider<UserModel>(
      create: (context) => UserModel.instance(),
      child: Consumer<UserModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
              resizeToAvoidBottomPadding: true,
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body:SingleChildScrollView(
                child:  SizedBox(
                  height: Get.height*0.85,
                  child: Column(
                    children: [
                      Divider(
                        color: Colors.orange,
                        height: Get.height/15,
                      ),
                      Image.asset('assets/images/logo.png',
                        width: MediaQuery.of(context).size.width*0.75,
                        height: MediaQuery.of(context).size.width*0.2,
                      ),
                      MyCustomForm(),
                    ],
                  ),
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
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  UserController viewController = UserController();

  bool mail = false ;
  bool pwd = false ;

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
            color: Colors.white,
            height: Get.height*0.6,
            width: MediaQuery.of(context).size.width*(0.90),
            child:Flex(
              direction: Axis.vertical,
              children: [
                Column(
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
                              hintText: "Nom",
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
                            controller: prenomController,
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
                              hintText: "Prenom",
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
                          titleText: 'Cvilité',
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
                        child:DateTimeField(
                          controller: dateController,
                          decoration: InputDecoration(
                            fillColor: mainColor,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: mainColor,
                              ),
                              borderRadius: BorderRadius.circular(33.0),
                            ),
                            prefixIcon: Icon(Icons.date_range,
                                color: secondColor),
                            alignLabelWithHint: true,
                            hintText: "Date de naissance",
                            hintStyle: TextStyle(
                              color: secondColor,
                            ),
                            //    labelText: 'Mail',
                            //  labelStyle: TextStyle(color: secondColor
                            //  ,fontSize: 20),
                          ),
                          format: format,
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                        ),
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
