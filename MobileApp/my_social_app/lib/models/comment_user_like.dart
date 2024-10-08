import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:my_social_app/models/user.dart';
import 'package:my_social_app/state/app_state/comment_user_like_state/comment_user_like_state.dart';
part 'comment_user_like.g.dart';

@immutable
@JsonSerializable()
class CommentUserLike{
  final int id;
  final int commentId;
  final int appUserId;
  final DateTime createdAt;
  final User? appUser;
  
  const CommentUserLike({
    required this.id,
    required this.commentId,
    required this.appUserId,
    required this.createdAt,
    required this.appUser
  });


  factory CommentUserLike.fromJson(Map<String, dynamic> json) => _$CommentUserLikeFromJson(json);
  Map<String, dynamic> toJson() => _$CommentUserLikeToJson(this);

  CommentUserLikeState toCommentUserLikeState()
    => CommentUserLikeState(
        id: id,
        appUserId: appUserId,
        commentId: commentId,
        createdAt: createdAt,
      );

}