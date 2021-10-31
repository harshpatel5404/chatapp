import 'package:chatapp/controller/getxcontroller.dart';
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

  @override
  void initState() {
    super.initState();
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

    return CustomScrollView(
      slivers: [
        // SliverToBoxAdapter(
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Container(
        //       // height: size.height / 14,
        //       // width: size.width,
        //       alignment: Alignment.center,
        //       child: Container(
        //         height: size.height / 17,
        //         width: size.width / 1.15,
        //         child: TextField(
        //           controller: _search,
        //           decoration: InputDecoration(
        //             hintText: "Search",
        //             border: OutlineInputBorder(
        //               borderRadius: BorderRadius.circular(10),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        SliverToBoxAdapter(
          child: Text("sasa"),
        ),
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
                    "data",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    String roomId = chatRoomId(
                        _auth.currentUser!.displayName!, usersMap['name']);
                    Get.to(ChatRoom(
                      chatRoomId: roomId,
                      userMap: usersMap,
                    ));
                  },
                ),
              );
            },
            childCount: controller.usersList.length, // 1000 list items
          ),
        ),
      ],
    );
  }
}
