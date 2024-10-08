import 'package:my_social_app/services/question_service.dart';
import 'package:my_social_app/services/subject_service.dart';
import 'package:my_social_app/state/app_state/exam_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/question_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/state.dart';
import 'package:my_social_app/state/app_state/subject_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/topic_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/user_image_entity_state/actions.dart';
import 'package:my_social_app/state/app_state/user_image_entity_state/user_image_state.dart';
import 'package:redux/redux.dart';

void getNextPageOfExamQuestionsIfNoPageMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetNextPageExamQuestionsIfNoPageAction){
    final pagination = store.state.examEntityState.entities[action.examId]!.questions;
    if(pagination.isReadyForNextPage && !pagination.hasAtLeastOnePage){
      store.dispatch(GetNextPageExamQuestionsAction(examId: action.examId));
    }
  }
  next(action);
}
void getNextPageExamQuestionsIfReadyMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetNextPageExamQuestionsIfReadyAction){
    final pagination = store.state.examEntityState.entities[action.examId]!.questions;
    if(pagination.isReadyForNextPage){
      store.dispatch(GetNextPageExamQuestionsAction(examId: action.examId));
    }
  }
  next(action);
}
void getNextPageExamQeuestionsMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetNextPageExamQuestionsAction){
    final pagination = store.state.examEntityState.entities[action.examId]!.questions;
    QuestionService()
      .getByExamId(action.examId,pagination.next)
      .then((questions){
        store.dispatch(AddNextPageExamQuestionsAction(examId: action.examId,questionIds: questions.map((x) => x.id)));
        store.dispatch(AddQuestionsAction(questions: questions.map((e) => e.toQuestionState())));
        store.dispatch(AddUserImagesAction(images: questions.map((e) => UserImageState.init(e.appUserId))));
        store.dispatch(AddExamsAction(exams: questions.map((e) => e.exam.toExamState())));
        store.dispatch(AddSubjectsAction(subjects: questions.map((e) => e.subject.toSubjectState())));
        store.dispatch(AddTopicsListAction(lists: questions.map((e) => e.topics.map((e) => e.toTopicState()))));
      });
  }
  next(action);
}
void getPrevPageExamQuestionsIfReadyMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetPrevPageExamQuestionsIfReadyAction){
    final pagination = store.state.exams;
    if(pagination.isReadyForPrevPage){
      store.dispatch(GetPrevPageExamQuestionsAction(examId: action.examId));
    }
  }
  next(action);
}
void getPrevPageExamQuestionsMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetPrevPageExamQuestionsAction){
    final pagination = store.state.examEntityState.entities[action.examId]!.questions;
    QuestionService()
      .getByExamId(action.examId, pagination.prev)
      .then((questions){
        store.dispatch(AddPrevPageExamQuestionsAction(examId: action.examId,questionIds: questions.map((x) => x.id)));
        store.dispatch(AddQuestionsAction(questions: questions.map((e) => e.toQuestionState())));
        store.dispatch(AddUserImagesAction(images: questions.map((e) => UserImageState.init(e.appUserId))));
        store.dispatch(AddExamsAction(exams: questions.map((e) => e.exam.toExamState())));
        store.dispatch(AddSubjectsAction(subjects: questions.map((e) => e.subject.toSubjectState())));
        store.dispatch(AddTopicsListAction(lists: questions.map((e) => e.topics.map((e) => e.toTopicState()))));
      });
  }
  next(action);
}

void getNextPageExamSubjectsIfNoPageMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetNextPageExamSubjectsIfNoPageAction){
    final pagination = store.state.examEntityState.entities[action.examId]!.subjects;
    if(pagination.isReadyForNextPage && !pagination.hasAtLeastOnePage){
      store.dispatch(GetNextPageExamSubjectsAction(examId: action.examId));
    }
  }
  next(action);
}
void getNextPageExamSubjectsMiddleware(Store<AppState> store,action,NextDispatcher next){
  if(action is GetNextPageExamSubjectsAction){
    final pagination = store.state.examEntityState.entities[action.examId]!.subjects;
    SubjectService()
      .getByExamId(action.examId,pagination.next)
      .then((subjects){
        store.dispatch(AddSubjectsAction(subjects: subjects.map((e) => e.toSubjectState())));
        store.dispatch(AddNextPageExamSubjectsAction(examId: action.examId,subjectIds: subjects.map((e) => e.id)));
      });
  }
  next(action);
}
