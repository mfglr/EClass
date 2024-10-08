import 'package:my_social_app/exceptions/backend_exception.dart';
import 'package:my_social_app/services/comment_service.dart';
import 'package:my_social_app/state/app_state/comment_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/comment_entity_state/middlewares.dart';
import 'package:my_social_app/state/app_state/create_comment_state/actions.dart';
import 'package:my_social_app/state/app_state/question_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/solution_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/state.dart';
import 'package:redux/redux.dart';

void createCommentMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is CreateCommentAction){
    final state = store.state.createCommentState;
    final questionId = state.comment != null ? null : state.question?.id;
    final solutionId = state.comment != null ? null : state.solution?.id;
    final repliedId = state.comment?.id;

    CommentService()
      .createComment(state.content,questionId,solutionId,repliedId)
      .then((comment){
        store.dispatch(AddCommentAction(comment: comment.toCommentState()));
        if(questionId != null){
          store.dispatch(AddQuestionCommentAction(questionId: state.question!.id,commenId: comment.id));
        }
        else if(solutionId != null){
          store.dispatch(AddSolutionCommentAction(solutionId: state.solution!.id,commentId: comment.id));
        }
        else if(repliedId != null){
          store.dispatch(AddCommentReplyAction(commentId: comment.parentId!,replyId: comment.id));
        }
        store.dispatch(const CreateCommentSuccessAction());
      })
      .catchError((e){
        if(e is BackendException && e.statusCode == 404){
          if(state.comment != null){
            removeCommentDispathcer(store,state.comment!);
          }
        }
        store.dispatch(const CancelReplyAction());
        throw e;
      });
  }
  next(action);
}