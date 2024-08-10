import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:my_social_app/state/entity_state.dart';
import 'package:my_social_app/state/user_entity_state/user_state.dart';

@immutable
class UserEntityState extends EntityState<UserState>{
  const UserEntityState({required super.entities});

  UserEntityState addUser(UserState value)
    => UserEntityState(entities: appendOne(value));
  UserEntityState addUsers(Iterable<UserState> values)
    => UserEntityState(entities: appendMany(values));
  
  UserEntityState getNextPageFollowers(int userId)
    => UserEntityState(entities: updateOne(entities[userId]!.getNextPageFollowers()));
  UserEntityState addNextPageFollowers(int userId, Iterable<int> userIds)
    => UserEntityState(entities: updateOne(entities[userId]!.addNextPageFollowers(userIds)));

  UserEntityState getNextPageFolloweds(int userId)
    => UserEntityState(entities: updateOne(entities[userId]!.getNextPageFolloweds()));
  UserEntityState addNextPageFolloweds(int userId, Iterable<int> userIds)
    => UserEntityState(entities: updateOne(entities[userId]!.addNextPageFolloweds(userIds)));
  
  UserEntityState getNextPageQuestions(int userId)
    => UserEntityState(entities: updateOne(entities[userId]!.getNextPageQuestions()));
  UserEntityState addNextPageQuestions(int userId, Iterable<int> questions)
    => UserEntityState(entities: updateOne(entities[userId]!.addNextPageQuestions(questions)));
  UserEntityState addQuestion(int userId,int questionId)
    => UserEntityState(entities: updateOne(entities[userId]!.addQuestion(questionId)));

  UserEntityState loadUserImage(int userId, Uint8List image)
    => UserEntityState(entities: updateOne(entities[userId]!.loadUserImage(image)));

  UserEntityState makeFollowRequest(int currentUserId, int userId)
    => UserEntityState(entities: updateMany([
        entities[userId]!.addRequester(currentUserId),
        entities[currentUserId]!.addRequested(entities[userId]!.profileVisibility,userId)
    ]));
  UserEntityState cancelFollowRequest(int currentId, int userId)
    => UserEntityState(entities: updateMany([
      entities[userId]!.removeRequester(currentId),
      entities[currentId]!.removeRequested(entities[userId]!.profileVisibility, userId)
    ]));

  UserEntityState getNextPageMessages(int userId)
    => UserEntityState(entities: updateOne(entities[userId]!.nextPageMessages()));
  UserEntityState addNextPageMessages(int userId,Iterable<int> messageIds)
    => UserEntityState(entities: updateOne(entities[userId]!.addNextPageMessages(messageIds)));

  Iterable<UserState> getFollowers(int userId) => entities[userId]!.followers.ids.map((e) => entities[e]!);
  Iterable<UserState> getFolloweds(int userId) => entities[userId]!.followeds.ids.map((e) => entities[e]!);
}