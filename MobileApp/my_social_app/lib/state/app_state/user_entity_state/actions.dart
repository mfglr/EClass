import 'package:flutter/material.dart';
import 'package:my_social_app/state/app_state/actions.dart';
import 'package:my_social_app/state/app_state/user_entity_state/user_state.dart';

@immutable
class LoadUserAction extends AppAction{
  final int userId;
  const LoadUserAction({required this.userId});
}
@immutable
class LoadUserByUserNameAction extends AppAction{
  final String userName;
  const LoadUserByUserNameAction({required this.userName});
}
@immutable
class AddUserAction extends AppAction{
  final UserState user;
  const AddUserAction({required this.user});
}
@immutable
class AddUsersAction extends AppAction{
  final Iterable<UserState> users;
  const AddUsersAction({required this.users});
}


@immutable
class AddNewFollowerAction extends AppAction{
  final int curentUserId;
  final int followerId;
  final int followId;
  const AddNewFollowerAction({
    required this.curentUserId,
    required this.followerId,
    required this.followId
  });
}

@immutable
class FollowUserAction extends AppAction{
  final int followedId;
  const FollowUserAction({required this.followedId});
}
@immutable
class FollowUserSuccessAction extends AppAction{
  final int currentUserId;
  final int followedId;
  final int followId;
  const FollowUserSuccessAction({
    required this.currentUserId,
    required this.followedId,
    required this.followId
  });
}
@immutable
class UnfollowUserAction extends AppAction{
  final int followedId;
  const UnfollowUserAction({required this.followedId});
}
@immutable
class UnfollowUserSuccessAction extends AppAction{
  final int currentUserId;
  final int followedId;
  final int followId;
  const UnfollowUserSuccessAction({
    required this.currentUserId,
    required this.followedId,
    required this.followId
  });
}
@immutable
class RemoveFollowerAction extends AppAction{
  final int followerId;
  const RemoveFollowerAction({required this.followerId});
}
@immutable
class RemoveFollowerSuccessAction extends AppAction{
  final int currentUserId;
  final int followerId;
  final int followId;
  const RemoveFollowerSuccessAction({required this.currentUserId, required this.followerId, required this.followId});
}

@immutable
class GetNextPageUserFollowersIfNoPageAction extends AppAction{
  final int userId;
  const GetNextPageUserFollowersIfNoPageAction({required this.userId});
}
@immutable
class GetNextPageUserFollowersIfReadyAction extends AppAction{
  final int userId;
  const GetNextPageUserFollowersIfReadyAction({required this.userId});
}
@immutable
class GetNextPageUserFollowersAction extends AppAction{
  final int userId;
  const GetNextPageUserFollowersAction({required this.userId});
}
@immutable
class AddNextPageUserFollowersAction extends AppAction{
  final int userId;
  final Iterable<int> followIds;
  const AddNextPageUserFollowersAction({required this.userId, required this.followIds});
}

@immutable
class GetNextPageUserFollowedsIfNoPageAction extends AppAction{
  final int userId;
  const GetNextPageUserFollowedsIfNoPageAction({required this.userId});
}
@immutable
class GetNextPageUserFollowedsIfReadyAction extends AppAction{
  final int userId;
  const GetNextPageUserFollowedsIfReadyAction({required this.userId});
}
@immutable
class GetNextPageUserFollowedsAction extends AppAction{
  final int userId;
  const GetNextPageUserFollowedsAction({required this.userId});
}
@immutable
class AddNextPageUserFollowedsAction extends AppAction{
  final int userId;
  final Iterable<int> followIds;
  const AddNextPageUserFollowedsAction({required this.userId, required this.followIds});
}

@immutable
class GetNextPageUserNotFollowedsIfNoPageAction extends AppAction{
  final int userId;
  const GetNextPageUserNotFollowedsIfNoPageAction({required this.userId});
}
@immutable
class GetNextPageUserNotFollowedsIfReadyAction extends AppAction{
  final int userId;
  const GetNextPageUserNotFollowedsIfReadyAction({required this.userId});
}
@immutable
class GetNextPageUserNotFollowedsAction extends AppAction{
  final int userId;
  const GetNextPageUserNotFollowedsAction({required this.userId});
}
@immutable
class AddNextPageUserNotFollowedsAction extends AppAction{
  final int userId;
  final Iterable<int> userIds;
  const AddNextPageUserNotFollowedsAction({required this.userId, required this.userIds});
}
@immutable
class RemoveUserNotFollowedAction extends AppAction{
  final int userId;
  final int notFollowedId;
  const RemoveUserNotFollowedAction({required this.userId, required this.notFollowedId});
}
@immutable
class AddUserNotFollowedAction extends AppAction{
  final int userId;
  final int notFollowedId;
  const AddUserNotFollowedAction({required this.userId, required this.notFollowedId});
}

