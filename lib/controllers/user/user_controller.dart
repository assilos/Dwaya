import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import model
import 'package:dweya/models/user/user_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
class UserController extends GetxController{
  UserController();
  String url='http://13af34dc88f0.ngrok.io' ;
  void getter(BuildContext context) {
    UserModel viewModel = Provider.of<UserModel>(context, listen: false);
    //TODO Add code here for getter
    viewModel.getter();
  }
  void setter(BuildContext context) {
    UserModel viewModel = Provider.of<UserModel>(context, listen: false);
    //TODO Add code here for setter
    viewModel.setter();
  }

  void remove(BuildContext context) {
    UserModel viewModel = Provider.of<UserModel>(context, listen: false);
    //TODO Add code here for remove
    viewModel.remove();
  }
  Future<bool> verifierGel () async {
    final response =  await http.post(url+'/VerifierDes') ;
    if (response.statusCode == 200) {
      print('dolly') ;
 return true ;
    } else {
      print('fares') ;
     return false ;
    }
  }
  Future<bool> Login  (String mail,String password ) async {
  //var url = 'http://8a8f1c94fea0.ngrok.io/';
    //var response = await http.get(url,headers:{"Content-type": "application/json"});
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');
    var response = await http.post(url+'/clientsignin',body:{'email':mail,'pwd':password});
//check if mail is correct
    if (response.statusCode!=200)
      {
        return false ;
      }
    //if mail is correct check if password is correct
    else{
      if(response.body.toString() == "mot de passe invalide")
        {
          return false ;
        }
      else
     {
       var parsedJson = json.decode(response.body.toString());
       if(parsedJson != 'mot de passe invalide'){
         var response = await http.post(url+'/UtilisateurToken',body:{'token':parsedJson});
         print('User') ;
         /*save into shared pref*/
         print(response.body) ;
         var parsedBody = jsonDecode(response.body);
         print(parsedBody);
         var email = parsedBody['data']['email'];
         var pwd = parsedBody['data']['pwd'];
         var userId = parsedBody['data']['userId'];
         var nom = parsedBody['iss'];
      final prefs = await SharedPreferences.getInstance();
      print('sololololololololololo');
      print(nom);
         prefs.setString('email',email) ;
         prefs.setString('pwd',pwd) ;
         prefs.setString('userId',userId) ;
         prefs.setString('prenomUser',nom);
         /*save into shared pref*/
         //redirection after login
         return true ;
         //redirection after login
         //}else{
         //  print('wrong login credentials');
       }
       else{
         return false ;
       }
     }
    }

      //JSON DECODER
 //   });
    // LOGIN GET REQUEST IS HERE
  }
  Future<bool> Inscription  (String nom,String prenom,String civilite,String date,String gouvernorat,String chaine,String magasin,int codePostal,
      int tel,String email,String profession,String password,String cvilite) async {
    print('Login info');
    var response = await http.post(url+'/Inscription',body:{'nom':nom,'prenom':prenom,'date_naissance':date,'gouvernorat':gouvernorat,'chaine':chaine,'magasin':magasin
    ,'profession':profession,'codepostal':codePostal,'civilite':cvilite,'email':email,'tel':tel,'password':password});
    print(response.statusCode);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body.toString()}');
//check if mail is correct
    //if mail is correct check if password is correct


    //JSON DECODER
    //   });
    // LOGIN GET REQUEST IS HERE
  }
}