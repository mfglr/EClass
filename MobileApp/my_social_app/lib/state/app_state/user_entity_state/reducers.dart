import 'package:my_social_app/state/app_state/user_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/user_entity_state/user_entity_state.dart';
import 'package:redux/redux.dart';


UserEntityState markQuestionAsSolvedReducer(UserEntityState prev,MarkUserQuestionAsSolvedAction action)
  => prev.markQuestionAsSolved(action.userId, action.questionId);
UserEntityState markQuestionAsUnsolvedReducer(UserEntityState prev,MarkUserQuestionAsUnsolvedAction action)
  => prev.markQuestionAsUnsolved(action.userId, action.questionId);

//questions
UserEntityState getNextPageQuestionsReducer(UserEntityState prev,GetNextPageUserQuestionsAction action)
  => prev.getNextPageQuestions(action.userId);
UserEntityState addNextPageQuestionsReducer(UserEntityState prev,AddNextPageUserQuestionsAction action)
  => prev.addNextPageQuestions(action.userId,action.questionIds);
UserEntityState addNewQuestionReducer(UserEntityState prev, AddNewUserQuestionAction action)
  => prev.addNewQuestion(action.userId, action.questionId);

//solved questions
UserEntityState getNextPageSolvedQuestionsReducer(UserEntityState prev, GetNextPageUserSolvedQuestionsAction action) 
  => prev.getNextPageSolvedQuestions(action.userId);
UserEntityState addNextPageSolvedQuestionsReducer(UserEntityState prev, AddNextPageUserSolvedQuestionsAction action)
  => prev.addNextPageSolvedQuestions(action.userId,action.questionIds);

//unsolved questions
UserEntityState getNextPageUnsolvedQuestionsReducer(UserEntityState prev, GetNextPageUserUnsolvedQuestionsAction action)
  => prev.getNextPageUnsolvedQuestions(action.userId);
UserEntityState addNextPageUnsolvedQuestionsReducer(UserEntityState prev, AddNextPageUserUnsolvedQuestionsAction action)
  => prev.addNextPageUnsolvedQuestions(action.userId, action.questionIds);

//followers
UserEntityState getNextPageFollowers(UserEntityState prev,GetNextPageUserFollowersAction action)
  => prev.getNextPageFollowers(action.userId);
UserEntityState addNextPageFollowers(UserEntityState prev,AddNextPageUserFollowersAction action)
  => prev.addNextPageFollowers(action.userId,action.followIds);
UserEntityState addFollowerReducer(UserEntityState prev, AddUserFollowerAction action)
  => prev.addFollower(action.userId, action.followId);
UserEntityState removeFollowerReducer(UserEntityState prev, RemoveUserFollowerAction action)
  => prev.removeFollower(action.userId,action.followId);

//followeds
UserEntityState getNextPageFollowedsReducer(UserEntityState prev,GetNextPageUserFollowedsAction action)
  => prev.getNextPageFolloweds(action.userId);
UserEntityState addNextPageFollowedsReducer(UserEntityState prev,AddNextPageUserFollowedsAction action)
  => prev.addNextPageFolloweds(action.userId,action.followIds);
UserEntityState addFollowedReducer(UserEntityState prev,AddUserFollowedAction action)
  => prev.addFollowed(action.userId, action.followId);
UserEntityState removeFollowedReducer(UserEntityState prev,RemoveUserFollowedAction action)
  => prev.removeFollowed(action.userId,action.followId);

// not followeds
UserEntityState getNextPageNotFollowedsReducer(UserEntityState prev,GetNextPageUserNotFollowedsAction action)
  => prev.getNextPageNotFolloweds(action.userId);
UserEntityState addNextPageNotFollowedsReducer(UserEntityState prev,AddNextPageUserNotFollowedsAction action)
  => prev.addNextPageNotFolloweds(action.userId, action.userIds);
UserEntityState addNotFollowedReducer(UserEntityState prev,AddUserNotFollowedAction action)
  => prev.addNotFollowed(action.userId,action.notFollowedId);
UserEntityState removeNotFollowedReducer(UserEntityState prev,RemoveUserNotFollowedAction action)
  => prev.removeNotFollowed(action.userId,action.notFollowedId);

//messages
UserEntityState addMessageReducer(UserEntityState prev,AddUserMessageAction action)
  => prev.addMessage(action.userId, action.messageId);
UserEntityState getNextPageMessagesReducer(UserEntityState prev,GetNextPageUserMessagesAction action)
  => prev.getNextPageMessages(action.userId);
