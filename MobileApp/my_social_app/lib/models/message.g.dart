// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isOwner: json['isOwner'] as bool,
      userName: json['userName'] as String,
      conversationId: (json['conversationId'] as num).toInt(),
      senderId: (json['senderId'] as num).toInt(),
      receiverId: (json['receiverId'] as num).toInt(),
      isEdited: json['isEdited'] as bool,
      content: json['content'] as String?,
      state: (json['state'] as num).toInt(),
      numberOfImages: (json['numberOfImages'] as num).toInt(),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isOwner': instance.isOwner,
      'userName': instance.userName,
      'conversationId': instance.conversationId,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'isEdited': instance.isEdited,
      'content': instance.content,
      'state': instance.state,
      'numberOfImages': instance.numberOfImages,
    };
