import 'package:dbapp/Controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Autentification/LogIn/LogInPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppController controller = AppController();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  const autoLogin = true;
  runApp(
      MaterialApp(
          home: !autoLogin ? LoginScreen() : controller.homePage,
          debugShowCheckedModeBanner: false,
      )
  );
}