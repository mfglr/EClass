import 'package:my_social_app/services/question_service.dart';
import 'package:my_social_app/state/app_state/exam_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/home_page_state/actions.dart';
import 'package:my_social_app/state/app_state/question_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/state.dart';
import 'package:my_social_app/state/app_state/subject_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/topic_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/user_image_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/user_image_entity_state/user_image_state.dart';
import 'package:redux/redux.dart';

void getNextPageHomeQuestionsIfNoPageMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetNextPageHomeQuestionsIfNoPageAction){
    final pagination = store.state.homePageState.questions;
    if(pagination.isReadyForNextPage && !pagination.hasAtLeastOnePage){
      store.dispatch(const GetNextPageHomeQuestionsAction());
    }
  }
  next(action);
}
void getNextPageHomeQuestionsIfReadyMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetNextPageHomeQuestionsIfReadyAction){
    final questions = store.state.homePageState.questions;
    if(questions.isReadyForNextPage){
      store.dispatch(const GetNextPageHomeQuestionsAction());
    }
  }
  next(action);
}
void getNextPageHomeQuestionsMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetNextPageHomeQuestionsAction){
    final pagination = store.state.homePageState.questions;
    QuestionService()
      .getHomePageQuestions(pagination.next)
      .then((questions){
        store.dispatch(AddNextPageHomeQuestionsAction(questionIds: questions.map((e) => e.id)));
        store.dispatch(AddQuestionsAction(questions: questions.map((e) => e.toQuestionState())));
        store.dispatch(AddUserImagesAction(images: questions.map((e) => UserImageState.init(e.appUserId))));
        store.dispatch(AddExamsAction(exams: questions.map((e) => e.exam.toExamState())));
        store.dispatch(AddSubjectsAction(subjects: questions.map((e) => e.subject.toSubjectState())));
        store.dispatch(AddTopicsListAction(lists: questions.map((e) => e.topics.map((e) => e.toTopicState()))));
      });
  }
  next(action);
}
void getPrevPageHomePageQuestionsIfReadyMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetPrevPageHomePageQuestionsIfReadyAction){
    final pagination = store.state.homePageState.questions;
    if(pagination.isReadyForPrevPage){
      store.dispatch(const GetPrevPageHomeQuestionsAction());
    }
  }
  next(action);
}
void getPrevPageHomeQuestionsMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetPrevPageHomeQuestionsAction){
    final pagination = store.state.homePageState.questions;
    QuestionService()
      .getHomePageQuestions(pagination.prev)
      .then((questions){
        store.dispatch(AddPrevPageHomeQuestionsAction(questionIds: questions.map((e) => e.id)));
        store.dispatch(AddQuestionsAction(questions: questions.map((e) => e.toQuestionState())));
        store.dispatch(AddUserImagesAction(images: questions.map((e) => UserImageState.init(e.appUserId))));
        store.dispatch(AddExamsAction(exams: questions.map((e) => e.exam.toExamState())));
        store.dispatch(AddSubjectsAction(subjects: questions.map((e) => e.subject.toSubjectState())));
        store.dispatch(AddTopicsListAction(lists: questions.map((e) => e.topics.map((e) => e.toTopicState()))));
      });
  }
  next(action);
}