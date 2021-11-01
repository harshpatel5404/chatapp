import 'package:chatapp/controller/getxcontroller.dart';
import 'package:chatapp/main.dart';
import 'package:chatapp/screens/chatroom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendsTabView extends StatefulWidget {
  const FriendsTabView({Key? key}) : super(key: key);

  @override
  _FriendsTabViewState createState() => _FriendsTabViewState();
}

class _FriendsTabViewState extends State<FriendsTabView> {
  Controller controller = Get.put(Controller());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void addrealtimeuser() async {
    List updateUserList = [];
    await firebaseFirestore.collection('users').get().then((value) {
      value.docs.map((data) {
        updateUserList.add(data.data());
      }).toList();
    });
    if (controller.usersList.length < updateUserList.length) {
      controller.usersList.value = [];
      controller.getUsersList();
    }
  }

  @override
  void initState() {
    super.initState();
    addrealtimeuser();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final TextEditingController _search = TextEditingController();

    String chatRoomId(String user1, String user2) {
      if (user1[0].toLowerCase().codeUnits[0] >
          user2.toLowerCase().codeUnits[0]) {
        // print("user1");
        // print(user1[0].toLowerCase().codeUnits[0]);
        // print("user2");
        // print(user2.toLowerCase().codeUnits[0]);
        return "$user1$user2";
      } else {
        return "$user2$user1";
      }
    }

    return Obx(() => controller.usersList.isNotEmpty
        ? CustomScrollView(
            slivers: [
               SliverPadding(padding: EdgeInsets.symmetric(vertical: 5)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    Map usersMap = controller.usersList[index];

                    return Container(
                      height: size.height / 10,
                      width: size.width,
                      // color: Colors.black,
                      child: ListTile(
                        title: Text(
                          usersMap['name'],
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(usersMap['imageUrl']),
                        ),
                        trailing: Text(
                          "chat",
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          String roomId = chatRoomId(
                              _auth.currentUser!.displayName!,
                              usersMap['name']);
                          Get.to(
                            ChatRoom(
                              chatRoomId: roomId,
                              userMap: usersMap,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  childCount: controller.usersList.length, // 1000 list items
                ),
              ),
            ],
          )
        : Center(child: CircularProgressIndicator()));
  }
}
