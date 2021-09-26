import 'package:dbapp/DataStorage.dart';
import 'package:dbapp/FileDataBase.dart';
import 'package:dbapp/HomePage/HomePage.dart';
import 'package:flutter/cupertino.dart';

class AppController{


  String messageServer = 'wss://echo.websocket.org';

  DataStorage dataStorage;

  DataStorage get data => dataStorage;

  HomePage homePage;

  void changeHomeContentNotifier(String text){ // change this for other widget
    homePage.contentNotifier.value = text;
  }

  AppController(){
    homePage = HomePage(this);
    dataStorage = DataStorage(this);
  }

}