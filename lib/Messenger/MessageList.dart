import 'package:dbapp/Messenger/MessageUnit.dart';
import 'package:flutter/cupertino.dart';

class MessageList extends StatefulWidget{

  final state =  MessageListState();

  @override
  State<StatefulWidget> createState() => state;

  void addMessage(MessageUnit msg){
    state.addContent(msg);
  }

}


class MessageListState extends State<MessageList>{

  List<MessageUnit> content = [MessageUnit("HI", DateTime.now(), Alignment.bottomLeft)];

  void addContent(MessageUnit msg){
    setState(() {
      content.add(msg);
    });
  }

  MessageUnit getMsg(int index){
    return content.reversed.elementAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: content.length,
      reverse: true,
      itemBuilder: (BuildContext context, int index) => Padding(padding: EdgeInsets.all(8), child: this.getMsg(index))
    );
  }
  
}