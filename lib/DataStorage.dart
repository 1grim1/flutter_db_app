import 'dart:async';

import 'package:dbapp/Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Additional/FacultyAvatar.dart';
import 'FileDataBase.dart';
import 'Messenger/MassageDataBase.dart';

class DataStorage{ // represents data container and  data controller and methods for load store and other

  AppController _controller;
  MassageDataBase messageDB;

  DataStorage(this._controller){
    fileDataBase = FileDataBase(_controller);
    messageDB = MassageDataBase(_controller);
  }

  FileDataBase fileDataBase;

  FileDataBase get fileDB => fileDataBase;

  Future<String> loadAssetData(String assetFileName) async {
    // HERE GET REQUEST FROM SERVER TO LOAD DATA
    return await rootBundle.loadString('assets/' + assetFileName);
  }
}
