import 'dart:io';

import 'package:dbapp/Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FileDataBase {

  AppController _controller;

  FileDataBase(this._controller);



  Box fileBox;




  void _saveFile(data) {
    print('I WILL SAVE THIS $data');
  }

  Widget _fileElemWidget(context, String name) {
    String file_type = name
        .split('.')
        .last;
    Icon icon = Icon(Icons.upload_file);

    if (file_type == 'pdf')
      icon = Icon(Icons.picture_as_pdf);

    var snapshot = fileBox.get(name);

    return GestureDetector(
      onTap: () {
        print('saved file $name');
        _saveFile(snapshot);
      },
      child: Container(
          width: double.infinity,
          height: 50,
          child: Card(
            child: Row(
              children: [
                icon,
                SizedBox(height: double.infinity, width: 10),
                Expanded(flex: 3, child: Text(name))
              ],
            ),
          )
      ),
    );

  }


  Widget get fileWidget {
    if (fileBox == null) initFileDataBase();
    return ListView.builder(
        itemCount: fileBox == null ? 0 : fileBox.length,
        itemBuilder: (context, index) {
          return _fileElemWidget(
              context, fileBox.getAt(index)['name']); //////////
        }
    );
  }

  _insert(String name, String path, dynamic data) async {
    fileBox.put(name, {
      'name': name,
      'path': path,
      'data': data
    });
  }

  save(List<File> files) async {
    for (File file in files){
      String name = file.path.split('/').last;
      _insert(name, file.path, file.readAsBytesSync());
    }
  }


  initFileDataBase() async {
    final appdir = await getApplicationDocumentsDirectory();
    Hive.init(appdir.path);
    fileBox = await Hive.openBox('Files');
    print('BOX INIT!');
  }
}
