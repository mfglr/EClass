import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:my_social_app/models/user.dart';
import 'package:my_social_app/state/app_state/question_user_like_state/question_user_like_state.dart';
part 'question_user_like.g.dart';

@immutable
@JsonSerializable()
class QuestionUserLike{
  final int id;
  final int questionId;
  final int appUserId;
  final DateTime createdAt;
  final User? appUser;
  
  const QuestionUserLike({
    required this.id,
    required this.questionId,
    required this.appUserId,
    required this.createdAt,
    required this.appUser
  });

  factory QuestionUserLike.fromJson(Map<String, dynamic> json) => _$QuestionUserLikeFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionUserLikeToJson(this);


  QuestionUserLikeState toQuestionUserLikeState()
    => QuestionUserLikeState(
        id: id,
        questionId: questionId,
        appUserId: appUserId,
        createdAt: createdAt,
      );
  
}