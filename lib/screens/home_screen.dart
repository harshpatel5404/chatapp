import 'dart:async';
import 'package:chatapp/auth/auth_sign_google.dart';
import 'package:chatapp/constants/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PrefManager controller = Get.put(PrefManager());

  @override
  void initState() {
    super.initState();
    controller.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    // print("users ${controller.userMap['uid']}");
    // body: Obx(() => controller.userMap['email'] != ""
    //     ?  Center(child: Text(controller.userMap['name'].toString()))
    //     :  Center(child: CircularProgressIndicator())),

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Social Chat"),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
             
              Tab(icon: Icon(Icons.directions_bike)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
        ),
        body: Text("data"),
      ),
    );
  }
}
