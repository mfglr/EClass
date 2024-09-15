import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_social_app/state/app_state/comment_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/comment_entity_state/comment_state.dart';
import 'package:my_social_app/state/app_state/notification_entity_state.dart/notification_state.dart';
import 'package:my_social_app/state/app_state/state.dart';
import 'package:my_social_app/views/notification/widgets/notification_bottom_text_content.dart';
import 'package:my_social_app/views/notification/widgets/notification_item.dart';
import 'package:my_social_app/views/shared/space_saving_widget.dart';
import 'package:my_social_app/views/solution/pages/display_solution_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SolutionCommentCreatedNotificationItem extends StatelessWidget {
  final NotificationState notification;
  const SolutionCommentCreatedNotificationItem({
    super.key,
    required this.notification
  });

  @override
  Widget build(BuildContext context) {
    return NotificationItem(
      notification: notification,
      content: AppLocalizations.of(context)!.solution_comment_created_notification_item_content,
       bottomContent: StoreConnector<AppState,CommentState?>(
        onInit: (store) => store.dispatch(LoadCommentAction(commentId: notification.commentId!)),
        converter: (store) => store.state.commentEntityState.entities[notification.commentId!],
        builder:(context,comment){
          if(comment == null) return const SpaceSavingWidget();
          return NotificationBottomTextContent(content: comment.content); 
        }
      ),
      icon: const Icon(
        Icons.comment,
        color: Colors.blue,
      ),
      onPressed: () => 
        Navigator
          .of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => DisplaySolutionPage(
                solutionId: notification.solutionId!,
                parentId: notification.commentId!,
              )
            )
          ),
    );
  }
}