import 'package:flutter/material.dart';
import 'package:my_social_app/models/message.dart';
import 'package:my_social_app/state/actions.dart' as redux;
import 'package:my_social_app/state/user_entity_state/user_state.dart';


@immutable
class LoadUserAction extends redux.Action{
  final int userId;
  const LoadUserAction({required this.userId});
}
@immutable
class LoadUserByUserNameAction extends redux.Action{
  final String userName;
  const LoadUserByUserNameAction({required this.userName});
}
@immutable
class LoadUserSuccessAction extends redux.Action{
  final UserState user;
  const LoadUserSuccessAction({required this.user});
}


@immutable
class AddUsersAction extends redux.Action{
  final Iterable<UserState> users;
  const AddUsersAction({required this.users});
}

@immutable
class GetNextPageUserFollowersIfNoPageAction extends redux.Action{
  final int userId;
  const GetNextPageUserFollowersIfNoPageAction({required this.userId});
}
@immutable
class GetNextPageUserFollowersIfReadyAction extends redux.Action{
  final int userId;
  const GetNextPageUserFollowersIfReadyAction({required this.userId});
}
@immutable
class GetNextPageUserFollowersAction extends redux.Action{
  final int userId;
  const GetNextPageUserFollowersAction({required this.userId});
}
@immutable
class AddNextPageUserFollowersAction extends redux.Action{
  final int userId;
  final Iterable<int> userIds;
  const AddNextPageUserFollowersAction({required this.userId, required this.userIds});
}

@immutable
class GetNextPageUserFollowedsIfNoPageAction extends redux.Action{
  final int userId;
  const GetNextPageUserFollowedsIfNoPageAction({required this.userId});
}
@immutable
class GetNextPageUserFollowedsIfReadyAction extends redux.Action{
  final int userId;
  const GetNextPageUserFollowedsIfReadyAction({required this.userId});
}
@immutable
class GetNextPageUserFollowedsAction extends redux.Action{
  final int userId;
  const GetNextPageUserFollowedsAction({required this.userId});
}
@immutable
class AddNextPageUserFollowedsAction extends redux.Action{
  final int userId;
  final Iterable<int> userIds;
  const AddNextPageUserFollowedsAction({required this.userId, required this.userIds});
}

@immutable
class MakeFollowRequestAction extends redux.Action{
  final int userId;
  const MakeFollowRequestAction({required this.userId});
}
@immutable
class MakeFollowRequestSuccessAction extends redux.Action{
  final int currentUserId;
  final int userId;
  const MakeFollowRequestSuccessAction({required this.currentUserId, required this.userId});
}

@immutable
class CancelFollowRequestAction extends redux.Action{
  final int userId;
  const CancelFollowRequestAction({required this.userId});
}
@immutable
class CancelFollowRequestSuccessAction extends redux.Action{
  final int currentUserId;
  final int userId;
  const CancelFollowRequestSuccessAction({required this.currentUserId,required this.userId});
}

@immutable
class GetNextPageUserQuestionsIfNoPageAction extends redux.Action{
  final int userId;
  const GetNextPageUserQuestionsIfNoPageAction({required this.userId});
}
@immutable
class GetNextPageUserQuestionsIfReadyAction extends redux.Action{
  final int userId;
  const GetNextPageUserQuestionsIfReadyAction({required this.userId});
}
@immutable
class GetNextPageUserQuestionsAction extends redux.Action{
  final int userId;
  const GetNextPageUserQuestionsAction({required this.userId});
}
@immutable
class AddNextPageUserQuestionsAction extends redux.Action{
  final int userId;
  final Iterable<int> userIds;
  const AddNextPageUserQuestionsAction({required this.userId,required this.userIds});
}
@immutable
class AddUserQuestionAction extends redux.Action{
  final int userId;
  final int questionId;
  const AddUserQuestionAction({required this.userId,required this.questionId});
}

@immutable
class NextPageUserMessagesAction extends redux.Action{
  final int userId;
  const NextPageUserMessagesAction({required this.userId});
}
@immutable
class NextPageUserMessagesSuccessAction extends redux.Action{
  final int userId;
  final Iterable<Message> messages;
  const NextPageUserMessagesSuccessAction({required this.userId, required this.messages});
}
@immutable
class NextPageUserMessagesIfNoMessagesAction extends redux.Action{
  final int userId;
  const NextPageUserMessagesIfNoMessagesAction({required this.userId});
}