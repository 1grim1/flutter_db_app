

import 'dart:io';

import 'package:dbapp/Constants_proportion.dart';
import 'package:dbapp/Controller.dart';
import 'package:dbapp/Messenger/MessageList.dart';
import 'package:dbapp/Messenger/MessageUnit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Message extends StatelessWidget {


  AppController _controller;

  GlobalKey<MessageListState> globalKeyForMsgListState = GlobalKey();

  final msgList =  MessageList();


  TextEditingController _textEditingController = TextEditingController();

  Message(this._controller){
    channel = WebSocketChannel.connect(Uri.parse(_controller.messageServer));
  }

  WebSocketChannel channel;

  void logs(String mes, DateTime time){
    _controller.dataStorage.messageDB.addMSG(mes, time.microsecondsSinceEpoch.toString());
    print('[Message - $mes Time - ${time.microsecondsSinceEpoch.toString()}] Status - SAVED\n');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomePageBackgroundColor,
      body: Column(
        children: <Widget>[
          Expanded(child: msgList),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true);
                      if(result != null) {
                        List<File> files = result.paths.map((path) =>
                            File(path)).toList();
                        _controller.dataStorage.fileDataBase.save(files);
                      }
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: HomePageAppBarBackgroundColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20, ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){
                      logs(_textEditingController.text, DateTime.now());
                      msgList.addMessage(MessageUnit(_textEditingController.text, DateTime.now(), Alignment.bottomRight));
                      _textEditingController.clear();
                    },
                    child: Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: HomePageAppBarBackgroundColor,
                    elevation: 0,
                  ),
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }

}
/* StreamBuilder(
      stream: channel.stream,
      builder: (context, snapshot){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: Colors.blueGrey,
          ),
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'write message here'
            ),
          ),
        ); // widget here
      },
    );*/
