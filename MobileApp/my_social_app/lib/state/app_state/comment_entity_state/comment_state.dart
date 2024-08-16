import 'package:my_social_app/state/app_state/pagination.dart';

class CommentState{
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userName;
  final int appUserId;
  final bool isEdited;
  final String content;
  final bool isLiked;
  final int numberOfLikes;
  final int numberOfReplies;
  final int? questionId;
  final int? solutionId;
  final int? parentId;
  final Pagination likes;
  final Pagination replies;
  final bool repliesVisibility;
  final int numberOfDisplayReplies;

  const CommentState({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userName,
    required this.appUserId,
    required this.isEdited,
    required this.content,
    required this.isLiked,
    required this.numberOfLikes,
    required this.numberOfReplies,
    required this.questionId,
    required this.solutionId,
    required this.parentId,
    required this.likes,
    required this.replies,
    required this.repliesVisibility,
    required this.numberOfDisplayReplies
  });

  String get formatContent => content.length > 100 ? "${content.substring(0,100)}..." : content;
  int get numberOfNotDisplayedReplies => numberOfReplies - numberOfDisplayReplies;

  CommentState getNextPageLikes()
    => CommentState(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        userName: userName,
        appUserId: appUserId,
        isEdited: isEdited,
        content: content,
        isLiked: isLiked,
        numberOfLikes: numberOfLikes,
        numberOfReplies: numberOfReplies,
        questionId: questionId,
        solutionId: solutionId,
        parentId: parentId,
        likes: likes.startLoading(),
        replies: replies,
        repliesVisibility: repliesVisibility,
        numberOfDisplayReplies: numberOfDisplayReplies
      );
  CommentState addNextPageLikes(Iterable<int> nextIds)
    => CommentState(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        userName: userName,
        appUserId: appUserId,
        isEdited: isEdited,
        content: content,
        isLiked: isLiked,
        numberOfLikes: numberOfLikes,
        numberOfReplies: numberOfReplies,
        questionId: questionId,
        solutionId: solutionId,
        parentId: parentId,
        likes: likes.appendNextPage(nextIds),
        replies: replies,
        repliesVisibility: repliesVisibility,
        numberOfDisplayReplies: numberOfDisplayReplies
      );
  CommentState like(int userId)
    => CommentState(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        appUserId: appUserId,
        userName: userName,
        questionId: questionId,
        isEdited: isEdited,
        content: content,
        numberOfLikes: numberOfLikes + 1,
        likes: likes.prependOne(id),
        isLiked: true,
        replies: replies,
        numberOfReplies: numberOfReplies,
        parentId: parentId,
        solutionId: solutionId,
        repliesVisibility: repliesVisibility,
        numberOfDisplayReplies: numberOfDisplayReplies
      );
  CommentState dislike(int userId)
    => CommentState(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        appUserId: appUserId,
        userName: userName,
        questionId: questionId,
        isEdited: isEdited,
        content: content,
        numberOfLikes: numberOfLikes - 1,
        likes: likes.removeOne(id),
        isLiked: false,
        replies: replies,
        numberOfReplies: numberOfReplies,
        parentId: parentId,
        solutionId: solutionId,
        repliesVisibility: repliesVisibility,
        numberOfDisplayReplies: numberOfDisplayReplies
      );

  CommentState addReply(int replyId)
    => CommentState(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        appUserId: appUserId,
        userName: userName,
        questionId: questionId,
        isEdited: isEdited,
        content: content,
        numberOfLikes: numberOfLikes,
        likes: likes,
        isLiked: isLiked,
        replies: replies.prependOne(replyId),
        numberOfReplies: numberOfReplies + 1,
        parentId: parentId,
        solutionId: solutionId,
        repliesVisibility: true,
        numberOfDisplayReplies: numberOfDisplayReplies + 1
      );
  
  CommentState nextPageReplies()
    => CommentState(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        appUserId: appUserId,
        userName: userName,
        questionId: questionId,
        isEdited: isEdited,
        content: content,
        numberOfLikes: numberOfLikes,
        likes: likes,
        isLiked: isLiked,
        replies: replies.startLoading(),
        numberOfReplies: numberOfReplies,
        parentId: parentId,
        solutionId: solutionId,
        repliesVisibility: repliesVisibility,
        numberOfDisplayReplies: numberOfDisplayReplies
      );
  
  CommentState addNextPageReplies(Iterable<int> replyIds)
    => CommentState(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        appUserId: appUserId,
        userName: userName,
        questionId: questionId,
        isEdited: isEdited,
        content: content,
        numberOfLikes: numberOfLikes,
        likes: likes,
        isLiked: isLiked,
        replies: replies.appendNextPage(replyIds),
        numberOfReplies: numberOfReplies,
        parentId: parentId,
        solutionId: solutionId,
        repliesVisibility: repliesVisibility,
        numberOfDisplayReplies: repliesVisibility ? numberOfDisplayReplies + replyIds.length : numberOfDisplayReplies
      );
    

  CommentState changeVisibility(bool visibility)
    => CommentState(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        appUserId: appUserId,
        userName: userName,
        questionId: questionId,
        isEdited: isEdited,
        content: content,
        numberOfLikes: numberOfLikes,
        likes: likes,
        isLiked: isLiked,
        replies: replies,
        numberOfReplies: numberOfReplies,
        parentId: parentId,
        solutionId: solutionId,
        repliesVisibility: visibility,
        numberOfDisplayReplies: visibility ? replies.ids.length : 0
      );

    
}