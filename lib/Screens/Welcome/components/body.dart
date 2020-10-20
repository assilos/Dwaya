import 'package:dwaya/Screens/Signup/signup_screen.dart';
import 'package:dwaya/Screens/login/login_screen.dart';
import 'package:dwaya/components/rounded_button.dart';
import 'package:dwaya/constants.dart';
import 'package:flutter/material.dart';
import 'package:dwaya/Screens/Welcome/components/background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; //return height and width of our screen

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome to dwaya",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Image.asset(
              "assets/images/Login.png",
              height: size.height * 0.45,
            ),
            RoundedButton(
              text: "LOGIN",
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
            RoundedButton(
              text: "REGISTER",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