@immutable
class MarkUserQuestionAsSolvedAction extends AppAction{
  final int userId;
  final int questionId;
  const MarkUserQuestionAsSolvedAction({required this.userId, required this.questionId});
}
@immutable
class MarkUserQuestionAsUnsolvedAction extends AppAction{
  final int userId;
  final int questionId;
  const MarkUserQuestionAsUnsolvedAction({required this.userId, required this.questionId});
}

@immutable
class GetNextPageUserQuestionsIfNoPageAction extends AppAction{
  final int userId;
  const GetNextPageUserQuestionsIfNoPageAction({required this.userId});
}
@immutable
class GetNextPageUserQuestionsIfReadyAction extends AppAction{
  final int userId;
  const GetNextPageUserQuestionsIfReadyAction({required this.userId});
}
@immutable
class GetNextPageUserQuestionsAction extends AppAction{
  final int userId;
  const GetNextPageUserQuestionsAction({required this.userId});
}
@immutable
class AddNextPageUserQuestionsAction extends AppAction{
  final int userId;
  final Iterable<int> questionIds;
  const AddNextPageUserQuestionsAction({required this.userId,required this.questionIds});
}
@immutable
class AddNewUserQuestionAction extends AppAction{
  final int userId;
  final int questionId;
  const AddNewUserQuestionAction({required this.userId,required this.questionId});
}
@immutable
class RemoveUserQuestionAction extends AppAction{
  final int userId;
  final int questionId;
  const RemoveUserQuestionAction({required this.userId, required this.questionId});
}


@immutable
class GetNextPageUserSolvedQuestionsIfNoPageAction extends AppAction{
  final int userId;
  const GetNextPageUserSolvedQuestionsIfNoPageAction({required this.userId});
}
@immutable
class GetNextPageUserSolvedQuestionsIfReadyAction extends AppAction{
  final int userId;
  const GetNextPageUserSolvedQuestionsIfReadyAction({required this.userId});
}
@immutable
class GetNextPageUserSolvedQuestionsAction extends AppAction{
  final int userId;
  const GetNextPageUserSolvedQuestionsAction({required this.userId});
}
@immutable
class AddNextPageUserSolvedQuestionsAction extends AppAction{
  final int userId;
  final Iterable<int> questionIds;
  const AddNextPageUserSolvedQuestionsAction({required this.userId, required this.questionIds});
}

@immutable
class GetNextPageUserUnsolvedQuestionsIfNoPageAction extends AppAction{
  final int userId;
  const GetNextPageUserUnsolvedQuestionsIfNoPageAction({required this.userId});
}
@immutable
class GetNextPageUserUnsolvedQuestionsIfReadyAction extends AppAction{
  final int userId;
  const GetNextPageUserUnsolvedQuestionsIfReadyAction({required this.userId});
}
@immutable
class GetNextPageUserUnsolvedQuestionsAction extends AppAction{
  final int userId;
  const GetNextPageUserUnsolvedQuestionsAction({required this.userId});
}
@immutable
class AddNextPageUserUnsolvedQuestionsAction extends AppAction{
  final int userId;
  final Iterable<int> questionIds;
  const AddNextPageUserUnsolvedQuestionsAction({required this.userId, required this.questionIds});
}

@immutable
class GetNextPageUserSavedQuestionsIfNoPageAction extends AppAction{
  final int userId;
  const GetNextPageUserSavedQuestionsIfNoPageAction({required this.userId});
}
@immutable
class GetNextPageUserSavedQuestionsIfReadyAction extends AppAction{
  final int userId;
  const GetNextPageUserSavedQuestionsIfReadyAction({required this.userId});
}
@immutable
class GetNextPageUserSavedQuestionsAction extends AppAction{
  final int userId;
  const GetNextPageUserSavedQuestionsAction({required this.userId});
}
@immutable
class AddNextPageUserSavedQuestionsAction extends AppAction{
  final int userId;
  final Iterable<int> savedIds;
  const AddNextPageUserSavedQuestionsAction({required this.userId, required this.savedIds});
}
@immutable
class AddUserSavedQuestionAction extends AppAction{
  final int userId;
  final int saveId;
  const AddUserSavedQuestionAction({required this.userId, required this.saveId});
}
@immutable
class RemoveUserSavedQuestionAction extends AppAction{
  final int userId;
  final int saveId;
  const RemoveUserSavedQuestionAction({required this.userId,required this.saveId});
}

