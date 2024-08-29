import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_social_app/state/app_state/comment_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/comment_entity_state/comment_state.dart';
import 'package:my_social_app/state/app_state/state.dart';

class CommentLikeButtonWidget extends StatelessWidget {
  final CommentState comment;
  const CommentLikeButtonWidget({super.key,required this.comment});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        final store = StoreProvider.of<AppState>(context,listen: false);
        if(comment.isLiked){
          store.dispatch(DislikeCommentAction(commentId: comment.id));
        }
        else{
          store.dispatch(LikeCommentAction(commentId: comment.id));
        }
      },
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        minimumSize: WidgetStateProperty.all(const Size(0, 0)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            comment.isLiked ? Icons.favorite : Icons.favorite_outline,
            color: comment.isLiked ? Colors.red : null,
            size: 18,
          ),
          Text(
            comment.numberOfLikes.toString(),
            style: const TextStyle(
              fontSize: 11
            ),
          )
        ],
      )
    );
  }
}