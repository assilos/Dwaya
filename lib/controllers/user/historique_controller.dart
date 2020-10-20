import 'package:dweya/models/user/historique.dart';
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
class HistoriqueController extends GetxController{
  HistoriqueController();
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

  Future<List<Historique>> HistoriquebyClient () async {
    final prefs = await SharedPreferences.getInstance();
   String id =  prefs.getString('userId') ;
    final response =  await http.post(url+'/factureByIdClient',body:{'id_client':id}) ;
    if (response.statusCode == 200) {
      print("Historique d'un client :") ;
      List jsonResponse = json.decode(response.body);
      print(jsonResponse);
      print((jsonResponse.map((job) => new Historique.fromJson(job))));
      return jsonResponse.map((job) => new Historique.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }

  }

}