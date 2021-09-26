import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import '../../Constants_proportion.dart';
import '../../Controller.dart';
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

const users = const {
  'test@test.com': '12345',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Db db;

  LoginScreen(){
    db = Db('mongodb://10.0.2.2:27017/users');
    openDb();
    print('db was opened');
  }

  void openDb() async {
    await db.open();
}


  bool loginComplete = false;

  _findUser(String login, String password) async{
    var collection = db.collection('users');
    try {
      print(collection);
      var data = await collection.find({'login' : login, 'password': password}).first;
      print(data);
      loginComplete = data != null;
      print(data);
      return data;
    }
    catch(e){
      return null;
    }
  }

  _insetNewUser(String login, String password) async {
    var collection = db.collection('users');
    await collection.insertOne({'_id':login, 'userLogin' : login, 'password': password});
  }

  Future<String> signUpUser(LoginData data){
    _insetNewUser(data.name, data.password);
    return null;
  }

  Future<String> loginUser(LoginData data){
   //collection.find({'userLogin' : data.name, 'password': data.password}).first;
   _findUser(data.name, data.password);
   return Future.delayed(loginTime).then((value) => loginComplete ? null : 'Bad login or password. Try again or SignUp');
  }

  @override
  Widget build(BuildContext context) {
    AppController controller = AppController();
    return FlutterLogin(
      theme: LoginTheme(
        primaryColor: HomePageAppBarBackgroundColor,
        pageColorLight: HomePageAppBarBackgroundColor,
        pageColorDark: HomePageAppBarBackgroundColor
      ),
      title: 'DBApp',
      logo: null,
      onLogin: loginUser,
      onSignup: signUpUser,
      onSubmitAnimationCompleted: () {
        if (loginComplete)
          Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => controller.homePage,
        ));
      },
      onRecoverPassword: (name) => null,
    );
  }
}