import 'package:flutter/material.dart';
import 'package:my_social_app/state/app_state/user_entity_state/followed_state.dart';
import 'package:my_social_app/state/app_state/user_entity_state/follower_state.dart';
import 'package:my_social_app/state/pagination/id_state.dart';
import 'package:my_social_app/state/pagination/pagination.dart';
import 'package:my_social_app/state/app_state/user_entity_state/gender.dart';

@immutable
class UserState{
  final int id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String userName;
  final String? name;
  final DateTime? birthDate;
  final bool hasImage;
  final Gender gender;
  final int numberOfQuestions;
  final int numberOfFollowers;
  final int numberOfFolloweds;
  final bool isFollower;
  final bool isFollowed;
  final Pagination<num,FollowerState> followers;
  final Pagination<num,FollowedState> followeds;
  final Pagination<num,IdState> notFolloweds;
  final Pagination<num,IdState> questions;
  final Pagination<num,IdState> solvedQuestions;
  final Pagination<num,IdState> unsolvedQuestions;
  final Pagination<num,IdState> messages;

  String formatName(int count){
    final r = (name ?? userName);
    return r.length <= count ? r : "${r.substring(0,count)}...";
  }

  String formatUserName({int count = 15}){
    return userName.length <= count ? userName : "${userName.substring(0,count)}...";
  }

  const UserState({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userName,
    required this.hasImage,
    required this.name,
    required this.birthDate,
    required this.gender,
    required this.numberOfQuestions,
    required this.numberOfFollowers,
    required this.numberOfFolloweds,
    required this.isFollower,
    required this.isFollowed,
    required this.followers,
    required this.followeds,
    required this.questions,
    required this.solvedQuestions,
    required this.unsolvedQuestions,
    required this.messages,
    required this.notFolloweds
  });

  UserState _optional({
    DateTime? newUpdatedDate,
    String? newUserName,
    String? newName,
    DateTime? newBirthDate,
    bool? newHasImage,
    Gender? newGender,
    int? newNumberOfQuestions,
    int? newNumberOfFollowers,
    int? newNumberOfFolloweds,
    bool? newIsFollower,
    bool? newIsFollowed,
    Pagination<num,FollowerState>? newFollowers,
    Pagination<num,FollowedState>? newFolloweds,
    Pagination<num,IdState>? newQuestions,
    Pagination<num,IdState>? newSolvedQuestions,
    Pagination<num,IdState>? newUnsolvedQuestions,
    Pagination<num,IdState>? newMessages,
    Pagination<num,IdState>? newNotFolloweds
  }) => UserState(
    id: id,
    createdAt: createdAt,
    updatedAt: newUpdatedDate ?? updatedAt,
    userName: newUserName ?? userName,
    name: newName ?? name,
    birthDate: newBirthDate ?? birthDate,
    hasImage: newHasImage ?? hasImage,
    gender: newGender ?? gender,
    numberOfQuestions: newNumberOfQuestions ?? numberOfQuestions,
    numberOfFollowers: newNumberOfFollowers ?? numberOfFollowers,
    numberOfFolloweds: newNumberOfFolloweds ?? numberOfFolloweds,
    isFollower: newIsFollower ?? isFollower,
    isFollowed: newIsFollowed ?? isFollowed,
    followers: newFollowers ?? followers,
    followeds: newFolloweds ?? followeds,
    questions: newQuestions ?? questions,
    solvedQuestions: newSolvedQuestions ?? solvedQuestions,
    unsolvedQuestions: newUnsolvedQuestions ?? unsolvedQuestions,
    messages: newMessages ?? messages,
    notFolloweds: newNotFolloweds ?? notFolloweds
  );
  
  //followers
  UserState getNextPageFollowers() => 
    _optional(
      newFollowers: followers.startLoadingNext()
    );
  UserState addNextPageFollowers(Iterable<FollowerState> followers) => 
    _optional(
      newFollowers: this.followers.addNextPage(followers)
    );
  UserState addFollower(FollowerState follower) => 
    _optional(
      newNumberOfFollowers: numberOfFollowers + 1,
      newIsFollowed:true,
      newFollowers: followers.prependOne(follower)
    );
  UserState removeFollower(int followerId) => 
    _optional(
      newNumberOfFollowers:numberOfFollowers - 1,
      newIsFollowed:false,
      newFollowers: followers.where((e) => e.followerId != followerId)
    );
  
