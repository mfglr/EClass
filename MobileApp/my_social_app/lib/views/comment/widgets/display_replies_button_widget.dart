import 'package:flutter/material.dart';
import 'package:my_social_app/constants/comment_font_size.dart';
import 'package:my_social_app/state/app_state/comment_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/comment_entity_state/comment_state.dart';
import 'package:my_social_app/state/app_state/store.dart';

class DisplayRepliesButtonWidget extends StatelessWidget {
  final CommentState comment;
  const DisplayRepliesButtonWidget({super.key,required this.comment});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        store.dispatch(GetNextPageCommentRepliesIfNoPageAction(commentId: comment.id));
        store.dispatch(ChangeRepliesVisibilityAction(commentId: comment.id, visibility: true));
      },
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 5),
            child: const Icon(Icons.reply,size: commentIconFontSize)
          ),
          Text(
            comment.numberOfReplies.toString(),
            style: const TextStyle(fontSize: commentTextFontSize),
          )
        ],
      ),
    );
  }
}