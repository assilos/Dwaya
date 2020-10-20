import 'package:flutter/material.dart';

enum UserModelStatus {
  Ended,
  Loading,
  Error,
}

class UserModel extends ChangeNotifier {
  UserModelStatus _status;
  String _errorCode;
  String _errorMessage;

  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;
  UserModelStatus get status => _status;

  UserModel();

  UserModel.instance() {
    //TODO Add code here
  }
  
  void getter() {
    _status = UserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = UserModelStatus.Ended;
    notifyListeners();
  }

  void setter() {
    _status = UserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here
    
    _status = UserModelStatus.Ended;
    notifyListeners();
  }

  void update() {
    _status = UserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here
    
    _status = UserModelStatus.Ended;
    notifyListeners();
  }

  void remove() {
    _status = UserModelStatus.Loading;
    notifyListeners();

    //TODO Add code here
    
    _status = UserModelStatus.Ended;
    notifyListeners();
  }
}