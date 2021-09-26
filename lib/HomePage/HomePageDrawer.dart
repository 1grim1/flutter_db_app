import 'dart:convert';

import 'package:dbapp/Additional/FacultyAvatar.dart';
import 'package:dbapp/Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageDrawer extends StatefulWidget{

  final AppController _controller;

  HomePageDrawer(this._controller);

  @override
  State<StatefulWidget> createState() => _HomePageDrawerState(_controller);

}

class _HomePageDrawerState extends State<HomePageDrawer>{

  final AppController _controller;

  _HomePageDrawerState(this._controller);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _controller.data.loadAssetData('data/DrawerData_test'),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot){                    // !! add error handler
          if(snapshot.connectionState == ConnectionState.done){
            return FacultyAvatarRealizing(json.decode(snapshot.data), _controller);
          }else{
            return CircularProgressIndicator();
          }
        }
    );
  }

}