import 'package:chatapp/controller/getxcontroller.dart';
import 'package:chatapp/main.dart';
import 'package:chatapp/models/chatlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ChatRoom extends StatelessWidget {
  final Map? userMap;
  final String? chatRoomId;

  ChatRoom({Key? key, this.userMap, this.chatRoomId}) : super(key: key);

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Controller controller = Get.find();

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser!.displayName,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };
      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);

      ChatList chatlist = ChatList(
        roomId: chatRoomId!,
        userMap: userMap!,
      );
      var box = await Hive.openBox<ChatList>("chatlistbox");
      // box.add(chatlist);
      // controller.chatList.add(chatlist);
      List roomidList = [];
      for (var i = 0; i < controller.chatList.length; i++) {
        roomidList.add(controller.chatList[i].roomId);
      }

      if (!roomidList.contains(chatRoomId!)) {
        box.add(chatlist);
        controller.chatList.add(chatlist);
      } else {
        print("roomid Exites");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(userMap!['imageUrl']),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              userMap!['name'],
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height / 1.37,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('chatroom')
                    .doc(chatRoomId)
                    .collection('chats')
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> map = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        return messages(size, map, context);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              height: size.height / 12,
              width: size.width / 1.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 55,
                    width: size.width / 1.3,
                    child: TextField(
                      controller: _message,
                      decoration: InputDecoration(
                          // suffixIcon: IconButton(
                          //   // onPressed: () => getImage(),
                          //   icon: Icon(Icons.photo),
                          // ),
                          hintText: "Send Message",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.send), onPressed: onSendMessage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
    return map['type'] == "text"
        ? Container(
            width: size.width,
            alignment: map['sendby'] == _auth.currentUser!.displayName
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue,
              ),
              child: Text(
                map['message'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : Container();
    // : Container(
    //     height: size.height / 2.5,
    //     width: size.width,
    //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    //     alignment: map['sendby'] == _auth.currentUser!.displayName
    //         ? Alignment.centerRight
    //         : Alignment.centerLeft,
    //     child: InkWell(
    //       onTap: () =>
    //        Navigator.of(context).push(
    //         MaterialPageRoute(
    //           builder: (_) => ShowImage(
    //             imageUrl: map['message'],
    //           ),
    //         ),
    //       ),
    //       child: Container(
    //         height: size.height / 2.5,
    //         width: size.width / 2,
    //         decoration: BoxDecoration(border: Border.all()),
    //         alignment: map['message'] != "" ? null : Alignment.center,
    //         child: map['message'] != ""
    //             ? Image.network(
    //                 map['message'],
    //                 fit: BoxFit.cover,
    //               )
    //             : CircularProgressIndicator(),
    //       ),
    //     ),
    //   );
  }
}
