import 'package:hive/hive.dart';
part "chatlist.g.dart";
@HiveType(typeId: 0)
class ChatList{
  
    @HiveField(0)
    String? roomId;

    @HiveField(1)
    Map? userMap;


    ChatList({this.roomId,this.userMap});

}