  //followeds
  UserState getNextPageFolloweds() =>
    _optional(
      newFolloweds: followeds.startLoadingNext()
    );
  UserState addNextPageFolloweds(Iterable<FollowedState> followeds) =>
    _optional(
      newFolloweds: this.followeds.addNextPage(followeds)
    );
  UserState addFollowed(FollowedState followed)
    => _optional(
        newNumberOfFolloweds: numberOfFolloweds + 1,
        newFolloweds: followeds.prependOne(followed)
      );
  UserState removeFollowed(int followedId)
    => _optional(
        newNumberOfFolloweds: numberOfFolloweds - 1,
        newIsFollower:false,
        newFolloweds: followeds.where((e) => e.followedId != followedId)
      );

  //not followeds
  UserState getNextPageNotFolloweds() =>
    _optional(
      newNotFolloweds: notFolloweds.startLoadingNext()
    );
  UserState addNextPageNotFolloweds(Iterable<IdState> ids) =>
    _optional(
      newNotFolloweds: notFolloweds.addNextPage(ids)
    );
  UserState addNotFollowed(IdState id) =>
    _optional(
      newNotFolloweds: notFolloweds.prependOne(id)
    );
  UserState removeNotFollowed(IdState id) =>
    _optional(
      newNotFolloweds: notFolloweds.removeOne(id)
    );

  //questions
  UserState getNextPageQuestions() =>
    _optional(
      newQuestions: questions.startLoadingNext()
    );
  UserState addNextPageQuestions(Iterable<IdState> ids) =>
    _optional(
      newQuestions: questions.addNextPage(ids)
    );
  UserState addNewQuestion(IdState id) =>
    _optional(
      newNumberOfQuestions: numberOfQuestions + 1,
      newQuestions: questions.prependOne(id),
      newUnsolvedQuestions: unsolvedQuestions.prependOne(id)
    );
  
  //solved questions
  UserState getNextPageSolvedQuestions() =>
    _optional(
      newSolvedQuestions: solvedQuestions.startLoadingNext()
    );
  UserState addNextPageSolvedQuestions(Iterable<IdState> ids) =>
    _optional(
      newSolvedQuestions: solvedQuestions.addNextPage(ids)
    );

  //unsolved questions
  UserState getNextPageUnsolvedQuestions() =>
    _optional(
      newUnsolvedQuestions: unsolvedQuestions.startLoadingNext()
    );
  UserState addNextPageUnsolvedQuestions(Iterable<IdState> ids) =>
    _optional(
      newUnsolvedQuestions: unsolvedQuestions.addNextPage(ids)
    );
  
  UserState markQuestionAsSolved(IdState id) =>
    _optional(
      newSolvedQuestions: solvedQuestions.props.any((e) => e == id) ? solvedQuestions : solvedQuestions.addInOrder(id),
      newUnsolvedQuestions: unsolvedQuestions.removeOne(id)
    );
  UserState markQuestionAsUnsolved(IdState id) =>
    _optional(
      newSolvedQuestions: solvedQuestions.removeOne(id),
      newUnsolvedQuestions: unsolvedQuestions.addInOrder(id),
    );

  //messages
  UserState nextPageMessages() =>
    _optional(
      newMessages: messages.startLoadingNext()
    );
  UserState addNextPageMessages(Iterable<IdState> ids) =>
    _optional(
      newMessages: messages.addPrevPage(ids)
    );
  UserState addMessage(IdState id) =>
    _optional(
      newMessages: messages.appendOne(id)
    );

  UserState changeProfileImageStatus(bool value) =>
    _optional(
      newHasImage: value
    );
  UserState updateUserName(String userName) =>
    _optional(
      newUserName: userName
    );
  UserState updateName(String name) =>
    _optional(
      newName: name == "" ? null : name
    );
}