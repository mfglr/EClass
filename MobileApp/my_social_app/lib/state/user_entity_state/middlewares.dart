import 'package:my_social_app/services/user_service.dart';
import 'package:my_social_app/state/image_state.dart';
import 'package:my_social_app/state/state.dart';
import 'package:my_social_app/state/user_entity_state/actions.dart';
import 'package:my_social_app/state/user_entity_state/user_state.dart';
import 'package:redux/redux.dart';

void loadUserMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is LoadUserAction){
    if(store.state.userEntityState.users[action.userId] == null){
      UserService()
        .getById(action.userId)
        .then((user) => store.dispatch(UserSuccessfullyLoadedAction(payload: UserState.init(user))));
    }
  }
  next(action);
}

void loadFollowersIfNoUsersMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is LoadFollowersIfNoUsersAction){
    final user = store.state.userEntityState.users[action.userId]!;
    if(!user.followers.isLast && user.followers.ids.isEmpty){
      final lastId = user.followers.lastId;
      UserService()
        .getFollowersById(action.userId,lastId: lastId)
        .then((users) => store.dispatch(
          FollowersSuccessfullyLoadedAction(
            userId: action.userId,
            payload:users.map((user) => UserState.init(user)).toList()
          )
        ));
    }
  }
  next(action);
}
void loadFollowersMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is LoadFollowersAction){
    if(!store.state.userEntityState.users[action.userId]!.followers.isLast){
      final lastId = store.state.userEntityState.users[action.userId]!.followers.lastId;
      UserService()
        .getFollowersById(action.userId,lastId: lastId)
        .then((users) => store.dispatch(
          FollowersSuccessfullyLoadedAction(
            userId: action.userId,
            payload:users.map((user) => UserState.init(user)).toList()
          )
        ));
    }
  }
  next(action);
}

void loadFollowedsIfNoUsersMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is LoadFollowedsIfNoUsersAction){
    final user = store.state.userEntityState.users[action.userId]!;
    if(!user.followeds.isLast && user.followeds.ids.isEmpty){
      final lastId = user.followeds.lastId;
      UserService()
        .getFollowedsById(action.userId,lastId: lastId)
        .then((users) => store.dispatch(
          FollowedsSuccessfullyLoadedAction(
            userId: action.userId,
            payload:users.map((user) => UserState.init(user)).toList()
          )
        ));
    }
  }
  next(action);
}
void loadFollowedsMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is LoadFollowersAction){
    if(!store.state.userEntityState.users[action.userId]!.followeds.isLast){
      final lastId = store.state.userEntityState.users[action.userId]!.followers.lastId;
      UserService()
        .getFollowedsById(action.userId,lastId: lastId)
        .then((users) => store.dispatch(
          FollowedsSuccessfullyLoadedAction(
            userId: action.userId,
            payload:users.map((user) => UserState.init(user)).toList()
          )
        ));
    }
  }
  next(action);
}

void loadUserImageMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is LoadUserImageAction){
    if(store.state.userEntityState.users[action.userId]!.imageState == ImageState.notStarted){
      UserService()
        .getImageById(action.userId)
        .then((image) => store.dispatch(UserImageSuccessfullyloadedAction(userId: action.userId, paylaod: image)));
    }
  }
  next(action);
}

void makeFollowRequestMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is MakeFollowRequestAction){
    final currentUserId = store.state.accountState!.id;
    UserService()
      .makeFollowRequest(action.userId)
      .then((_) => store.dispatch(FollowRequestSuccessfullyIsMadeAction(currentUserId: currentUserId, userId: action.userId)));
  }
  next(action);
}

void cancelFollowRequestMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is CancelFollowRequestAction){
    final currentUserId = store.state.accountState!.id;
    UserService()
      .cancelFollowRequest(action.userId)
      .then((_) => store.dispatch(FollowRequestSuccessfullyCancelledAction(currentUserId: currentUserId, userId: action.userId)));
  }
  next(action);
}