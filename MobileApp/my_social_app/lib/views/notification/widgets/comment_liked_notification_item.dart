import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_social_app/state/comment_entity_state/actions.dart';
import 'package:my_social_app/state/comment_entity_state/comment_state.dart';
import 'package:my_social_app/state/notification_entity_state.dart/notification_state.dart';
import 'package:my_social_app/state/notification_entity_state.dart/parent_type.dart';
import 'package:my_social_app/state/state.dart';
import 'package:my_social_app/views/notification/widgets/notification_item.dart';
import 'package:my_social_app/views/question/pages/display_user_questions_page.dart';
import 'package:my_social_app/views/shared/loading_view.dart';
import 'package:my_social_app/views/solution/pages/display_solution_page.dart';

class CommentLikedNotificationItem extends StatelessWidget {
  final NotificationState notification;
  const CommentLikedNotificationItem({super.key,required this.notification});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,CommentState?>(
      onInit: (store) => store.dispatch(LoadCommentAction(commentId: notification.commentId!)),
      converter: (store) => store.state.commentEntityState.entities[notification.commentId!],
      builder: (context,comment){
        if(comment == null) return const LoadingView();
        return NotificationItem(
          notification: notification,
          content: "Your comment has been liked.",
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          onPressed: (){
            if(comment.questionId != null){
              Navigator
                .of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => DisplayUserQuestionsPage(
                      questionOffset: comment.questionId!,
                      userId: notification.ownerId,
                    )
                  )
                );
              return;
            }
            else if(comment.solutionId != null){
              Navigator
                .of(context)
                .push(MaterialPageRoute(builder: (context) => DisplaySolutionPage(solutionId: comment.solutionId!)));
              return;
            }
            else{
              if(notification.parentType == ParentType.question){
                Navigator
                  .of(context)
                  .push( MaterialPageRoute(
                    builder: (context) =>  DisplayUserQuestionsPage(
                      questionOffset: notification.parentId!,
                      userId: notification.ownerId,
                    )
                  ));
                return;
              }
              else{
                Navigator
                  .of(context)
                  .push(MaterialPageRoute(builder: (context) => DisplaySolutionPage(solutionId: notification.parentId!)));
                return;
              }
            }
          }
        );
      }
    );
  }
}