import 'package:flutter/material.dart';
import 'package:my_social_app/state/app_state/notification_entity_state.dart/notification_state.dart';
import 'package:my_social_app/views/notification/widgets/notification_item.dart';
import 'package:my_social_app/views/user/pages/user_page.dart';

class UserFollowedNotificationItem extends StatelessWidget {
  final NotificationState notification;
  const UserFollowedNotificationItem({
    super.key,
    required this.notification
  });

  @override
  Widget build(BuildContext context) {
    return NotificationItem(
      notification: notification,
      content: "You have a new follower.",
      icon: const Icon(
        Icons.person_add,
        color: Colors.blue,
      ),
      onPressed: () => 
        Navigator
          .of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => UserPage(
                userId: notification.userId
              )
            )
          )
    );
  }
}