@immutable
class GetNextPageUserSavedSolutionsIfNoPageAction extends AppAction{
  final int userId;
  const GetNextPageUserSavedSolutionsIfNoPageAction({required this.userId});
}
@immutable
class GetNextPageUserSavedSolutionsIfReadyAction extends AppAction{
  final int userId;
  const GetNextPageUserSavedSolutionsIfReadyAction({required this.userId});
}
@immutable
class GetNextPageUserSavedSolutionsAction extends AppAction{
  final int userId;
  const GetNextPageUserSavedSolutionsAction({required this.userId});
}
@immutable
class AddNextPageUserSavedSolutionsAction extends AppAction{
  final int userId;
  final Iterable<int> savedIds;
  const AddNextPageUserSavedSolutionsAction({required this.userId, required this.savedIds});
}
@immutable
class AddUserSavedSolutionAction extends AppAction{
  final int userId;
  final int saveId;
  const AddUserSavedSolutionAction({required this.userId, required this.saveId});
}
@immutable
class RemoveUserSavedSolutionAction extends AppAction{
  final int userId;
  final int saveId;
  const RemoveUserSavedSolutionAction({required this.userId, required this.saveId});
}

@immutable
class GetNextPageUserMessagesIfNoPageAction extends AppAction{
  final int userId;
  const GetNextPageUserMessagesIfNoPageAction({required this.userId});
}
@immutable
class GetNextPageUserMessagesIfReadyAction extends AppAction{
  final int userId;
  const GetNextPageUserMessagesIfReadyAction({required this.userId});
}
@immutable
class GetNextPageUserMessagesAction extends AppAction{
  final int userId;
  const GetNextPageUserMessagesAction({required this.userId});
}
@immutable
class AddNextPageUserMessagesAction extends AppAction{
  final int userId;
  final Iterable<int> messageIds;
  const AddNextPageUserMessagesAction({required this.userId, required this.messageIds});
}
@immutable
class AddUserMessageAction extends AppAction{
  final int userId;
  final int messageId;
  const AddUserMessageAction({required this.userId, required this.messageId});
}
@immutable
class RemoveUserMessageAction extends AppAction{
  final int userId;
  final int messageId;
  const RemoveUserMessageAction({
    required this.userId,
    required this.messageId
  });
}
@immutable
class RemoveUserMessagesAction extends AppAction{
  final int userId;
  final Iterable<int> messageIds;
  const RemoveUserMessagesAction({required this.userId, required this.messageIds});
}


@immutable
class GetNextPageUserConversationIfNoPageAction extends AppAction{
  final int userId;
  const GetNextPageUserConversationIfNoPageAction({required this.userId});
}
@immutable
class GetNextPageUserConversationIfReadyAction extends AppAction{
  final int userId;
  const GetNextPageUserConversationIfReadyAction({required this.userId});
}
@immutable
class GetNextPageUserConversationAction extends AppAction{
  final int userId;
  const GetNextPageUserConversationAction({required this.userId});
}
@immutable
class AddNextPageUserConversationsAction extends AppAction{
  final int userId;
  final Iterable<int> ids;
  const AddNextPageUserConversationsAction({required this.userId,required this.ids});
}
@immutable
class AddUserConversationAction extends AppAction{
  final int userId;
  final int id;
  const AddUserConversationAction({required this.userId, required this.id});
}
@immutable
class AddUserConversationInOrderAction extends AppAction{
  final int userId;
  final int id;
  const AddUserConversationInOrderAction({required this.userId, required this.id});
}
@immutable
class RemoveUserConversationAction extends AppAction{
  final int userId;
  final int id;
  const RemoveUserConversationAction({required this.userId, required this.id});
}


@immutable
class ChangeProfileImageStatusAction extends AppAction{
  final int userId;
  final bool value;
  const ChangeProfileImageStatusAction({required this.userId, required this.value});
}
@immutable
class UpdateUserNameAction extends AppAction{
  final String userName;
  const UpdateUserNameAction({required this.userName});
}
@immutable
class UpdateUserNameSuccessAction extends AppAction{
  final int userId;
  final String userName;
  const UpdateUserNameSuccessAction({required this.userId,required this.userName});
}
@immutable
class UpdateNameAction extends AppAction{
  final String name;
  const UpdateNameAction({required this.name});
}
@immutable
class UpdateNameSuccessAction extends AppAction{
  final int userId;
  final String name;
  const UpdateNameSuccessAction({required this.userId, required this.name});
}
@immutable
class UpdateBiographyAction extends AppAction{
  final String biography;
  const UpdateBiographyAction({required this.biography});
}
@immutable
class UpdateBiographySuccessAction extends AppAction{
  final int userId;
  final String biography;
  const UpdateBiographySuccessAction({required this.userId, required this.biography});
}