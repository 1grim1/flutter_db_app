import 'dart:io';

import 'package:dbapp/Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class MassageDataBase{


  AppController _controller;

  MassageDataBase(this._controller){
    initMassageDataBase();
  }

  Box messageBox;

  _insert(String msg, String time) async {
    messageBox.put(time, {
      'msg': msg,
      'time': time,
    });
  }


  void addMSG (String msg, String time){
    _insert(msg, time);
  }


  initMassageDataBase() async {
    final appdir = await getApplicationDocumentsDirectory();
    Hive.init(appdir.path);
    messageBox = await Hive.openBox('Messages');
    print('MASSAGE BOX INIT!');
  }
}