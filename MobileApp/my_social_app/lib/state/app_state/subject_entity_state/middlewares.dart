import 'package:my_social_app/constants/record_per_page.dart';
import 'package:my_social_app/services/question_service.dart';
import 'package:my_social_app/services/topic_service.dart';
import 'package:my_social_app/state/app_state/question_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/state.dart';
import 'package:my_social_app/state/app_state/subject_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/topic_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/user_image_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/user_image_entity_state/user_image_state.dart';
import 'package:redux/redux.dart';

void getNextPageSubjectQuestionsIfNoPageMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetNextPageSubjectQuestionsIfNoPageAction){
    final pagination = store.state.subjectEntityState.entities[action.subjectId]!.questions;
    if(!pagination.isLast && !pagination.hasAtLeastOnePage){
      store.dispatch(GetNextPageSubjectQuestionsAction(subjectId: action.subjectId));
    }
  }
  next(action);
}
void getNextPageSubjectQuestionsIfReadyMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetNextPageSubjectQuestionsIfReadyAction){
    final pagination = store.state.subjectEntityState.entities[action.subjectId]!.questions;
    if(pagination.isReadyForNextPage){
      store.dispatch(GetNextPageSubjectQuestionsAction(subjectId: action.subjectId));
    }
  }
  next(action);
}
void getNextPageSubjectQuestionsMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetNextPageSubjectQuestionsAction){
    final subject = store.state.subjectEntityState.entities[action.subjectId]!;
    if(!subject.questions.isLast){
      QuestionService()
        .getBySubjectId(action.subjectId,subject.questions.lastValue,questionsPerPage,true)
        .then((questions){
          store.dispatch(AddNextPageSubjectQuestionsAction(subjectId: action.subjectId,questions: questions.map((x) => x.id)));
          store.dispatch(AddQuestionsAction(questions: questions.map((e) => e.toQuestionState())));
          store.dispatch(AddUserImagesAction(images: questions.map((e) => UserImageState.init(e.appUserId))));
          store.dispatch(AddTopicsListAction(lists: questions.map((e) => e.topics.map((e) => e.toTopicState()))));
        });
    }
  }
  next(action);
}

void getTopicsOfSelectSubjectMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetTopicsOfSelectedSubjectAction){
    final subjectId = store.state.createQuestionState.subjectId!;
    final subjectState = store.state.subjectEntityState.entities[subjectId]!;
    if(!subjectState.topics.isLast){
      TopicService()
        .getBySubjectId(subjectId)
        .then((topics){
          store.dispatch(AddTopicsAction(topics: topics.map((e) => e.toTopicState())));
          store.dispatch(GetSubjectTopicsSuccessAction(subjectId: subjectId,topicIds: topics.map((e) => e.id)));
        });
    }
  }
  next(action);
}
void getSubjectTopicsMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetSubjectTopicsAction){
    final pagination = store.state.subjectEntityState.entities[action.subjectId]!.topics;
    if(!pagination.isLast){
      TopicService()
        .getBySubjectId(action.subjectId)
        .then((topics){
          store.dispatch(AddTopicsAction(topics: topics.map((e) => e.toTopicState())));
          store.dispatch(GetSubjectTopicsSuccessAction(subjectId: action.subjectId,topicIds: topics.map((e) => e.id)));
        });
    }
  }
  next(action);
}