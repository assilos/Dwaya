import 'package:dweya/models/user/liste.dart';
import 'package:dweya/models/user/produit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
// import model
import 'package:dweya/models/user/user_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
class ListeController extends GetxController{
  ListeController();
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
  Future<List<Liste>>  AfficherListe () async {
    final prefs = await SharedPreferences.getInstance();
    String id =  prefs.get('userId') ;
    final response =  await http.post(url+'/listeByIdClient',body:{'id_client':id}) ;
    if (response.statusCode == 200) {
      print("Liste    : ");
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Liste.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }

  }



  Future<bool> AjouterListe  (String nom) async {
    print('Login info');
    final prefs = await SharedPreferences.getInstance();
    String id =  prefs.get('userId') ;
    var response = await http.post(url+'/ajouterListe',body:{'nom':nom,'id_client':id});
    print(response.statusCode);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body.toString()}');
//check if mail is correct
    //if mail is correct check if password is correct
    if (response.statusCode == 200) {
      print("Liste    : ");
      List jsonResponse = json.decode(response.body);
      return true ;
    } else {
     return false ;
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