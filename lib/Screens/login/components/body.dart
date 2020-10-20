import 'package:dwaya/Screens/Signup/signup_screen.dart';
import 'package:dwaya/Screens/profil/profil_page.dart';
import 'package:dwaya/components/AlreadyHaveAnAccountChecked.dart';
import 'package:dwaya/components/rounded_button.dart';
import 'package:dwaya/components/rounded_input_field.dart';
import 'package:dwaya/components/rounded_password_countainer.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'background.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var email;

  var password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackGround(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/Login2.png",
              height: size.height * 0.40,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordCountainer(
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                print(email);
                print(password);
                signin(email, password);
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountChecked(press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  signin(email, password) async {
    var url = "http://10.0.2.2:3001/api/user/login"; // iOS
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ProfilePage();
          },
        ),
      );
    } else {
      message(context);
    }
  }

  message(context) async {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Echec de connexion",
      desc: "Votre email ou mot de passe est incorrect",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
}
