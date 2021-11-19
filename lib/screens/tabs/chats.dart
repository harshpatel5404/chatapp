import 'package:chatapp/controller/getxcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../chat_screen.dart';

class ChatTabView extends StatelessWidget {
  ChatTabView({Key? key}) : super(key: key);
  Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => controller.chatList.isNotEmpty
          ? CustomScrollView(
              slivers: [
                SliverPadding(padding: EdgeInsets.symmetric(vertical: 5)),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      Map usersMap = controller.chatList[index].userMap;
                      String roomId = controller.chatList[index].roomId;                      
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
                    childCount: controller.chatList.length, // 1000 list items
                  ),
                ),
              ],
            )
          : Center(child: Text("No Chats Found!",style: TextStyle(color: Colors.white),)),
    );
  }
}
