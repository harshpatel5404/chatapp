import 'dart:async';
import 'package:chatapp/auth/auth_sign_google.dart';
import 'package:chatapp/constants/shared_prefs.dart';
import 'package:chatapp/controller/getxcontroller.dart';
import 'package:chatapp/screens/tabs/friends.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'tabs/chats.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  PrefManager prefManager = Get.put(PrefManager());
  Controller controller = Get.put(Controller());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    
    prefManager.getUserData();
    controller.getUsersList();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print("on");
      setStatus("Online");
    } else {
      setStatus("Offline");
      print("off");
    }
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black54,
        // drawer: DrawerWidget(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              const SliverAppBar(
                title: Text("Social Chat"),
                centerTitle: true,
                floating: false,
                pinned: true,
                // snap: true,
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  indicatorWeight: 3.5,
                  labelColor: Colors.white,
                  unselectedLabelStyle: TextStyle(color: Colors.white),
                  unselectedLabelColor: Colors.white,
                  tabs: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Chats",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "Friends",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Calls",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(children: [
            ChatTabView(),
            FriendsTabView(),
            Text("data"),
          ]),
        ),
      ),
    );
  }
}
