import 'package:dwaya/Screens/Signup/components/background.dart';
import 'package:dwaya/Screens/Signup/components/orDivider.dart';
import 'package:dwaya/Screens/Signup/components/socalicon.dart';
import 'package:dwaya/Screens/login/login_screen.dart';
import 'package:dwaya/components/AlreadyHaveAnAccountChecked.dart';
import 'package:dwaya/components/rounded_button.dart';
import 'package:dwaya/components/rounded_input_field.dart';
import 'package:dwaya/components/rounded_password_countainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rflutter_alert/rflutter_alert.dart';

class Body extends StatefulWidget {
  final Widget child;

  Body({Key key, @required this.child}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var email;

  var password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.3,
            ),
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
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                print(email);
                print(password);
                signup(email, password, context);
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountChecked(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

signup(email, password, context) async {
  var url = "http://10.0.2.2:3001/api/user/signup"; // iOS
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

  if (response.statusCode == 201) {
    message(context);
  } else {
    throw Exception('Failed to create album.');
  }
}

message(context) async {
  Alert(
    context: context,
    type: AlertType.success,
    title: "Success",
    desc: "Veuillez connecter pour confirmer votre insciption",
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return LoginScreen();
              },
            ),
          );
        },
        width: 120,
      )
    ],
  ).show();
}
