import 'package:flutter/material.dart';
import 'package:my_social_app/state/app_state/message_entity_state/message_stataus.dart';

@immutable
class MessageState{
  final int id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isOwner;
  final String userName;
  final int conversationId;
  final int senderId;
  final int receiverId;
  final bool isEdited;
  final String? content; 
  final int state;
  final int numberOfImages;

  const MessageState({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.isOwner,
    required this.userName,
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.isEdited,
    required this.content,
    required this.state,
    required this.numberOfImages,
  });

  MessageState _optinal({
    String? newUserName,
    bool? newIsEdited,
    String? newContent,
    int? newState,
    int? newNumberOfImages,
  })
    => MessageState(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        isOwner: isOwner,
        userName: newUserName ?? userName,
        conversationId: conversationId,
        senderId: senderId,
        receiverId: receiverId,
        isEdited: newIsEdited ?? isEdited,
        content: newContent ?? content,
        state: newState ?? state,
        numberOfImages: newNumberOfImages ?? numberOfImages,
      );
  
  String? formatContent(int count){
    if(content == null || content!.length <= count) return content;
    return "${content!.substring(0,count - 3)}...";
  }  

  MessageState markAsReceived() => _optinal( newState: state != MessageStatus.viewed ? MessageStatus.received : state);
  MessageState markAsViewed() => _optinal(newState: MessageStatus.viewed);
  
}