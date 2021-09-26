import 'dart:convert';

import 'package:dbapp/Constants_proportion.dart';
import 'package:dbapp/Controller.dart';
import 'package:dbapp/Messenger/Message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FacultyAvatarRealizing extends StatefulWidget{ // represents serializing of faculty avatars (json decode)

  List data;

  AppController _controller;

  FacultyAvatarRealizing(this.data, this._controller);


  @override
  State<StatefulWidget> createState() => _FacultyAvatarRealizingState(data, _controller);
}

class _FacultyAvatarRealizingState extends State<FacultyAvatarRealizing>{

  List data;
  AppController _controller;

  _FacultyAvatarRealizingState(this.data, this._controller);

  List<Widget> _getFacultyList(){
    List<Widget> list = [];
    for(int i = 0; i < data.length ; i++){
      list.add(
          GestureDetector(
            child: FacultyAvatar.fromJson(data[i], _controller),
          )
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: (MediaQuery.of(context).padding.top + kToolbarHeight)),
      child: Drawer(
        child: GridView.count(
          children: _getFacultyList(),
          padding: EdgeInsets.symmetric(horizontal: 10), // add const param!!!!!
          crossAxisCount: 3,
        ),
      ),
    );
  }

}


class FacultyAvatar extends StatelessWidget { // represents single avatar (clickable)

  String backgroundColor;
  String title;
  AppController _controller;
  List group;

  FacultyAvatar(this.backgroundColor, this.title);

  FacultyAvatar.fromJson(Map<String, dynamic> json, this._controller)
      :
        backgroundColor = json['backgroundColor'],
        title = json['title'],
        group = json['group'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      elevation: 0,
      underline: SizedBox(),
      icon: CircleAvatar(
        backgroundColor: FacultyAvatarColor,
        child: Text(title),
      ),
      items: group.map((value) =>  DropdownMenuItem(value: value,child: Text(value))).toList(),
      onChanged: (value) {
        _controller.changeHomeContentNotifier(value);
      },
    );
  }
}
  