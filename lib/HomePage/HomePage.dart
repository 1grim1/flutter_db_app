import 'dart:io';

import 'file:///F:/Flutter%20projects/dbapp/lib/Constants_proportion.dart';
import 'package:dbapp/Messenger/Message.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Controller.dart';
import 'HomePageDrawer.dart';

class HomePage extends StatefulWidget{
  final AppController _controller;

  final contentNotifier = ValueNotifier("Главная");


  HomePage(this._controller);

  @override
  State<StatefulWidget> createState() => _HomePageState(_controller, contentNotifier);

}

class _HomePageState extends State<HomePage>{

  final contentNotifier;

  _HomePageState(this._controller, this.contentNotifier);

  final AppController _controller;

  @override
  Widget build(context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent)
    );
    return Scaffold(
        body: ValueListenableBuilder<String>(
          valueListenable: contentNotifier,
          builder: (context, value, _) => value == "Главная" ? _controller.dataStorage.fileDataBase.fileWidget : Message(_controller)
        ),
        drawerScrimColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            RaisedButton(
              onPressed: (){setState(() {_controller.changeHomeContentNotifier('Главная');});},
              child: Icon(Icons.insert_drive_file_outlined),
              color: HomePageAppBarBackgroundColor,
              elevation: 0,
                )
          ],
          backgroundColor: HomePageAppBarBackgroundColor,
          title: ValueListenableBuilder<String>(
              valueListenable: contentNotifier,
              builder: (context, value, _) => Title(
                title: HomeAppBar_title,
                child: Text(value == 'Главная' ? 'Главная' : 'Chat with $value group'),
                color: Colors.amber,
              ),
          ),
        ),
        backgroundColor: HomePageBackgroundColor,
        drawer: _makeDrawer(),
        floatingActionButton: ValueListenableBuilder<String>(
            valueListenable: contentNotifier,
            builder: (context, value, _) => value == "Главная" ? FloatingActionButton(
              backgroundColor: HomePageAppBarBackgroundColor,
              child: Icon(Icons.drive_folder_upload),
              onPressed: () async {
                FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true);
                if(result != null) {
                  List<File> files = result.paths.map((path) => File(path)).toList();
                  _controller.dataStorage.fileDataBase.save(files);
                  setState(() {});
                  _controller.changeHomeContentNotifier('Главная');
                }
              },
            ) : SizedBox.shrink()
        ),
    );
  }

  Widget _makeDrawer() => HomePageDrawer(_controller);
}