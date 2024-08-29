import 'package:my_social_app/state/app_state/comment_user_like_state/comment_user_like_state.dart';
import 'package:my_social_app/state/app_state/entity_state.dart';

class CommentUserLikeEntityState extends EntityState<CommentUserLikeState>{
  const CommentUserLikeEntityState({required super.entities});

  CommentUserLikeEntityState addLikes(Iterable<CommentUserLikeState> likes)
    => CommentUserLikeEntityState(entities: appendMany(likes));
  CommentUserLikeEntityState addLike(CommentUserLikeState like)
    => CommentUserLikeEntityState(entities: appendOne(like));
  CommentUserLikeEntityState removeLike(int likeId)
    => CommentUserLikeEntityState(entities: removeOne(likeId));
}