import 'dart:ui';

import 'package:Dwaya/controllers/user/liste_controller.dart';
import 'package:Dwaya/controllers/user/produit_controller.dart';
import 'package:Dwaya/controllers/user/user_controller.dart';
import 'package:Dwaya/views/user/components/users_list_page.dart';
import 'package:random_color/random_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';


class RecompenseScreen extends StatefulWidget {
  RecompenseScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _RecompenseScreenState createState() => _RecompenseScreenState();
}

class _RecompenseScreenState extends State<RecompenseScreen> {
  var _userIDController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _client = Client('mcjpy234txqp', logLevel: Level.INFO);
  UserController ctrl = new UserController();
  @override
  void dispose() {
    _userIDController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Login',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
              Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text('Enter your unique user id',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400))),
              Container(
                  margin: EdgeInsets.only(top: 5),
                  child: TextFormField(
                      controller: _userIDController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFCBD2D9), width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFCBD2D9),
                                  width: 1,
                                  style: BorderStyle.solid))))),
              Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: RaisedButton(
                      onPressed: () {
                        _loginUser();
                      },
                      child: Text('Continue')))
            ],
          ),
        ),
      ),
    );
  }

  _loginUser() async {
    final userID = _userIDController.text.trim();

    if (userID.isEmpty) {
      SnackBar snackBar = SnackBar(content: Text('User id is empty'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
      return;
    }

    User u = new User(id: 'marou',role:'user' ,banned:false ,online:true );
    User u2 = new User(id: 'rosa',role:'user' ,banned:false ,online:true );
    User u3 = new User(id: 'assil',role:'user' ,banned:false ,online:true );
    User u4= new User(id: 'med',role:'user' ,banned:false ,online:true );
    User u5 = new User(id: 'aziz',role:'user' ,banned:false ,online:true );
    setState(() {
      _client.updateUsers([u,u2,u3,u4,u5]);
    });


    var userToken = await ctrl.token(_client);
    

    await _client.setUser(User(id: 'marou',role: 'user',), userToken).then((response) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StreamChat(
              client: _client,
              child: UsersListPage(),
            )),
      );
    }).catchError((error) {
      print(error);
      SnackBar snackBar = SnackBar(content: Text('Could not login user'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    });
  }

}
