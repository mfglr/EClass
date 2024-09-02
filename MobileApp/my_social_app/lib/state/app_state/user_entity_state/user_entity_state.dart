import 'package:flutter/material.dart';
import 'package:my_social_app/state/entity_state/entity_state.dart';
import 'package:my_social_app/state/app_state/user_entity_state/user_state.dart';

@immutable
class UserEntityState extends EntityState<UserState>{
  const UserEntityState({required super.entities});

  UserEntityState addUser(UserState value)
    => UserEntityState(entities: appendOne(value));
  UserEntityState addUsers(Iterable<UserState> values)
    => UserEntityState(entities: appendMany(values));
  
  //followers
  UserEntityState getNextPageFollowers(int userId)
    => UserEntityState(entities: updateOne(entities[userId]?.getNextPageFollowers()));
  UserEntityState addNextPageFollowers(int userId, Iterable<int> followIds)
    => UserEntityState(entities: updateOne(entities[userId]?.addNextPageFollowers(followIds)));
  UserEntityState addFollower(int userId, int followId)
    => UserEntityState(entities: updateOne(entities[userId]?.addFollower(followId)));
  UserEntityState removeFollower(int userId, int followId)
    => UserEntityState(entities: updateOne(entities[userId]?.removeFollower(followId)));

  //foloweds
  UserEntityState getNextPageFolloweds(int userId)
    => UserEntityState(entities: updateOne(entities[userId]?.getNextPageFolloweds()));
  UserEntityState addNextPageFolloweds(int userId, Iterable<int> ids)
    => UserEntityState(entities: updateOne(entities[userId]?.addNextPageFolloweds(ids)));
  UserEntityState addFollowed(int userId,int id)
    => UserEntityState(entities: updateOne(entities[userId]?.addFollowed(id)));
  UserEntityState removeFollowed(int userId,int id)
    => UserEntityState(entities: updateOne(entities[userId]?.removeFollowed(id)));

  //not followeds
  UserEntityState getNextPageNotFolloweds(int userId)
    => UserEntityState(entities: updateOne(entities[userId]?.getNextPageNotFolloweds()));
  UserEntityState addNextPageNotFolloweds(int userId,Iterable<int> ids)
    => UserEntityState(entities: updateOne(entities[userId]?.addNextPageNotFolloweds(ids)));
  UserEntityState addNotFollowed(int userId,int id)
    => UserEntityState(entities: updateOne(entities[userId]?.addNotFollowed(id)));
  UserEntityState removeNotFollowed(int userId,int id)
    => UserEntityState(entities: updateOne(entities[userId]?.removeNotFollowed(id)));

  //
  UserEntityState markQuestionAsSolved(int userId,int id)
    => UserEntityState(entities: updateOne(entities[userId]?.markQuestionAsSolved(id)));
  UserEntityState markQuestionAsUnsolved(int userId,int id)
    => UserEntityState(entities: updateOne(entities[userId]?.markQuestionAsUnsolved(id)));

  //questions
  UserEntityState getNextPageQuestions(int userId)
    => UserEntityState(entities: updateOne(entities[userId]?.getNextPageQuestions()));
  UserEntityState addNextPageQuestions(int userId, Iterable<int> ids)
    => UserEntityState(entities: updateOne(entities[userId]?.addNextPageQuestions(ids)));
  UserEntityState addNewQuestion(int userId,int id)
    => UserEntityState(entities: updateOne(entities[userId]?.addNewQuestion(id)));
  
  //solved questions
  UserEntityState getNextPageSolvedQuestions(int userId)
    => UserEntityState(entities: updateOne(entities[userId]?.getNextPageSolvedQuestions()));
  UserEntityState addNextPageSolvedQuestions(int userId, Iterable<int> ids)
    => UserEntityState(entities: updateOne(entities[userId]?.addNextPageSolvedQuestions(ids)));
  
  //unsolved questions
  UserEntityState getNextPageUnsolvedQuestions(int userId)
    => UserEntityState(entities: updateOne(entities[userId]?.getNextPageUnsolvedQuestions()));
  UserEntityState addNextPageUnsolvedQuestions(int userId,Iterable<int> ids)
    => UserEntityState(entities: updateOne(entities[userId]?.addNextPageUnsolvedQuestions(ids)));
  

  //messages
  UserEntityState getNextPageMessages(int userId)
    => UserEntityState(entities: updateOne(entities[userId]?.nextPageMessages()));
  UserEntityState addNextPageMessages(int userId,Iterable<int> ids)
    => UserEntityState(entities: updateOne(entities[userId]?.addNextPageMessages(ids)));
  UserEntityState addMessage(int userId,int id)
    => UserEntityState(entities: updateOne(entities[userId]?.addMessage(id)));
  

  UserEntityState changeProfileImageStatus(int userId,bool value)
    => UserEntityState(entities: updateOne(entities[userId]!.changeProfileImageStatus(value)));

  UserEntityState updateUserName(int userId,String userName)
    => UserEntityState(entities: updateOne(entities[userId]!.updateUserName(userName)));

  UserEntityState updateName(int userId,String name)
    => UserEntityState(entities: updateOne(entities[userId]!.updateName(name)));
}