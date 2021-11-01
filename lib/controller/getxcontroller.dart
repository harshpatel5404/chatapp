import 'package:chatapp/models/chatlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class Controller extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxList usersList = [].obs;
  RxList chatList = [].obs;

  void getChatList() async {
    final box = await Hive.openBox<ChatList>("chatlistbox");
    chatList.value = box.values.toList();
    print("chatlist ${chatList}");
    // print("chatlist ${chatList[0].userMap['name']}");
  }

  void getUsersList() async {
    await firebaseFirestore.collection('users').get().then((value) {
      value.docs.map((data) {
        usersList.add(data.data());
      }).toList();
    });
    // print(usersList);
  }
}
  // print("val ${value.docs}");
      // for (var i = 0; i < value.docs.length; i++) {
      //   print("data is : ${value.docs[i].data()}");
      //   usersMap = value.docs[i].data();
      // }