import 'dart:io';

import 'package:chatapp/controller/getxcontroller.dart';
import 'package:chatapp/models/chatlist.dart';
import 'package:chatapp/screens/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'auth/auth_sign_google.dart';
import 'constants/shared_prefs.dart';
import 'screens/home_screen.dart';

Controller controller = Get.put(Controller());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ChatListAdapter());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  controller.getChatList();
  runApp(MyApp(
      defaultHome: (true == await getLoggedIn()) ? HomePage() : SignIn()));
}

class MyApp extends StatelessWidget {
  final Widget? defaultHome;

  const MyApp({Key? key, this.defaultHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: "baloobhai",
      ),
      home: defaultHome,
    );
  }
}