UserEntityState addNextPageUserMessagesReducer(UserEntityState prev,AddNextPageUserMessagesAction action)
  => prev.addNextPageMessages(action.userId, action.messageIds);

UserEntityState loadUserReducer(UserEntityState prev,AddUserAction action)
  => prev.addUser(action.user);
UserEntityState addUsersReducer(UserEntityState prev,AddUsersAction action)
  => prev.addUsers(action.users);

UserEntityState changeProfileImageStatusReducer(UserEntityState prev,ChangeProfileImageStatusAction action)
  => prev.changeProfileImageStatus(action.userId,action.value);
UserEntityState updateUserNameReducer(UserEntityState prev,UpdateUserNameSuccessAction action)
  => prev.updateUserName(action.userId, action.userName);
UserEntityState updateNameReducer(UserEntityState prev,UpdateNameSuccessAction action)
  => prev.updateName(action.userId, action.name);

Reducer<UserEntityState> userEntityStateReducers = combineReducers<UserEntityState>([
  //
  TypedReducer<UserEntityState,MarkUserQuestionAsSolvedAction>(markQuestionAsSolvedReducer).call,
  TypedReducer<UserEntityState,MarkUserQuestionAsUnsolvedAction>(markQuestionAsUnsolvedReducer).call,
  
  //questions
  TypedReducer<UserEntityState,GetNextPageUserQuestionsAction>(getNextPageQuestionsReducer).call,
  TypedReducer<UserEntityState,AddNextPageUserQuestionsAction>(addNextPageQuestionsReducer).call,
  TypedReducer<UserEntityState,AddNewUserQuestionAction>(addNewQuestionReducer).call,

  //solved questions
  TypedReducer<UserEntityState,GetNextPageUserSolvedQuestionsAction>(getNextPageSolvedQuestionsReducer).call,
  TypedReducer<UserEntityState,AddNextPageUserSolvedQuestionsAction>(addNextPageSolvedQuestionsReducer).call,

  //unsolved questions
  TypedReducer<UserEntityState,GetNextPageUserUnsolvedQuestionsAction>(getNextPageUnsolvedQuestionsReducer).call,
  TypedReducer<UserEntityState,AddNextPageUserUnsolvedQuestionsAction>(addNextPageUnsolvedQuestionsReducer).call,

  //followers
  TypedReducer<UserEntityState,GetNextPageUserFollowersAction>(getNextPageFollowers).call,
  TypedReducer<UserEntityState,AddNextPageUserFollowersAction>(addNextPageFollowers).call,
  TypedReducer<UserEntityState,AddUserFollowerAction>(addFollowerReducer).call,
  TypedReducer<UserEntityState,RemoveUserFollowerAction>(removeFollowerReducer).call,

  //followeds
  TypedReducer<UserEntityState,GetNextPageUserFollowedsAction>(getNextPageFollowedsReducer).call,
  TypedReducer<UserEntityState,AddNextPageUserFollowedsAction>(addNextPageFollowedsReducer).call,
  TypedReducer<UserEntityState,AddUserFollowedAction>(addFollowedReducer).call,
  TypedReducer<UserEntityState,RemoveUserFollowedAction>(removeFollowedReducer).call,

  //not followeds
  TypedReducer<UserEntityState,GetNextPageUserNotFollowedsAction>(getNextPageNotFollowedsReducer).call,
  TypedReducer<UserEntityState,AddNextPageUserNotFollowedsAction>(addNextPageNotFollowedsReducer).call,
  TypedReducer<UserEntityState,RemoveUserNotFollowedAction>(removeNotFollowedReducer).call,
  TypedReducer<UserEntityState,AddUserNotFollowedAction>(addNotFollowedReducer).call,

  TypedReducer<UserEntityState,AddUserMessageAction>(addMessageReducer).call,
  TypedReducer<UserEntityState,GetNextPageUserMessagesAction>(getNextPageMessagesReducer).call,
  TypedReducer<UserEntityState,AddNextPageUserMessagesAction>(addNextPageUserMessagesReducer).call,

  TypedReducer<UserEntityState,AddUserAction>(loadUserReducer).call,
  TypedReducer<UserEntityState,AddUsersAction>(addUsersReducer).call,

  TypedReducer<UserEntityState,ChangeProfileImageStatusAction>(changeProfileImageStatusReducer).call,
  TypedReducer<UserEntityState,UpdateUserNameSuccessAction>(updateUserNameReducer).call,
  TypedReducer<UserEntityState,UpdateNameSuccessAction>(updateNameReducer).call,
]);