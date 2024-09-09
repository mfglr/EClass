import 'package:my_social_app/services/message_hub.dart';
import 'package:my_social_app/services/message_service.dart';
import 'package:my_social_app/state/app_state/image_status.dart';
import 'package:my_social_app/state/app_state/message_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/state.dart';
import 'package:my_social_app/state/app_state/user_image_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/user_image_entity_state/user_image_state.dart';
import 'package:redux/redux.dart';

void getUnviewedMessagesMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetUnviewedMessagesAction){
    MessageService()
      .getUnviewedMessages()
      .then((messages){
        store.dispatch(AddMessagesAction(messages: messages.map((e) => e.toMessageState())));
        store.dispatch(AddUserImagesAction(images: messages.map((e) => UserImageState.init(e.conversationId))));
        store.dispatch(const MarkComingMessagesAsReceivedAction());
      });
  }
  next(action);
}

void markComingMessageAsReceivedMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is MarkComingMessageAsReceivedAction){
    final messageIds = [action.messageId];
    MessageHub()
      .markMessagesAsReceived(messageIds)
      .then((_) => store.dispatch(MarkComingMessagesAsReceivedSuccessAction(messageIds: messageIds)));
  }
  next(action);
}
void markComingMessageAsViewedMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is MarkComingMessageAsViewedAction){
    final messageIds = [action.messageId];
    MessageHub()
      .markMessagesAsViewed(messageIds)
      .then((_) => store.dispatch(MarkComingMessagesAsViewedSuccessAction(messageIds: messageIds)));
  }
  next(action);
}
void markComingMessagesAsReceivedMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is MarkComingMessagesAsReceivedAction){
    final messageIds = store.state.selectIdsOfNewComingMessages;
    if(messageIds.isNotEmpty){
      MessageHub()
        .markMessagesAsReceived(messageIds)
        .then((_) => store.dispatch(MarkComingMessagesAsReceivedSuccessAction(messageIds: messageIds)));
    }
  }
  next(action);
}
void markComingMessagesAsViewedMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is MarkComingMessagesAsViewedAction){
    final messageIds = store.state.messageEntityState.selectIdsOfUnviewedMessagesOfUser(action.userId);
    if(messageIds.isNotEmpty){
      MessageHub()
      .markMessagesAsViewed(messageIds)
      .then((_) => store.dispatch(MarkComingMessagesAsViewedSuccessAction(messageIds: messageIds)));
    }    
  }
  next(action);
}

void loadMessageImageMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is LoadMessageImageAction){
    final image = store.state.messageEntityState.entities[action.messageId]!.images.elementAt(action.index);
    if(image.status == ImageStatus.notStarted){
      MessageService()
        .getMessageImage(action.messageId, action.index)
        .then(
          (image) => store.dispatch(
            LoadMessageImageSuccessAction(
              messageId: action.messageId,
              index: action.index,
              image: image
            )
          )
        );
    }
  }
  next(action);
}