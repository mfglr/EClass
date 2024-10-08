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
      commentId: (json['commentId'] as num?)?.toInt(),
      repliedId: (json['repliedId'] as num?)?.toInt(),
      questionId: (json['questionId'] as num?)?.toInt(),
      appUserId: (json['appUserId'] as num).toInt(),
      solutionId: (json['solutionId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'ownerId': instance.ownerId,
      'appUserId': instance.appUserId,
      'isViewed': instance.isViewed,
      'type': instance.type,
      'parentId': instance.parentId,
      'repliedId': instance.repliedId,
      'commentId': instance.commentId,
      'solutionId': instance.solutionId,
      'questionId': instance.questionId,
    };
