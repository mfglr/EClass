import 'package:flutter/material.dart';
import 'package:my_social_app/state/app_state/notification_entity_state.dart/notification_state.dart';
import 'package:my_social_app/views/notification/widgets/notification_item.dart';
import 'package:my_social_app/views/solution/pages/display_solution_page.dart';

class SolutionWasUpvotedNotificationItem extends StatelessWidget {
  final NotificationState notification;
  const SolutionWasUpvotedNotificationItem({
    super.key,
    required this.notification
  });

  @override
  Widget build(BuildContext context) {
    return NotificationItem(
      notification: notification,
      content: "Hey!!! Your solution has been upvoted!👍",
      icon: const Icon(
        Icons.thumb_up,
        color: Colors.green,
      ),
      onPressed: ()
        => Navigator
          .of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => DisplaySolutionPage(
                solutionId: notification.solutionId!
              )
            )
          )
    );
  }
}