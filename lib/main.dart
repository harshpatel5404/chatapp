import 'package:chatapp/screens/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'auth/auth_sign_google.dart';
import 'constants/shared_prefs.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  // getAccountObject();
  runApp(MyApp(
    defaultHome: (true == await getLoggedIn()) ? HomePage() : SignIn(),
  ));
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
