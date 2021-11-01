// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatlist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatListAdapter extends TypeAdapter<ChatList> {
  @override
  final int typeId = 0;

  @override
  ChatList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatList(
      roomId: fields[0] as String?,
      userMap: (fields[1] as Map?)?.cast<dynamic, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, ChatList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.roomId)
      ..writeByte(1)
      ..write(obj.userMap);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
