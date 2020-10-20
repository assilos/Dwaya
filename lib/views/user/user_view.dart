import 'package:dweya/main.dart';
import 'package:dweya/views/user/components/profil.dart';
import 'package:dweya/views/user/layouts/main/main_tab.dart';
import 'package:dweya/views/user/layouts/register/registerone_view.dart';
import 'package:dweya/views/user/layouts/register/registertwo_view.dart';
import 'package:dweya/views/user/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// import model
import 'package:dweya/models/user/user_model.dart';
// import controller
import 'package:dweya/controllers/user/user_controller.dart';
import 'package:get/get.dart';
class UserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color mainColor = Color.fromRGBO(	211, 232, 213,1.0);
    Color secondColor = Color.fromRGBO(19, 117, 71,1.0);
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
                    height: Get.height/4.5,
                  ),
                  Image.asset('assets/images/logo.png',
                    width: Get.width*0.75,
                    height: Get.width*0.2,
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
  UserController viewController = Get.put(UserController());
  AnimationController controller;
  bool _mail = false ;
  bool pwd = false ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Color mainColor =  Color.fromRGBO(213, 240, 227,1.0);
    Color secondColor = Color.fromRGBO(19,117,71,1.0);
    void _toggle(bool visbility) {
      setState(() {
        _mail = !visbility;
      });
      if (_mail == false)
        {
         Get.off(MainTab(), transition: Transition.fade  ) ;
        }
    }
    // Build a Form widget using the _formKey created above.
    return
      Form(
        key: _formKey,
        child: Container(
          height: Get.height*(3/4),
          width: Get.width*(0.90),
          child:Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
            ),
            borderOnForeground: false,
            color: Colors.white,
            child: Column(
                children: <Widget>[
                  Divider(
                    height: Get.height/11,
                  ),
                  ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 300,
                        maxWidth: 300,
                      ),
                      child :TextFormField(
                        controller: mailController,
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
                          prefixIcon: Icon(Icons.alternate_email,
                              color: secondColor),
                          alignLabelWithHint: true,
                          hintText: "Mail",
                          hintStyle: TextStyle(
                            fontFamily: 'Comfortaa',
                            color: secondColor,
                          ),
                          //    labelText: 'Mail',
                          //  labelStyle: TextStyle(color: secondColor
                          //  ,fontSize: 20),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (!value.contains('@')||value.endsWith('com')||value.isEmpty) {
                            return 'Veuillez verifier votre mail';
                          }
                          return null;
                        },
                      )
                  ),
                  Center(

                  ),
                  Divider(
                    color: Colors.white,
                    height: Get.height/20,
                  ),
                  ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 300,
                        maxWidth: 300,
                      ),
                      child: TextFormField(
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
                            return 'Veuillez insérer votre mot de passe';
                          }
                          return null;
                        },
                      )
                  ),
                  Visibility(
                    visible: _mail,
                    child:  Text('Veuillez verifier vos informations',style: TextStyle(
                      color: secondColor,
                    ),
                    ) ,
                  ),
                  Divider(
                    color: Colors.white,
                    height: Get.height/12,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: Get.width*(0.5),
                      ),
                      Text(
                        'Mot de passe oublié ?',
                        style: TextStyle(
                          color: secondColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                    height: Get.height/12,
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
                            "Se connecter",
                            maxLines: 1,
                            style: TextStyle(color: Colors.white,fontSize: 20),
                          ),
                        ],
                      ),
                    ),

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)
                    ),
                    onPressed: () async {
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                  await viewController.Login(mailController.text, passwordController.text).then((value) =>
                     _toggle(value)
                      );
                      }
                    },
                  ),
                  Divider(
                    color: Colors.white,
                    height: Get.height/14,
                  ),
                  Text(
                    'Pas de compte ?',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
          InkWell(

            onTap: () {
           Get.to(RegisterView());
            },
            child: Text(
              'Inscrivez vous ici ',
              style: TextStyle(
                color: secondColor,
              ),
            ),
          ),
                  // Add TextFormFields and RaisedButton here.
                ]
            ),
          ) ,
          
        )
    );
  }
}
