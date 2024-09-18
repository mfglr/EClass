import 'package:flutter/material.dart';
import 'package:my_social_app/state/app_state/actions.dart';
import 'package:my_social_app/state/app_state/comment_entity_state/comment_state.dart';

@immutable
class LoadCommentAction extends AppAction{
  final int commentId;
  const LoadCommentAction({required this.commentId});
}
@immutable
class LoadCommentsAction extends AppAction{
  final Iterable<int> commentIds;
  const LoadCommentsAction({required this.commentIds});
}
@immutable
class AddCommentAction extends AppAction{
  final CommentState comment;
  const AddCommentAction({required this.comment});
}
@immutable
class RemoveCommentAction extends AppAction{
  final CommentState comment;
  const RemoveCommentAction({required this.comment});
}
@immutable
class RemoveCommentSuccessAction extends AppAction{
  final int commentId;
  const RemoveCommentSuccessAction({required this.commentId});
}
@immutable
class AddCommentsAction extends AppAction{
  final Iterable<CommentState> comments;
  const AddCommentsAction({required this.comments});
}


@immutable
class GetNextPageCommentLikesIfNoPageAction extends AppAction{
  final int commentId;
  const GetNextPageCommentLikesIfNoPageAction({required this.commentId});
}
@immutable
class GetNextPageCommentLikesIfReadyAction extends AppAction{
  final int commentId;
  const GetNextPageCommentLikesIfReadyAction({required this.commentId});
}
@immutable
class GetNextPageCommentLikesAction extends AppAction{
  final int commentId;
  const GetNextPageCommentLikesAction({required this.commentId});
}
@immutable
class AddNextPageCommentLikesAction extends AppAction{
  final int commentId;
  final Iterable<int> likeIds;
  const AddNextPageCommentLikesAction({required this.commentId, required this.likeIds});
}
@immutable
class LikeCommentAction extends AppAction{
  final int commentId;
  const LikeCommentAction({required this.commentId});
}
@immutable
class LikeCommentSuccessAction extends AppAction{
  final int commentId;
  final int likeId;
  const LikeCommentSuccessAction({required this.commentId,required this.likeId});
}
@immutable
class DislikeCommentAction extends AppAction{
  final int commentId;
  const DislikeCommentAction({required this.commentId});
}
@immutable
class DislikeCommentSuccessAction extends AppAction{
  final int commentId;
  final int likeId;
  const DislikeCommentSuccessAction({required this.commentId,required this.likeId});
}
@immutable
class AddNewCommentLikeAction extends AppAction{
  final int commentId;
  final int likeId;
  const AddNewCommentLikeAction({required this.commentId, required this.likeId});
}

@immutable
class ChangeRepliesVisibilityAction extends AppAction{
  final int commentId;
  final bool visibility;
  const ChangeRepliesVisibilityAction({required this.commentId, required this.visibility});
}


@immutable
class GetNextPageCommentRepliesIfNoPageAction extends AppAction{
  final int commentId;
  const GetNextPageCommentRepliesIfNoPageAction({required this.commentId});
}
@immutable
class GetNextPageCommentRepliesIfReadyAction extends AppAction{
  final int commentId;
  const GetNextPageCommentRepliesIfReadyAction({required this.commentId});
}
@immutable
class GetNextPageCommentRepliesAction extends AppAction{
  final int commentId;
  const GetNextPageCommentRepliesAction({required this.commentId});
}
@immutable
class AddPrevPageCommentRepliesAction extends AppAction{
  final int commentId;
  final Iterable<int> replyIds;
  const AddPrevPageCommentRepliesAction({required this.commentId, required this.replyIds});
}
@immutable
class AddCommentReplyAction extends AppAction{
  final int commentId;
  final int replyId;
  const AddCommentReplyAction({required this.replyId, required this.commentId});
}
@immutable
class RemoveCommentReplyAction extends AppAction{
  final int commentId;
  final int replyId;
  const RemoveCommentReplyAction({required this.commentId, required this.replyId});
}
@immutable
class AddNewCommentReplyAction extends AppAction{
  final int commentId;
  final int replyId;
  const AddNewCommentReplyAction({required this.commentId, required this.replyId});
}