import 'dart:async';
import 'package:chatapp/auth/auth_sign_google.dart';
import 'package:chatapp/constants/shared_prefs.dart';
import 'package:chatapp/controller/getxcontroller.dart';
import 'package:chatapp/screens/friends.dart';
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
  PrefManager prefManager = Get.put(PrefManager());
  Controller controller = Get.put(Controller());

  @override
  void initState() {
    super.initState();
    prefManager.getUserData();
    controller.getUsersList();
  }

  @override
  Widget build(BuildContext context) {
    // print("users ${controller.userMap['uid']}");
    // body: Obx(() => controller.userMap['email'] != ""
    //     ?  Center(child: Text(controller.userMap['name'].toString()))
    //     :  Center(child: CircularProgressIndicator())),

    // return  DefaultTabController(
    //   length: 3,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text("Social Chat"),
    //       centerTitle: true,
    //       bottom: TabBar(
    //         tabs: [

    //           Tab(text: "Chats",),
    //           Tab(text: "Friends",),
    //           Tab(text: "Calls",),
    //         ],
    //       ),
    //     ),
    //     body: TabBarView(children: [
    //     FriendsTabView(),
    //       Text("chats"),
    //       Text("cha11"),
    //       Text("Calls"),
    //     ]),
    //   ),
    // );

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black54,
        // drawer: DrawerWidget(),
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
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
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Calls",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(children: [
              Obx(
                () => controller.usersList.isNotEmpty
                    ? FriendsTabView()
                    : Center(child: CircularProgressIndicator()),
              ),
              Text("1"),
              Text("data")
            ])),
      ),
    );
  }
}
