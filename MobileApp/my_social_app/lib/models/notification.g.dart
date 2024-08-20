// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      id: (json['id'] as num).toInt(),
      ownerId: (json['ownerId'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isViewed: json['isViewed'] as bool,
      type: (json['type'] as num).toInt(),
      parentId: (json['parentId'] as num?)?.toInt(),
      repliedId: (json['repliedId'] as num?)?.toInt(),
      commentId: (json['commentId'] as num?)?.toInt(),
      content: json['content'] as String?,
      questionId: (json['questionId'] as num?)?.toInt(),
      userId: (json['userId'] as num).toInt(),
      userName: json['userName'] as String,
      solutionId: (json['solutionId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'createdAt': instance.createdAt.toIso8601String(),
      'isViewed': instance.isViewed,
      'type': instance.type,
      'parentId': instance.parentId,
      'commentId': instance.commentId,
      'repliedId': instance.repliedId,
      'content': instance.content,
      'questionId': instance.questionId,
      'userId': instance.userId,
      'userName': instance.userName,
      'solutionId': instance.solutionId,
    };
