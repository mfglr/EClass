import 'package:my_social_app/services/message_hub.dart';
import 'package:my_social_app/services/message_service.dart';
import 'package:my_social_app/state/app_state/create_message_state/actions.dart';
import 'package:my_social_app/state/app_state/message_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/message_image_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/message_image_entity_state/message_image_state.dart';
import 'package:my_social_app/state/app_state/state.dart';
import 'package:my_social_app/state/app_state/user_entity_state/actions.dart';
import 'package:redux/redux.dart';

void createMessageWithImagesMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is CreateMessageWithImagesAction){
    final state = store.state.createMessageState;
    MessageService()
      .createMessage(state.receiverId!, state.content, state.images)
      .then((message){
        store.dispatch(AddMessageAction(message: message.toMessageState()));
        store.dispatch(AddMessageImagesAction(images: List.generate(
          message.numberOfImages, (index) => MessageImageState.init(message.id, index))
        ));
        store.dispatch(AddUserMessageAction(userId: state.receiverId!,messageId: message.id));
      });
  }
  next(action);
}

void createMessageMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is CreateMessageAction){
    final state = store.state.createMessageState;
    MessageHub()
      .createMessage(state.receiverId!, state.content!)
      .then((message){
        store.dispatch(AddMessageAction(message: message.toMessageState()));
        store.dispatch(AddUserMessageAction(userId: state.receiverId!,messageId: message.id));
      });
  }
  next(action);
}