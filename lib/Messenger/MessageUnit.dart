import 'package:dbapp/Constants_proportion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageUnit extends StatelessWidget{

  final String text;
  final DateTime time;
  final AlignmentGeometry align;
  MessageUnit(this.text, this.time,  this.align);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2
          ),
          color: Colors.white38,
          borderRadius: BorderRadius.all(Radius.circular(25))
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(text),
        )
      )
    );
  }

}